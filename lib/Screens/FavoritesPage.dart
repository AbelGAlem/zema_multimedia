import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zema_multimedia/Providers/FavouritesProvider.dart';
import 'package:zema_multimedia/Shared/Themes.dart';
import 'package:zema_multimedia/Shared/Widgets.dart';
import 'package:http/http.dart' as http;

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {


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
          FutureBuilder(
            future: FavouritesProvider().getFavoritesAPI(),
            builder: (context, snapshot) {              
              if(snapshot.connectionState == ConnectionState.waiting){
                return Container(height: 200,child: const CircularLoading());
              }else if(snapshot.hasData){
                final FavoritesList = snapshot.data;
                return Container(
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
                );
              }
              return Container();
            },
          ),
          
        ],
      ),
    );
  }
}