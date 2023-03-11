import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zema_multimedia/Shared/Themes.dart';
import 'package:zema_multimedia/Shared/Widgets.dart';
import 'package:http/http.dart' as http;

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  var header = {
    'accept': 'application/json',
    'X-CSRFToken': 'Lz9hzyfR5JY1hI7qLlIkEr8zDYvUVVDizbKfhxwtZG789J5SNVEQH4oplpkwxTDl',
  };

  List FavoritesList = [];

  Future<dynamic> getFavoritesListAPI(String url) async {
  try {
    final response = await http.get(Uri.parse(url),headers: header);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      print(result);
      setState(() {
        FavoritesList = result['results'];
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

Future<dynamic> addToFavoritesAPI(String userFUI, String trackID) async {
  try {
      var data = '{\n  "user_FUI": "${userFUI}",\n  "track_id": ${trackID}\n}';
      var url = Uri.parse('http://exam.calmgrass-743c6f7f.francecentral.azurecontainerapps.io/favourites');
      var res = await http.post(url, headers: header, body: data);
      if (res.statusCode != 200) throw Exception('http.post error: statusCode= ${res.statusCode}');
  } catch (e) {
    print('Error fetching JSON from: $e');
    return null;
  }
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
          Text("Favorites List", style: header18,),
          const SizedBox(height: 20,),
          Container(
            height: getScreenHeightOfContext(context),
            child: FavoritesList.isEmpty ? CircularLoading() : 
            ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: FavoritesList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: FavoritesListCard(
                    ArtistName: FavoritesList[index]['artist_name'], 
                    TrackTitle: FavoritesList[index]['track_name'],
                    ImageURL: FavoritesList[index]['track_coverImage'],
                    TrackID: FavoritesList[index]['id'],
                  ),
                );
              },
            )
          ),
        ],
      ),
    );
  }
}