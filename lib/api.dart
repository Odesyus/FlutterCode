import 'dart:convert';
import 'package:http/http.dart' as http;
import 'album.dart';
import 'package:flutter/material.dart';

Future<List<Album>> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Album>((json) => Album.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}
