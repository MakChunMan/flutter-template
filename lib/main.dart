import 'package:flutter/material.dart';
import 'util/propertiesUtil.dart';
import 'util/dbUtil.dart';
import 'testjson.dart';
import 'dart:async';

Future<void> main() async {
  //Load parameters; TODO: To be replaced
  Future a = PropertiesUtil.loadMap();
  a.then((s) => print('Load param:' + s)).catchError(() => print('Error')).whenComplete(() {
    print('Complete');
    runApp(MyApp());
    print("Started MyApp:" + PropertiesUtil.propertiesMap.length.toString());
  });

  Future b = DBUtil.initDB();
  var loadPropertiesFuture = a;
  var loadDBFuture = b;
  Future.wait([
    loadPropertiesFuture,
    loadDBFuture
  ]).then((s) {
    print('Loading process completed');
    runApp(MyApp());
    print("Started MyApp:" + PropertiesUtil.propertiesMap.length.toString());
  }).catchError(() => print('Some error'));
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
