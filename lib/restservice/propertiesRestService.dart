import 'dart:convert';
import 'package:http/http.dart';
import '../util/propertiesUtil.dart';
import '../util/services.dart';
import '../util/wppage_menu_model.dart';

class PropertiesRestService {
  Future<String> getContentFromWPpage(String pageId) async {
    String url = PropertiesUtil.getProp("apiUrl") + "/pages/" + pageId + "?_fields=id,content";
    Response res = await get(Uri.parse(url));
    print("URL:" + url);
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

  Future<Map> getAppProperitesFromWPpage() async {
    /***
    Future<String> contentStr = getContentFromWPpage(PropertiesUtil.getProp(PropertiesUtil.pageid_initparam));
    contentStr.then((s) {
      return jsonDecode(s);
    }); */
    print("start getAppProperitesFromWPpage");
    String contentStr = await getContentFromWPpage(PropertiesUtil.getProp(PropertiesUtil.pageid_initparam));
    print("after await:" + contentStr);
    Map<String, dynamic> aMap = jsonDecode(contentStr);
    if (aMap == null) {
      print("aMap = =null");
    } else {
      print("aMap is not null");
    }
    print("end getAppProperitesFromWPpage" + aMap.length.toString());
    return aMap;
    //Response res = await get(Uri.parse(PropertiesUtil.getProp("apiUrl") + "/pages/" + PropertiesUtil.getProp("apiUrl") + "?_fields=id,content"));
  }

  Future<Rendered> getMenuFromWPpage() async {
    print("start getMenuFromWPpage: " + PropertiesUtil.getProp("pageid-menu"));
    if (PropertiesUtil.getProp("pageid-menu") == null) {}
    String contentStr = await getContentFromWPpage(PropertiesUtil.getProp("pageid-menu"));
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
