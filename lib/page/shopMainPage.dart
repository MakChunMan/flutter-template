import 'dart:async';
import 'package:flutter/material.dart';
import '../restservice/commonRestService.dart';
import '../component/appbar.dart';
import '../model/genericPageModel.dart';

class ShopMainPage extends StatefulWidget {
  ShopMainPage({Key key, this.pageId}) : super(key: key);

  //In-param
  final String pageId;

  @override
  _ShopMainPageState createState() => _ShopMainPageState(this.pageId);

  //static getInstance({Key key, String pageId}) {
  static getInstance(Map<String, String> param) {
    return new ShopMainPage(pageId: param["pageId"].toString());
  }
}

class _ShopMainPageState extends State<ShopMainPage> {
  //Constructor
  String pageId;
  String pageTitle = "";
  _ShopMainPageState(this.pageId);

  //Page Model
  Future<GenericPageModel> futurePage;

  @override
  void initState() {
    super.initState();
    futurePage = CommonRestService.getPageContent(pageId);
    futurePage.then((s) {
      setState(() {
        this.pageTitle = s.title;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent.getAppBar(context, pageTitle, null),
      body: FutureBuilder<GenericPageModel>(
        future: futurePage,
        builder: (BuildContext context, AsyncSnapshot<GenericPageModel> snapshot) {
          if (snapshot.hasData) {
            return Text(this.pageId);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
