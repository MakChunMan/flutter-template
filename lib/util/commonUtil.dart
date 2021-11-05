class CommonUtil {
  static Map<String, dynamic> cartFromJson(Map<int, int> cart) {
    var _returnCart;
    cart.forEach((k, v) {
      _returnCart["$k"] = v;
    });
    return _returnCart;
  }
}
