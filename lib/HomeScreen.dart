import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _key =
      "563492ad6f91700001000001145c8b657a6a4c43ab00618da17373d7";
  List<Photo> photos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample App"),
        centerTitle: true,
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: photos.length,
        itemBuilder: (BuildContext context, index) {
          return Card(
            child: Column(
              children: [
                Image(
                  image: NetworkImage(photos[index].url),
                ),
                Text(photos[index].photographer)
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            getData();
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  getData() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated"),
        headers: {"Authorization": _key}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        Photo photo = Photo.fromJson(element);
        photos.add(photo);
      });

      setState(() {});
    });
  }

  @override
  initState() {
    getData();
    super.initState();
  }
}
