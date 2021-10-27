import 'package:flutter/material.dart';
import 'util/propertiesUtil.dart';
import 'testjson.dart';

void main() async {
  //Load parameters;
  PropertiesUtil.loadMap().whenComplete(() {
    print("Complete");
    runApp(MyApp());
  });

  print("Started MyApp");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: PostsPage(),
      home: TestJsonPage(),
    );
  }
}
