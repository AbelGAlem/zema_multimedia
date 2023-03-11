import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:zema_multimedia/Models/AlbumModel.dart';
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

  List NewAlbumsList = [];
  List NewMusicList = [];
  List NewArtistList = [];

  // Get New Albums
  Future<dynamic> getNewAlbumAPI(String url) async {
  try {
    final response = await http.get(Uri.parse(url),headers: header);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      setState(() {
        NewAlbumsList = result['results'];
      });
    } else {
      print('Error fetching JSON fro $url: ${response.reasonPhrase} ---------------------------- ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching JSON from $url: $e iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
    return null;
  }
}

Future<dynamic> getNewMusicAPI(String url) async {
  try {
    final response = await http.get(Uri.parse(url),headers: header);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      //print(result['results']);
      setState(() {
        NewMusicList = result['results'];
      });
    } else {
      print('Error fetching JSON from $url: ${response.reasonPhrase}');
      return null;
    }
  } catch (e) {
    print('Error fetching JSON from the $url: $e');
    return null;
  }
}

Future<dynamic> getArtistsAPI(String url) async {
  try {
    final response = await http.get(Uri.parse(url),headers: header);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      //print(result['results']);
      setState(() {
        NewArtistList = result['results'];
      });
    } else {
      print('Error fetching JSON from $url: ${response.reasonPhrase}');
      return null;
    }
  } catch (e) {
    print('Error fetching JSON from $url: $e');
    return null;
  }
}

  Future<void> _playAudio(String audioURL) async {
    await _audioPlayer.play(UrlSource(audioURL));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewAlbumAPI('http://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/albums');
    getNewMusicAPI('http://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/tracks?page=1&page_size=7');
    getArtistsAPI('http://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/artists?page=2&page_size=5');
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      //height: getScreenHeightOfContext(context),
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Expanded(
        child: Stack(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("New Albums", style: header18,),
                      const SizedBox(height: 16,),
                      // New Albums
                      Container(
                        height: 200,
                        child: NewAlbumsList.isEmpty ? CircularLoading() : 
                        ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: NewAlbumsList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: NewAlbumCard(
                                AlbumName: NewAlbumsList[index]['album_name'], 
                                ArtistName: NewAlbumsList[index]['artist_name'], 
                                ImageURL: NewAlbumsList[index]['album_coverImage'],
                                
                              ),
                            );
                          },
                        )
                      ),
      
                      // New Music
                      const SizedBox(height: 24,),
                      Text("New Music", style: header18,),
                      const SizedBox(height: 16,),
                      Container(
                        height: 200,
                        child: NewAlbumsList.isEmpty ? CircularLoading() : 
                        ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: NewMusicList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                print(NewMusicList[index]['track_audioFile']);
                                _playAudio(NewMusicList[index]['track_audioFile']);
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: NewMusicCard(
                                  ArtistName: NewMusicList[index]['artist_name'], 
                                  TrackName: NewMusicList[index]['track_name'], 
                                  ImageURL: NewMusicList[index]['track_coverImage'],
                                  TrackID:  NewMusicList[index]['id'],
                                  ),
                              ),
                            );
                          },
                        )
                      ),
      
                      // New Artists
                      const SizedBox(height: 24,),
                      Text("New Artists", style: header18,),
                      const SizedBox(height: 16,),
                      Container(
                        height: 200,
                        child: NewAlbumsList.isEmpty ? CircularLoading() : 
                        ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: NewArtistList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: NewArtistCard(
                                ArtistName: NewArtistList[index]['artist_name'], 
                                ImageURL: NewArtistList[index]['artist_profileImage']),
                            );
                          },
                        )
                      ),
                      const SizedBox(height: 136,),
                      
                    ],
                  ),
                ],
              )
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 100,
                width: getScreenWidthOfContext(context),
                color: Color.fromARGB(255, 0, 0, 0),
              )
            )
          ],
        ),
      )
    );
  }
}
