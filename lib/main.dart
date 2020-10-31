import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map mapResponse;
  List listOfArticles;

  Future fetchData() async {
    http.Response response;
    response = await http.get(
        'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=6c3cbb6493ad403d92db483fc9459ac9');

    debugPrint(response.body);
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listOfArticles = mapResponse['articles'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fetch News api"),
        ),
        body: mapResponse == null
            ? Container()
            : ListView.builder(
                itemCount: listOfArticles == null ? 0 : listOfArticles.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: Column(children: <Widget>[
                    Text(
                      listOfArticles[index]['title'],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.network(listOfArticles[index]['urlToImage']),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      listOfArticles[index]['description'],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ]));
                }));
  }
}
