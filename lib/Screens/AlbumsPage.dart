import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zema_multimedia/Shared/Themes.dart';
import 'package:zema_multimedia/Shared/Widgets.dart';
import 'package:http/http.dart' as http;

import '../Providers/AlbumProvider.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({super.key});

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {

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
                    // New Albums------------------------------------------------------------------------
          FutureBuilder(
            future: AlbumProvider().getNewAlbumAPI(),
            builder: (context, snapshot) {              
              if(snapshot.connectionState == ConnectionState.waiting){
                return Container(height: 200,child: const CircularLoading());
              }else if(snapshot.hasData){
                final NewAlbumsList = snapshot.data;
                return Container(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child:  
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
                          child: AlbumCard(
                            ArtistName: NewAlbumsList[index]['album_name'], 
                            TrackName: NewAlbumsList[index]['artist_name'],
                            ImageURL: NewAlbumsList[index]['album_coverImage'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
          const SizedBox(height: 24,)
        ],
      ),
    );
  }
}