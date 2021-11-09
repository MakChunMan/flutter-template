import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../restservice/productRestService.dart';
import '../component/appbar.dart';
import '../model/productCategoryModel.dart';
import '../model/productModel.dart';
import '../util/mousepointScrollBehavior.dart';
import '../util/dbUtil.dart';
import '../util/stringUtil.dart';
import '../util/commonUtil.dart';

class CartPage extends StatefulWidget {
  CartPage({
    Key key, //this.pageId
  }) : super(key: key);

  //In-param

  @override
  _CartPageState createState() => _CartPageState();

  //static getInstance({Key key, String pageId}) {
  static getInstance(Map<String, String> param) {
    return new CartPage();
  }
}

class _CartPageState extends State<CartPage> {
  //Constructor
  String pageTitle = "Cart";

  //Page Model
  //Future<List<ProductCategoryModel>> categoryListFuture;
  //Future<List<ProductModel>> productListByCategoryFuture;
  Future<List<ProductModel>> productListByIdListFuture;

  //List<ProductCategoryModel> _categoryList = new List<ProductCategoryModel>();
  //ProductCategoryModel _currentCategory = null;
  //List<ProductModel> _productListByCategory = null;

  //MemoryStorage
  //Map<int, List<ProductModel>> _cacheProductListByCategoryId = new Map<int, List<ProductModel>>();
  Map<String, int> _cart = new Map<String, int>(); //product id, quantity
  Map<String, ProductModel> _cartProductDetails = new Map<String, ProductModel>();

  @override
  void initState() {
    super.initState();
    loadPage();
    if (_cart != null && _cart.length > 0) {
      print("_cart size before loading product details:" + _cart.length.toString());
      productListByIdListFuture = ProductRestService.getProductListByIdList(_cart.keys.toList());
      productListByIdListFuture.then((s) {
        Map<String, ProductModel> aMap = new Map<String, ProductModel>();
        List<ProductModel> r = s;
        r.forEach((p) {
          aMap[p.id.toString()] = p;
        });
        setState(() {
          _cartProductDetails.clear();
          _cartProductDetails = aMap;
        });
      });
    }
  }

  @override
  void dispose() {
    print('dispose: $this');
    savePage();
    super.dispose();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    print('didUpdateWidget: $this');
    super.didUpdateWidget(oldWidget);
  }

  void savePage() {
    DBUtil.prefs.setString("_cart", jsonEncode(_cart));
    print("serialized _cart:" + jsonEncode(_cart));
  }

  void loadPage() {
    var _cartString = DBUtil.prefs.getString("_cart");
    if (!StringUtil.isNullOrEmpty(_cartString)) {
      var thisCart = jsonDecode(_cartString);
      _cart.clear;
      thisCart.forEach((k, v) {
        _cart[k] = v;
      });
      print(_cart.length.toString() + " of items in cart are loaded");
    }

    /***
    var _productListByCategoryJsonStr = DBUtil.prefs.getString("_productListByCategory");
    if (!StringUtil.isNullOrEmpty(_productListByCategoryJsonStr)) {
      this._productListByCategory = jsonDecode(_productListByCategoryJsonStr);
    }
     */
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
                  //_categoryListView(),
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
  double totalAmount = 0.0;
  Widget listOfProductForSpecificCat() {
    double amt = 0.0;
    List<Widget> widgetsInColumn = [
      //categoryTitleText(this._currentCategory == null ? "" : this._currentCategory.name)
      categoryTitleText("Cart")
    ];
    if (_cartProductDetails == null) {
      //return Text("");
    } else if (_cartProductDetails.length == 0) {
      //return Text("");
    } else {
      this._cartProductDetails.forEach((idx, item) {
        var item = _cartProductDetails[idx];
        if (item == null)
          widgetsInColumn.add(Text("NULL for item"));
        else if (_cart[item.id.toString()] != null) {
          widgetsInColumn.add(productItem(item));
          amt += item.price * _cart[item.id.toString()];
          widgetsInColumn.add(Divider(
            color: Colors.teal.shade100,
            thickness: 1.0,
          ));
        }
      });
      setState(() {
        totalAmount = amt;
        widgetsInColumn.add(
          Text("Total amount: " + totalAmount.toString(),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              )),
        );
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
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
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
                        child: Text("Price: " + pm.price.toStringAsFixed(2),
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

  /*********************************************************************************
  Add / Remove on cart
  ********************************************************************************** */
  int _getQtyInCart(ProductModel pm) {
    if (_cart == null)
      return 0;
    else if (_cart[pm.id.toString()] == null)
      return 0;
    else
      return _cart[pm.id.toString()];
  }

  void _addRemoveInCart(ProductModel pm, int counterType) {
    var count = _getQtyInCart(pm);
    var countAfterChange = count + counterType;
    if (countAfterChange <= 0) {
      setState(() {
        if (_cart[pm.id.toString()] != null) _cart.remove(pm.id.toString());
      });
    } else {
      setState(() {
        _cart[pm.id.toString()] = countAfterChange;
      });
    }
    recalculateTotal();
  }

  void recalculateTotal() {
    var tot = 0.0;
    _cart.forEach((k, v) {
      tot += v * _cartProductDetails[k].price;
    });
    setState(() {
      this.totalAmount = tot;
    });
  }

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
        _addRemoveInCart(pm, counterType);
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

  List<Widget> _buildCartButton(ProductModel pm) {
    if (_getQtyInCart(pm) > 0) {
      return [
        counterButton(pm, -1), //-1: Minus
        Text(
          _getQtyInCart(pm).toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        counterButton(pm, 1), //1: Plus,
      ];
    } else {
      return [
        FlatButton(
          onPressed: () {
            _addRemoveInCart(pm, 1);
          },
          child: Text("Add to Cart"),
        ),
      ];
    }
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
          children: _buildCartButton(pm), //By qty in cart, display "Add to Cart" to add/remove counter
        ),
      ),
    );
  }
}
