import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zema_multimedia/Shared/Themes.dart';
import 'package:zema_multimedia/Shared/Widgets.dart';
import 'package:http/http.dart' as http;

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({super.key});

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  var header = {
    'accept': 'application/json',
    'X-CSRFToken': 'Lz9hzyfR5JY1hI7qLlIkEr8zDYvUVVDizbKfhxwtZG789J5SNVEQH4oplpkwxTDl',
  };

  List NewAlbumsList = [];

    // Get New Albums
  Future<dynamic> getNewAlbumAPI(String url) async {
  try {
    final response = await http.get(Uri.parse(url),headers: header);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      //print(result['results']);
      setState(() {
        NewAlbumsList = result['results'];
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewAlbumAPI('http://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/albums?page=1&page_size=15');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("All Albums", style: header18,),
          const SizedBox(height: 38,),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: NewAlbumsList.isEmpty ? CircularLoading() : 
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 10
                  ),
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: NewAlbumsList.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    child: NewAlbumsList.isEmpty ? CircularLoading() : 
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: NewMusicCard(
                        ArtistName: NewAlbumsList[index]['album_name'], 
                        TrackName: NewAlbumsList[index]['artist_name'],
                        ImageURL: NewAlbumsList[index]['album_coverImage'],
                        TrackID: NewAlbumsList[index]['id'],
                      ),
                    ),
                  );
                },
              ),
          )
        ],
      ),
    );
  }
}