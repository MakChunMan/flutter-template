import 'dart:async';
import 'package:flutter/material.dart';
//import '../restservice/productRestService.dart';
//import '../component/appbar.dart';
//import '../model/productCategoryModel.dart';
import '../util/mousepointScrollBehavior.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();

  //This function if used for generic instanitation
  static getInstance(Map<String, String> param) {
    return new MainPage();
  }
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    /***
    categoryListFuture = ProductRestService.getCategoryList();
    categoryListFuture.then((s) {
      setState(() {
        //this.pageTitle = s.title;
        this._categoryList = s;
      });
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBarComponent.getAppBar(context, pageTitle, null), //NO App bar
        body: Stack(
      children: <Widget>[
        //Stack children 1 (bottom layer)
        //Stack children 2 (top layer)
      ],
    ));
  }

  Column toplayerContainer = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Align(
          alignment: Alignment.topLeft,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "TEST TEST",
          style: TextStyle(color: Colors.red),
        ),
      )
    ],
  );
}
