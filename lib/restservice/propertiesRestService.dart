import 'dart:convert';
import 'package:http/http.dart';
import '../util/propertiesUtil.dart';
import '../util/services.dart';
import '../util/wppage_menu_model.dart';

class PropertiesRestService {
  Future<String> getContentFromWPpage(String pageId) async {
    Response res = await get(Uri.parse(PropertiesUtil.getProp("apiUrl") + "pages/" + pageId + "?_fields=id,content"));
    print("URL:" + PropertiesUtil.getProp("apiUrl") + "/pages/" + pageId + "?_fields=id,content");
    if (res.statusCode == 200) {
      print("Get 200 from pageId:" + pageId);
      Map<String, dynamic> map = jsonDecode(res.body);
      String aStr = HttpService.removeTabFromWPString(map['content']['rendered']);
      print("===> Content:" + aStr);
      return aStr;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<Map> getAppProperitesFromWPpage() async {
    /***
    Future<String> contentStr = getContentFromWPpage(PropertiesUtil.getProp(PropertiesUtil.pageid_initparam));
    contentStr.then((s) {
      return jsonDecode(s);
    }); */
    String contentStr = await getContentFromWPpage(PropertiesUtil.getProp(PropertiesUtil.pageid_initparam));
    Map aMap = jsonDecode(contentStr);
    return aMap;
    //Response res = await get(Uri.parse(PropertiesUtil.getProp("apiUrl") + "/pages/" + PropertiesUtil.getProp("apiUrl") + "?_fields=id,content"));
  }

  Future<Rendered> getMenuFromWPpage() async {
    /***
    Future<String> contentStr = getContentFromWPpage(PropertiesUtil.getProp(PropertiesUtil.pageid_initparam));
    contentStr.then((s) {
      return Rendered.fromJson(jsonDecode(s));
    }); */
    String contentStr = await getContentFromWPpage(PropertiesUtil.getProp(PropertiesUtil.pageid_initparam));
    return Rendered.fromJson(jsonDecode(contentStr));
  }

  /***
  Future<Rendered> getWPPage() async {
    Response res = await get(Uri.parse(PropertiesUtil.getProp("apiUrl") + "/pages/52?_fields=id,content"));
    if (res.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(res.body);

      String aStr = HttpService.removeTabFromWPString(map['content']['rendered']);
      print(aStr);
      Rendered body = Rendered.fromJson(jsonDecode(aStr));

      print(PropertiesUtil.getProp("apiUrl"));
    } else {
      throw "Unable to retrieve posts.";
    }
  }
   */
}
