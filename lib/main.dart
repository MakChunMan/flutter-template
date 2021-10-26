import 'package:flutter/material.dart';
import 'testjson.dart';
import 'package:global_configuration/global_configuration.dart';

void main() async {
  GlobalConfiguration cfg = new GlobalConfiguration();
  try {
    await cfg.loadFromPath("/assets/config/dev.json");
  } catch (e) {
    // something went wrong while fetching the config from the url ... do something
    print("Exception: " + e.toString());
  }

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
