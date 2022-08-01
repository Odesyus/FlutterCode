import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_project/detail.dart';
import 'package:http/http.dart' as http;
import 'album.dart';
import 'api.dart';

List<bool> visib = [];

class ListWidget extends StatelessWidget {
  const ListWidget({
    Key? key,
    required this.futureAlbum,
  }) : super(key: key);

  final Future<List<Album>> futureAlbum;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Album>>(
      future: futureAlbum,
      builder: (context, snapshot) {
        visib = List.filled(snapshot.data?.length ?? 0, true);
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) => StatefullContainer(
              index: index,
              snapshot: snapshot,
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class StatefullContainer extends StatefulWidget {
  const StatefullContainer({
    Key? key,
    required this.snapshot,
    required this.index,
  }) : super(key: key);

  final AsyncSnapshot<List<Album>> snapshot;
  final int index;

  @override
  State<StatefullContainer> createState() => _StatefullContainerState();
}

class _StatefullContainerState extends State<StatefullContainer> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visib[widget.snapshot.data![widget.index].id],
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailedScreen(
                  albumId: widget.snapshot.data![widget.index].albumId,
                  id: widget.snapshot.data![widget.index].id,
                  thumbnailurl:
                      widget.snapshot.data![widget.index].thumbnailUrl,
                  title: widget.snapshot.data![widget.index].title,
                  url: widget.snapshot.data![widget.index].url,
                ),
              ));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 167, 64, 236),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "${widget.snapshot.data![widget.index].id}",
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 200),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 173, 91, 228)),
                        onPressed: () {
                          visib[widget.snapshot.data![widget.index].id] = false;
                          setState(() {});
                        },
                        child: const Icon(Icons.delete)),
                  ),
                ],
              ),
              Text(
                widget.snapshot.data![widget.index].title,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Album>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 169, 64, 255),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Fetch Data'),
        ),
        body: ListWidget(futureAlbum: futureAlbum),
      ),
    );
  }
}

void main() => runApp(const MyApp());
