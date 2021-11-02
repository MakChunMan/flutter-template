import 'dart:async';
import 'package:flutter/material.dart';
import '../restservice/productRestService.dart';
import '../component/appbar.dart';
import '../model/productCategoryModel.dart';

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
  String pageTitle = "Home";
  _ShopMainPageState(this.pageId);

  //Page Model
  Future<List<ProductCategoryModel>> categoryListFuture;
  List<ProductCategoryModel> _categoryList = new List<ProductCategoryModel>();

  @override
  void initState() {
    super.initState();
    categoryListFuture = ProductRestService.getCategoryList();
    categoryListFuture.then((s) {
      setState(() {
        //this.pageTitle = s.title;
        this._categoryList = s;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent.getAppBar(context, pageTitle, null),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Enter text to search', labelText: 'Search', prefixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _categoryListView(),
                //_buildCardListView(),
                //_buildRequestListView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _categoryListView() {
    return SizedBox(
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categoryList.length,
        itemExtent: 100.0,
        itemBuilder: (context, index) {
          var item = _categoryList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    item.catlink,
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black26,
                    BlendMode.darken,
                  ),
                ),
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://iisy.fi/wp-content/uploads/2018/08/user-profile-male-logo.jpg',
                        ),
                        radius: 14.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item.name,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
