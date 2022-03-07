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
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample App"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: Text("Drawer Header"),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Option",
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Option",
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Option",
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Option",
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 9,
                      child: TextField(
                        controller: controller,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                          onPressed: () {
                            searchData(controller.text);
                            print(controller.text);
                          },
                          child: const Icon(Icons.search)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 11,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: photos.length,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {});
                          },
                          child: Image(
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            image: NetworkImage(photos[index].url),
                          ),
                        ),
                        // Text(photos[index].photographer)
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  getData() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated"),
        headers: {"Authorization": _key}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        Photo photo = Photo.fromJson(element);
        photos.add(photo);
      });

      setState(() {});
    });
  }

  searchData(String query) async {
    List<Photo> newPhotos = [];
    await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$query"),
        headers: {"Authorization": _key}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData['photos'].forEach((photoData) {
        Photo photo = Photo.fromJson(photoData);
        newPhotos.add(photo);
      });
    });
    photos = newPhotos;
    setState(() {});
  }

  @override
  initState() {
    getData();
    super.initState();
  }
}
