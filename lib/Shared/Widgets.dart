import 'package:flutter/material.dart';
import 'package:zema_multimedia/Shared/Themes.dart';
import 'package:http/http.dart' as http;


class NewAlbumCard extends StatefulWidget {
  String AlbumName;
  String ArtistName;
  String ImageURL;

  NewAlbumCard({super.key, required this.AlbumName, required this.ArtistName,required this.ImageURL });

  @override
  State<NewAlbumCard> createState() => _NewAlbumCardState();
}

class _NewAlbumCardState extends State<NewAlbumCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getScreenWidthOfContext(context) * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: cardRadiusShadow,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(widget.ImageURL, width: getScreenWidthOfContext(context) * 0.7,
                        height: getScreenWidthOfContext(context) * 0.32,fit: BoxFit.cover,),
            )
          ),
          const SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.AlbumName, style: header14,),
                  const SizedBox(height: 8,),
                  Text(widget.ArtistName,style: header10,)
                ],
              ),
              Icon(Icons.drag_indicator_sharp)
            ],
          )
        ],
      ),
    );
  }
}

class NewMusicCard extends StatefulWidget {
  String TrackName;
  String ArtistName;
  String ImageURL;
  int TrackID;

  NewMusicCard({super.key, required this.ArtistName, required this.TrackName, required this.ImageURL,required this.TrackID});

  @override
  State<NewMusicCard> createState() => _NewMusicCardState();
}

class _NewMusicCardState extends State<NewMusicCard> {
  var header = {
    'accept': 'application/json',
    'Content-Type': 'application/json',
    'X-CSRFToken': 'Lz9hzyfR5JY1hI7qLlIkEr8zDYvUVVDizbKfhxwtZG789J5SNVEQH4oplpkwxTDl',
  };
    var headers = {
    'accept': 'application/json',
    'X-CSRFToken': 'jIgxc8zID18s8GDz8VGYQGHzKzApGF2QXFTfN52nK6ft8F3NBO0Xq1fukLdvpQx1',
  };

  bool isFavorite = false;

  Future<dynamic> addToFavoritesAPI(String userFUI, String trackID) async {
    try {
        var data = '{\n  "user_FUI": "${userFUI}",\n  "track_id": ${trackID}\n}';
        var url = Uri.parse('https://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/favourites');
        var res = await http.post(url, headers: header, body: data);
        //print(res.body);
        if (res.statusCode != 200) throw Exception('http.post error: statusCode= ${res.statusCode}');
    } catch (e) {
      print('Error fetchin JSON from: $e');
      return null;
    }
  }

  Future<dynamic> deleteToFavoritesAPI(String trackID) async {
    try {
        var url = Uri.parse('https://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/favourites/6');
        print('${url.data} ${url}');
        var res = await http.delete(url, headers: headers);
        if (res.statusCode != 200) throw Exception('http.posts error: statusCode= ${res.statusCode}');
    } catch (e) {
      print('Error fetching JSON froms: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getScreenWidthOfContext(context) * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: cardRadiusShadow,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(widget.ImageURL,width: getScreenWidthOfContext(context) * 0.3,
                        height: getScreenWidthOfContext(context) * 0.29,fit: BoxFit.cover,),
            )
          ),
          const SizedBox(height: 8,),
          Container(
            width: getScreenWidthOfContext(context) * 0.3,
            padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.TrackName, style: header10,),
                    const SizedBox(height: 4,),
                    Text(widget.ArtistName,style: header10.copyWith(fontSize: 8),)
                  ],
                ),
                InkWell(
                  onTap: () {
                    if(isFavorite == true){
                      /*int num = widget.TrackID - 1;
                      deleteToFavoritesAPI(widget.TrackID.toString());
                      setState(() {
                        isFavorite = false;
                      });*/
                    }else{
                      addToFavoritesAPI("AbelAlem", widget.TrackID.toString());
                      setState(() {
                        isFavorite = true;
                      });
                    }
                  },
                  child: isFavorite ? 
                    InkWell(child: Icon(Icons.favorite, color: Colors.red,)) : 
                    InkWell(child: Icon(Icons.favorite_border_outlined)) 
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class NewArtistCard extends StatefulWidget {
  String ArtistName;
  String ImageURL;

  NewArtistCard({super.key, required this.ArtistName,required this.ImageURL });

  @override
  State<NewArtistCard> createState() => _NewArtistCardState();
}

class _NewArtistCardState extends State<NewArtistCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getScreenWidthOfContext(context) * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: circularCardRadiusShadow,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(68),
              child: Image.network(widget.ImageURL,width: getScreenWidthOfContext(context) * 0.3,
                        height: getScreenWidthOfContext(context) * 0.29,fit: BoxFit.cover,),
            )
          ),
          const SizedBox(height: 8,),
          Text(widget.ArtistName, style: header14,),
        ],
      ),
    );
  }
}

class FavoritesListCard extends StatefulWidget {
  String TrackTitle;
  String ArtistName;
  String ImageURL;
  int TrackID;

  FavoritesListCard({super.key, required this.ArtistName, required this.TrackTitle, required this.ImageURL, required this.TrackID });

  @override
  State<FavoritesListCard> createState() => _FavoritesListCardState();
}

class _FavoritesListCardState extends State<FavoritesListCard> {
  var header = {
    'accept': 'application/json',
    'X-CSRFToken': 'Lz9hzyfR5JY1hI7qLlIkEr8zDYvUVVDizbKfhxwtZG789J5SNVEQH4oplpkwxTDl',
  };
  
  Future<dynamic> deleteToFavoritesAPI(String trackID) async {
    try {
        var url = Uri.parse('http://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/favourites/${trackID}');
        var res = await http.delete(url, headers: header);
        if (res.statusCode != 200) throw Exception('http.post error: statusCode= ${res.statusCode}');
    } catch (e) {
      print('Error fetching JSON from: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage("https://zemastroragev100.blob.core.windows.net/zemacontainer/${widget.ImageURL}")
              ),
              const SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.TrackTitle,style: header18,),
                  SizedBox(height: 2,),
                  Text(widget.ArtistName,style: header10.copyWith(fontWeight: FontWeight.w600),)
                ],
              )
            ],
          ),
          InkWell(
            onTap: () {
              print("trying");
              deleteToFavoritesAPI(widget.TrackID.toString());
              setState(() {
                
              });
            },
            child: Icon(Icons.favorite,color: Colors.white,))
        ],
      ),
    );
  }
}

class CircularLoading extends StatelessWidget {
  const CircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
            child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColorLight,
            ),
          ));
  }
}