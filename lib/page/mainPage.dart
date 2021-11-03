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
  ScrollPhysics _physics = ClampingScrollPhysics();

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

    _controller.addListener(() {
      if (_controller.position.pixels <= 56)
        setState(() => _physics = ClampingScrollPhysics());
      else
        setState(() => _physics = BouncingScrollPhysics());
    });
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
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: ScrollConfiguration(
          behavior: MousePointScrollBehavior(),
          child: Column(
            children: <Widget>[
              Text(
                'Headline',
                style: TextStyle(fontSize: 18),
              ),
              _Slider2(),
              SizedBox(
                height: 150.0,
                child: _SliderList(),
              ),
              _ButtonGrid(),
              //_SliderList(),
              SizedBox(
                height: 150.0,
                child: _SliderList(),
              ),
              SizedBox(
                height: 150.0,
                child: _SliderList(),
              ),
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

  //Main Content Slider version 2
  int _slideIndex = 0;
  SizedBox _Slider2() {
    return SizedBox(
      height: 200, // card height
      child: PageView.builder(
        itemCount: 10,
        controller: PageController(viewportFraction: 0.7),
        onPageChanged: (int index) => setState(() => _slideIndex = index),
        itemBuilder: (_, i) {
          return Transform.scale(
            scale: i == _slideIndex ? 1 : 0.9,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  "Card ${i + 1}",
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
          );
        },
      ),
    );
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

  List<IconData> _icons = [
    Icons.ac_unit,
    Icons.airport_shuttle,
    Icons.all_inclusive,
    Icons.beach_access,
    Icons.cake,
    Icons.free_breakfast,
  ];

  GridView getButtonGridView() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.0,
      ),
      itemCount: _icons.length,
      itemBuilder: (context, index) {
        return Icon(_icons[index]);
      },
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
