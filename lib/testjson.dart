import 'package:flutter/material.dart';
import 'util/services.dart';

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
            String responseStr = snapshot.data;
            return Text(responseStr);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
