library jasonPage;

import 'package:flutter/material.dart';
import '../restservice/commonRestService.dart';
import '../component/appbar.dart';
import '../model/genericPageModel.dart';
import 'dart:async';
import 'package:flutter_html/flutter_html.dart';

class GenericPage extends StatefulWidget {
  GenericPage({Key key, this.pageId}) : super(key: key);

  //In-param
  final String pageId;

  @override
  _GenericPageState createState() => _GenericPageState(this.pageId);
}

class _GenericPageState extends State<GenericPage> {
  //Constructor
  String pageId;
  String pageTitle = "";
  _GenericPageState(this.pageId);

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
