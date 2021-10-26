import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'testjson.dart';
import 'package:global_configuration/global_configuration.dart';

void main() async {
  try {
    await rootBundle.loadString('assets/config/test.txt');
    await GlobalConfiguration().loadFromAsset("dev");
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
