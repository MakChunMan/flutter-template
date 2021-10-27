import 'package:flutter/material.dart';
import 'util/services.dart';
import 'restservice/propertiesRestService.dart';
import 'util/wppage_menu_model.dart';
import 'component/appbar.dart';

class TestJsonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TestJsonPageState();
  }
}

class TestJsonPageState extends State<TestJsonPage> {
  final HttpService httpService = HttpService();
  final PropertiesRestService restService = PropertiesRestService();

  var renderedJsonStr = new List();

  Future<Rendered> getMenu() async {
    Rendered a = await restService.getMenuFromWPpage();
    renderedJsonStr = a.menuitems;
    return a;
  }

  @override
  void initState() {
    super.initState();
    getMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent.getAppBar("Posts Jason", renderedJsonStr),
      body: FutureBuilder<Rendered>(
        //future: httpService.getWPPage(),
        future: restService.getMenuFromWPpage(),
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
