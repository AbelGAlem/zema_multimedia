import 'package:flutter/material.dart';
import 'package:zema_multimedia/Shared/Themes.dart';


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

  NewMusicCard({super.key, required this.ArtistName, required this.TrackName, required this.ImageURL});

  @override
  State<NewMusicCard> createState() => _NewMusicCardState();
}

class _NewMusicCardState extends State<NewMusicCard> {
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
                Icon(Icons.favorite_border_outlined)
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

  FavoritesListCard({super.key, required this.ArtistName, required this.TrackTitle});

  @override
  State<FavoritesListCard> createState() => _FavoritesListCardState();
}

class _FavoritesListCardState extends State<FavoritesListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage("assets/images/placeholder.png"),
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
          Icon(Icons.favorite,color: Colors.white,)
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