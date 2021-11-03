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
        //Stack children 1 (bottom layer: main page content)
        bottomLayerContainer(),
        //Stack children 2 (top layer: search bar and bottom tools)
        topLayerContainer,
      ],
    ));
  }

  final _controller = ScrollController();
  SingleChildScrollView bottomLayerContainer() {
    return SingleChildScrollView(
        child: ScrollConfiguration(
      behavior: MousePointScrollBehavior(),
      child: Column(
        children: <Widget>[
          _SliderList(),
        ],
      ),
    ));
  }

  //Main Content 1: Slider
  ListView _SliderList() {
    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          width: 160.0,
          color: Colors.red,
        ),
        Container(
          width: 160.0,
          color: Colors.blue,
        ),
        Container(
          width: 160.0,
          color: Colors.green,
        ),
        Container(
          width: 160.0,
          color: Colors.yellow,
        ),
        Container(
          width: 160.0,
          color: Colors.orange,
        ),
      ],
    );
  }

  Column topLayerContainer = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          "Search Bar here",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Bottom tool bar here",
          style: TextStyle(color: Colors.red),
        ),
      )
    ],
  );
}
