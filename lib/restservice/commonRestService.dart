import 'dart:convert';
import 'package:http/http.dart';
import '../util/propertiesUtil.dart';
import '../util/stringUtil.dart';
import '../util/services.dart';
import '../model/genericPageModel.dart';

class CommonRestService {
  static Future<String> getPageString(String pageId) async {
    GenericPageModel aStr = await getPageContent(pageId);
    return aStr.content;
  }

  static Future<GenericPageModel> getPageContent(String pageId) async {
    String url = PropertiesUtil.getWPApiUrl() + "/pages/" + pageId + "?_fields=id,title,content";
    //String url = PropertiesUtil.getProp("apiUrl") + "/pages/" + pageId + "?_fields=id,title,content";
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
  }
}
