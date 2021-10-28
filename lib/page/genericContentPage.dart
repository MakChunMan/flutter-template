import 'package:flutter/material.dart';
import '../util/services.dart';
import '../restservice/pageRestService.dart';
import '../component/appbar.dart';
import '../model/genericPageModel.dart';
import 'dart:async';
import 'dart:convert';

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
  late Future<GenericPageModel> futurePage;

  @override
  void initState() {
    super.initState();
    futurePage = PageRestService.getPageContent(pageId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent.getAppBar(context, "TEST", null),
      body: const Center(
        child: FutureBuilder<GenericPageModel>(
          future: futurePage,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.title);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
