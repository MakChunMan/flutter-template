import 'package:flutter/material.dart';
//import 'package:flutlab_logcat/flutlab_logcat.dart';
import 'util/propertiesUtil.dart';
import 'util/dbUtil.dart';
import 'testjson.dart';
import 'dart:async';

Future<void> main() async {
  //init logging
  //FlutLabLogcat.init();

  //Load parameters; TODO: To be replaced
  Future a = PropertiesUtil.loadMap();
  /***
  a.then((s) => print('Load param:' + s)).catchError(() => print('Error')).whenComplete(() {
    print('Complete');
    runApp(MyApp());
    print("Started MyApp:" + PropertiesUtil.propertiesMap.length.toString());
  }); */

  var loadPropertiesFuture = a;

  Future.wait([
    loadPropertiesFuture,
    //loadDBFuture
  ])
      .then((s) {
        print('Loading process completed');
        runApp(MyApp());
        print("Started MyApp:" + PropertiesUtil.propertiesMap.length.toString());
      })
      .catchError(() => print('Some error'))
      .whenComplete(() => print("Pref size: " + DBUtil.prefs.getKeys().length.toString()));
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
