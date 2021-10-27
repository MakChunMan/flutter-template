import 'package:flutter/material.dart';
import 'util/propertiesUtil.dart';
import 'testjson.dart';
import 'dart:async';

Future<void> main() async {
  //Load parameters;
  Future a = PropertiesUtil.loadMap();
  a.then((s) => print('Load param:' + s)).catchError(() => print('Error')).whenComplete(() {
    print('Complete');
    runApp(MyApp());
    print("Started MyApp:" + PropertiesUtil.propertiesMap.length.toString());
  });
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
