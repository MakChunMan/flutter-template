import 'dart:async';
import 'package:flutter/material.dart';
import '../restservice/productRestService.dart';
import '../component/appbar.dart';
import '../model/productCategoryModel.dart';
import '../model/productModel.dart';
import '../util/mousepointScrollBehavior.dart';

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
  Future<List<ProductModel>> productListByCategoryFuture;

  List<ProductCategoryModel> _categoryList = new List<ProductCategoryModel>();
  ProductCategoryModel _currentCategory = null;
  List<ProductModel> _productListByCategory = null;

  //MemoryStorage
  Map<int, List<ProductModel>> _cacheProductListByCategoryId = new Map<int, List<ProductModel>>();

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
      body: ScrollConfiguration(
        behavior: MousePointScrollBehavior(),
        child: Column(
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
                  listOfProductForSpecificCat(),
                  //_buildCardListView(),
                  //_buildRequestListView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final _controller = ScrollController();

  //Top horizontal category list
  SizedBox _categoryListView() {
    return SizedBox(
      height: 150.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _categoryList.length,
          itemExtent: 100.0,
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            var item = _categoryList[index];
            return GestureDetector(
              onTap: () {
                topCategoryListOnClick(item, index);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: (item == null || item.imagelink == null)
                        ? null
                        : DecorationImage(
                            image: NetworkImage(
                              item.imagelink,
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
              ),
            );
          }),
    );
  }

  void topCategoryListOnClick(ProductCategoryModel item, int index) {
    print(item.name + "; index:" + index.toString());
    setState(() {
      //this.pageTitle = s.title;
      this._currentCategory = item;
      this._productListByCategory = null;
    });

    //Check cache
    if (_cacheProductListByCategoryId.containsKey(item.id)) {
      setState(() {
        this._productListByCategory = _cacheProductListByCategoryId[item.id];
      });
    } else {
      productListByCategoryFuture = ProductRestService.getProductListByCategory(item.id.toString());
      productListByCategoryFuture.then((s) {
        setState(() {
          //this.pageTitle = s.title;
          this._productListByCategory = s;
          this._cacheProductListByCategoryId[item.id] = s;
          print("cache map size: " + this._cacheProductListByCategoryId.length.toString());
        });
      });
    }
  }

  Widget listOfProductForSpecificCat() {
    List<Widget> widgetsInColumn = [
      categoryTitleText(this._currentCategory == null ? "" : this._currentCategory.name)
    ];
    if (_productListByCategory == null) {
      //return Text("");
    } else if (_productListByCategory.length == 0) {
      //return Text("");
    } else {
      this._productListByCategory.asMap().forEach((idx, item) {
        var item = _productListByCategory[idx];
        if (item == null)
          widgetsInColumn.add(Text("NULL for item"));
        else
          widgetsInColumn.add(productItem(item));
        widgetsInColumn.add(Divider(
          color: Colors.teal.shade100,
          thickness: 1.0,
        ));
      });
      /**
      widgetsInColumn.addAll(List<Widget>.generate(this._productListByCategory.length, (index) {
        var item = _productListByCategory[index];
        if (item == null)
          return Text("NULL for item");
        else
          return productItem(item);
      }).toList()); */
    }
    //print("Length:" + this._productListByCategory.length.toString());
    return new Column(children: widgetsInColumn);
  }

  Widget categoryTitleText(String catName) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(catName,
          style: TextStyle(fontSize: 35, color: Colors.purple, fontWeight: FontWeight.w700, fontStyle: FontStyle.italic, letterSpacing: 8, wordSpacing: 20, shadows: [
            Shadow(color: Colors.blueAccent, offset: Offset(2, 1), blurRadius: 10)
          ])),
    );
  }

  Widget productItem(ProductModel pm) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              color: Colors.black12,
              image: DecorationImage(
                image: NetworkImage(
                  pm.imagelink[0],
                ),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 2.0,
                  horizontal: 6.0,
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  //Product Name
                  productName(pm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Product Price
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Price: 1.00",
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ),
                      addToCart(pm),
                    ],
                  )
                ]),
              )),
        ],
      ),
      /**child: Container(
          child: Text(pm.name),
        ));**/
    );
  }

  int counter = 0;
  IconButton counterButton(ProductModel pm, int counterType) {
    return IconButton(
      icon: Icon(
        counterType > 0 ? Icons.add : Icons.remove,
        color: Theme.of(context).accentColor,
      ),
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
      iconSize: 28.0,
      color: Theme.of(context).primaryColor,
      onPressed: () {
        setState(() {});
      },
    );
  }

  Widget productName(ProductModel pm) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Text(pm.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            )));
  }

  Widget addToCart(ProductModel pm) {
    return Container(
      height: 35.0,
      width: 130.0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(color: Colors.blueGrey.withAlpha(50), borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            counterButton(pm, -1), //-1: Minus
            Text(
              '$counter',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            counterButton(pm, 1), //1: Plus,
          ],
        ),
      ),
    );
  }
}
