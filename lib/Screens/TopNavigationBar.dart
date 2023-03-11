import 'package:flutter/material.dart';
import 'package:zema_multimedia/Screens/AlbumsPage.dart';
import 'package:zema_multimedia/Screens/ExplorePage.dart';
import 'package:zema_multimedia/Screens/FavoritesPage.dart';
import 'package:zema_multimedia/Shared/Themes.dart';

class TopNavigationBar extends StatefulWidget {
  const TopNavigationBar({super.key});

  @override
  State<TopNavigationBar> createState() => _TopNavigationBarState();
}

class _TopNavigationBarState extends State<TopNavigationBar> {

  int pageNumber = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: getScreenHeightOfContext(context),
        color: BackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          // Top App bar
          Container(
            color: TabColor,
            padding: EdgeInsets.fromLTRB(42, 8, 42, 8),
            height: getScreenWidthOfContext(context) * 0.13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      pageNumber = 0;
                    });
                  },
                  child: pageNumber == 0 ? 
                    Container(decoration: normalRadius,padding: EdgeInsets.fromLTRB(12, 4, 12, 4), child: Text("Explore", style: header12,)) 
                    : Text("Explore", style: header12.copyWith(color: Colors.white),)
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      pageNumber = 1;
                    });
                  },
                  child: pageNumber == 1 ? 
                    Container(decoration: normalRadius, padding: EdgeInsets.fromLTRB(12, 4, 12, 4), child: Text("Albums", style: header12,)) 
                    : Text("Albums", style: header12.copyWith(color: Colors.white),)
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      pageNumber = 2;
                    });
                  },
                  child: pageNumber == 2 ? 
                    Container(decoration: normalRadius, padding: EdgeInsets.fromLTRB(12, 4, 12, 4), child: Text("Favorites", style: header12,)) 
                    : Text("Favorites", style: header12.copyWith(color: Colors.white),)
                )
              ],
            ),
          ),
          const SizedBox(height: 16,),
        
          // Tab Main content
          Expanded(
            child: ListView(
              children: [
                if(pageNumber == 0)...[
                  ExplorePage()
                ]else if(pageNumber == 1)...[
                  AlbumsPage()
                ]else if(pageNumber == 2)...[
                  FavoritesPage()
                ]
              ],
            )
            )
          
        ],
          )
        ),
      )
    );
  }
}