import 'package:flutter/material.dart';
import 'util/services.dart';
import 'util/wppage_menu_model.dart';

class TestJsonPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: FutureBuilder<String>(
        future: httpService.getWPPage(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            print("here");
            //String responseStr = snapshot.data.content;
            return Text("here");
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
