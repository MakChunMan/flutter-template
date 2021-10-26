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
      body: FutureBuilder<Rendered>(
        future: httpService.getWPPage(),
        builder: (BuildContext context, AsyncSnapshot<Rendered> snapshot) {
          if (snapshot.hasData) {
            Rendered responseStr = snapshot.data;
            return Text("App ID:" + responseStr.app_id + "; Param List size:" + responseStr.menuitems.length.toString());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
