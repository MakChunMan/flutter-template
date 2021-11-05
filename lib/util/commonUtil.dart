class CommonUtil {
  static Map<String, dynamic> cartFromJson(Map<int, int> cart) {
    Map<String, int> _returnCart = new Map();
    cart.forEach((k, v) {
      _returnCart["$k"] = v;
    });
    print(_returnCart.length.toString());
    return _returnCart;
  }
}
