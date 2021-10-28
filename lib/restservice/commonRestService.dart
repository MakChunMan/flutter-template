import 'dart:convert';
import 'package:http/http.dart';
import '../util/propertiesUtil.dart';
import '../util/services.dart';
import '../model/genericPageModel.dart';

class CommonRestService {
  static Future<String> getPageString(String pageId) async {
    String url = PropertiesUtil.getProp("apiUrl") + "/pages/" + pageId + "?_fields=id,content";
    Response res = await get(Uri.parse(url));
    print("[PageRestService] - URL:" + url);
    if (res.statusCode == 200) {
      print("Get 200 from pageId:" + pageId);
      Map<String, dynamic> map = jsonDecode(res.body);
      String aStr = HttpService.removeTabFromWPString(map['content']['rendered']);
      print("===> Content:" + aStr);
      return aStr;
    } else {
      throw "[PageRestService] Unable to retrieve posts. (Return code: $res.statusCode)";
    }
  }

  static Future<GenericPageModel> getPageContent(String pageId) async {
    String aStr = await getPageString(pageId);
    GenericPageModel aModel = new GenericPageModel(id: pageId, content: aStr, title: pageId);
    return aModel;
  }
}
