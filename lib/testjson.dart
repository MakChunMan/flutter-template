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
      body: FutureBuilder<List<WP_Page_menu>>(
        future: httpService.getWPPage(),
        builder: (BuildContext context, AsyncSnapshot<List<WP_Page_menu>> snapshot) {
          if (snapshot.hasData) {
            String responseStr = snapshot.data[0].content.rendered;
            return Text(responseStr);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
