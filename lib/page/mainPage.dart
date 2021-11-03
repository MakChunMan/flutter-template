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
          Text(
            'Headline',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 150.0,
            child: _SliderList(),
          ),
          _ButtonGrid(),
          //_SliderList(),
        ],
      ),
    ));
  }

  //Main Content 1: Slider
  ListView _SliderList() {
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) => Card(
              child: Center(child: Text('Dummy Card Text')),
            ));
  }

  //Main Cotent 2: Button Grid
  Column _ButtonGrid() {
    return Column(children: <Widget>[
      Text(
        'Button Grid',
        style: TextStyle(fontSize: 18),
      ),
      getButtonGridView(),
    ]);
  }

  List<IconData> _icons = [];
  GridView getButtonGridView() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.0,
      ),
      itemCount: _icons.length,
      itemBuilder: (context, index) {
        //if (index == _icons.length - 1 && _icons.length < 8) {
        _retrieveIcons();
        //}
        return Icon(_icons[index]);
      },
    );
  }

  void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
        print("setState");
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast,
        ]);
      });
    });
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
