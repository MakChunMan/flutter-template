import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'testjson.dart';
import 'package:global_configuration/global_configuration.dart';
import 'dart:io';
import 'dart:convert';

void main() async {
  final configFile = File('dev.json');
  final jsonString = await configFile.readAsString();
  final dynamic jsonMap = jsonDecode(jsonString);
  print(jsonMap);
  runApp(MyApp());
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
