import 'package:flutter/material.dart';
import '../util/services.dart';
import '../restservice/commonRestService.dart';
import '../component/appbar.dart';
import '../model/genericPageModel.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';

class GenericPage extends StatefulWidget {
  GenericPage({Key key, this.pageId}) : super(key: key);

  //In-param
  String pageId;

  @override
  _GenericPageState createState() => _GenericPageState(this.pageId);
}

class _GenericPageState extends State<GenericPage> {
  //Constructor
  String pageId;
  _GenericPageState(this.pageId);

  //Page Model
  Future<GenericPageModel> futurePage;

  @override
  void initState() {
    super.initState();
    futurePage = CommonRestService.getPageContent(pageId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent.getAppBar(context, "Page ID $pageId", null),
      body: FutureBuilder<GenericPageModel>(
        future: futurePage,
        builder: (BuildContext context, AsyncSnapshot<GenericPageModel> snapshot) {
          if (snapshot.hasData) {
            GenericPageModel page = snapshot.data;
            return Html(data: page.content);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
