import 'dart:convert' show utf8, base64, jsonDecode;
import 'package:http/http.dart';
import '../util/propertiesUtil.dart';
import '../util/stringUtil.dart';
import '../util/services.dart';
import '../model/productCategoryModel.dart';

class ProductRestService {
  static Map<String, String> getWCAuthHeader() {
    String a = "ck_a76f4a8e9321f6fc7ebf8238e144b4962b46393c:cs_b42f7ef40ff17cd4ff4ce51e921717457a8d61ef";
    String b = base64.encode(utf8.encode(a));
    print(b);
    return {
      "Authorization": "Basic " + b
    };
  }

  static Future<List<ProductCategoryModel>> getCategoryList() async {
    String url = PropertiesUtil.getWCApiUrl() + "/products/categories";
    //https://flutter-backend.imagworkshop.com/wp-json/wc/v3/products/categories?consumer_key=ck_a76f4a8e9321f6fc7ebf8238e144b4962b46393c&consumer_secret=cs_b42f7ef40ff17cd4ff4ce51e921717457a8d61ef
    Response res = await get(Uri.parse(url), headers: getWCAuthHeader());
    print("[CommonRestService:getCategoryList] - URL:" + url);
    if (res.statusCode == 200) {
      print(res.body);
      //Map<String, dynamic> map = jsonDecode(res.body);
      List<dynamic> body = jsonDecode(res.body);

      List<ProductCategoryModel> returnList = body
          .map(
            (dynamic item) => ProductCategoryModel.fromJson(item),
          )
          .toList();
      return returnList;
    }
  }

  /**
  static Future<GenericPageModel> getPageContent(String pageId) async {
    String url = PropertiesUtil.getProp("apiUrl") + "/pages/" + pageId + "?_fields=id,title,content";
    Response res = await get(Uri.parse(url));
    print("[CommonRestService] - URL:" + url);
    if (res.statusCode == 200) {
      print("Get 200 from pageId:" + pageId);
      Map<String, dynamic> map = jsonDecode(res.body);
      String aStr = HttpService.removeTabFromWPString(map['content']['rendered']);
      print("===> Content:" + StringUtil.removeHtmlTag(StringUtil.trim(aStr, 200)) + "...");

      GenericPageModel aModel = new GenericPageModel(id: pageId, content: aStr, title: StringUtil.removeHtmlTag(map["title"]['rendered']));

      return aModel;
    } else {
      var statusCode = res.statusCode;
      throw "[PageRestService] Unable to retrieve posts. (Return code: $statusCode)";
    }
  } */
}
