import 'dart:convert';
import 'package:http/http.dart';
import '../util/propertiesUtil.dart';
import '../util/services.dart';

class PageRestService {
  static Future<String> getPageContent(String pageId) async {
    String url = PropertiesUtil.getProp("apiUrl") + "/pages/" + pageId + "?_fields=id,content";
    Response res = await get(Uri.parse(url));
    print("[PageRestService] - URL:" + url);
    if (res.statusCode == 200) {
      print("Get 200 from pageId:" + pageId);
      Map<String, dynamic> map = jsonDecode(res.body);
      String aStr = HttpService.removeTabFromWPString(map['content']['rendered']);
      print("===> Content:" + aStr);
      return Future.value(aStr);
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
