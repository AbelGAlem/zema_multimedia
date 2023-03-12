import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:zema_multimedia/Providers/AlbumProvider.dart';
import 'package:zema_multimedia/Providers/ArtistProvider.dart';
import 'package:zema_multimedia/Providers/TrackProvider.dart';
import 'package:zema_multimedia/Shared/Themes.dart';
import 'package:zema_multimedia/Shared/Widgets.dart';
import 'package:http/http.dart' as http;

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _audioPlayer = AudioPlayer();
  bool play = false;

  var header = {
    'accept': 'application/json',
    'X-CSRFToken': 'jIgxc8zID18s8GDz8VGYQGHzKzApGF2QXFTfN52nK6ft8F3NBO0Xq1fukLdvpQx1',
  };

  List FavoritesList = [];
  List FavoritesTrackIDList = [];

// get favorites list to show favorited tracks in explore page
Future<dynamic> getFavoritesListAPI(String url) async {
  try {
    final response = await http.get(Uri.parse(url),headers: header);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      //print(result['results']);
      setState(() {
        FavoritesList = result['results'];
      });
      for(dynamic each in FavoritesList){
        FavoritesTrackIDList.add(each['id']);
      }
      //print(FavoritesTrackIDList);

    } else {
      print('Error fetching JSON from $url: ${response.reasonPhrase}');
      return null;
    }
  } catch (e) {
    print('Error fetching JSON from $url: $e');
    return null;
  }
}

// play and pause function and dialog
void showPlayDialog(BuildContext context, String TrackName, String ArtistName, String ImageURL, String AudioURL) {
  showDialog(  
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return  AlertDialog(
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [                
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      ImageURL,
                      height: getScreenWidthOfContext(context) * 0.9,
                      width: getScreenWidthOfContext(context) * 0.7,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Text(TrackName,style: header18.copyWith(fontSize: 22),),
                  const SizedBox(height: 6,),
                  Text(ArtistName, style: header12.copyWith(fontWeight: FontWeight.w500),),
                  const SizedBox(height: 12,),
                  Container(
                    padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.skip_previous, size: 32,),
                        IconButton(
                          icon: play ? Icon(Icons.pause_circle,size: 42,) : Icon(Icons.play_circle,size: 42,),
                          onPressed: () {
                            if(play == false){
                              setState(() {
                                play = true;
                                _playAudio(AudioURL);
                              });
                            }else{
                              setState(() {
                                play = false;
                                _pauseAudio();
                              });
                            }
                          },
                        ),
                        Icon(Icons.skip_next,size: 32,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),
                ],
              ),
            ],
          );
        },);
    },
  );
}

Future<void> _playAudio(String audioURL) async {
    await _audioPlayer.play(UrlSource(audioURL));
  }

Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavoritesListAPI('http://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/favourites');
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("New Albums", style: header18,),
          const SizedBox(height: 16,),
          // New Albums------------------------------------------------------------------------
          FutureBuilder(
            future: AlbumProvider().getNewAlbumAPI(),
            builder: (context, snapshot) {              
              if(snapshot.connectionState == ConnectionState.waiting){
                return Container(height: 200,child: const CircularLoading());
              }else if(snapshot.hasData){
                final NewAlbumList = snapshot.data;
                return Container(
                  height: 200,
                  child:  
                  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: NewAlbumList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: NewAlbumCard(
                          AlbumName: NewAlbumList[index]['album_name'], 
                          ArtistName: NewAlbumList[index]['artist_name'], 
                          ImageURL: NewAlbumList[index]['album_coverImage'],                          
                        ),
                      );
                    },
                  )
                );
              }
              return Container();
            },
          ),

          // New Music -----------------------------------------------------------------------------
          const SizedBox(height: 24,),
          Text("New Music", style: header18,),
          const SizedBox(height: 16,),
          FutureBuilder(
            future: MusicProvider().getNewMusicAPI(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Container(height: 200,child: CircularLoading());
              }else{
                List newMusicList = snapshot.data;
                return Container(
                  height: 200,
                  child:
                  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: newMusicList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      bool isFavorited = FavoritesTrackIDList.contains(newMusicList[index]['id']);
                      //print(NewMusicList[index]['id']);
                      return InkWell(
                        onTap: (){
                          //print(NewMusicList[index]['track_audioFile']);
                          showPlayDialog(
                            context,
                            newMusicList[index]['track_name'],
                            newMusicList[index]['artist_name'],
                            newMusicList[index]['track_coverImage'],
                            newMusicList[index]['track_audioFile'] 
                          );
                          //_playAudio(NewMusicList[index]['track_audioFile']);
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: NewMusicCard(
                            ArtistName: newMusicList[index]['artist_name'], 
                            TrackName: newMusicList[index]['track_name'], 
                            ImageURL: newMusicList[index]['track_coverImage'],
                            TrackID:  newMusicList[index]['id'],
                            isFavorited: isFavorited,
                          ),
                        ),
                      );
                    },
                  )
                );
              }
            },
          ),

          // New Artists ------------------------------------------------------------------------------
          const SizedBox(height: 24,),
          Text("New Artists", style: header18,),
          const SizedBox(height: 16,),
          FutureBuilder(
            future: ArtistProvider().getNewArtistsAPI(),
            builder: (context, snapshot) {              
              if(snapshot.connectionState == ConnectionState.waiting){
                return Container(height: 200,child: const CircularLoading());
              }else if(snapshot.hasData){
                final newAlbumList = snapshot.data;
                return Container(
                  height: 200,
                  child:  
                  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: newAlbumList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: NewArtistCard(
                          ArtistName: newAlbumList[index]['artist_name'], 
                          ImageURL: newAlbumList[index]['artist_profileImage']),
                      );
                    },
                  )
                );
              }
              return Container();
            },
          ),
          const SizedBox(height: 16,),
          
        ],
      ),
    );
  }
}

