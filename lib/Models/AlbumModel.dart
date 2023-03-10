class AlbumModel {
  int id;
  String album_name;
  String album_description;
  String album_coverImage;
  String artist_name;
 
AlbumModel({required this.artist_name,required this.album_description,required this.album_coverImage,required this.album_name,required this.id});

  Map<String, dynamic> toJson() => {
        'id': id,
        'album_name': album_name,
        'album_description':  album_description,
        'album_coverImage':  album_coverImage,
        'artist_name' :  artist_name,
      };

  factory AlbumModel.fromJson(Map<String, dynamic> jsonData) =>
      AlbumModel(
        id: jsonData['id'],
        album_name: jsonData['album_name'].toString(),
        album_description: jsonData['album_description'],
        album_coverImage: jsonData['album_coverImage'],
        artist_name: jsonData['artist_name'],

      );
}
