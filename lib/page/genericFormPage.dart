import 'package:flutter/material.dart';
import '../restservice/commonRestService.dart';
import '../component/appbar.dart';
import '../model/genericPageModel.dart';
import 'dart:async';
import 'package:flutter_html/flutter_html.dart';

class GenericFormPage extends StatefulWidget {
  GenericFormPage({Key key, this.pageId, this.formId}) : super(key: key);

  //In-param
  final String pageId;
  final String formId;

  @override
  _GenericFormPageState createState() => _GenericFormPageState(this.pageId, this.formId);

  //static getInstance({Key key, String pageId}) {
  static getInstance(Map<String, String> param) {
    return new GenericFormPage(pageId: param["pageId"].toString(), formId: param["formId"].toString());
  }
}

class _GenericFormPageState extends State<GenericFormPage> {
  //Constructor
  String pageId; //Page ID of form json
  String formId;
  String pageTitle = "";
  _GenericFormPageState(this.pageId, this.formId);

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
