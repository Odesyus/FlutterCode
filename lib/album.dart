import 'dart:convert';

List<Album> AlbumFromJson(String str) =>
    List<Album>.from(json.decode(str).map((x) => Album.fromMap(x)));

class Album {
  Album({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  factory Album.fromMap(Map<String, dynamic> json) => Album(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );
}
