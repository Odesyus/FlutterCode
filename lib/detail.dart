import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedScreen extends StatelessWidget {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailurl;
  DetailedScreen(
      {Key? key,
      required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnailurl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      child: Column(children: [
        Expanded(child: Text(title)),
        Expanded(child: Image.network(url)),
      ]),
    );
  }
}
