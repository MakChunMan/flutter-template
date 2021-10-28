import 'dart:convert';
import '../util/propertiesUtil.dart';
import '../util/wppage_menu_model.dart';
import 'pageRestService.dart';

class PropertiesRestService {
  Future<Map> getAppProperitesFromWPpage() async {
    /***
    Future<String> contentStr = getContentFromWPpage(PropertiesUtil.getProp(PropertiesUtil.pageid_initparam));
    contentStr.then((s) {
      return jsonDecode(s);
    }); */
    print("start getAppProperitesFromWPpage");
    String contentStr = await PageRestService.getPageContent(PropertiesUtil.getProp(PropertiesUtil.pageid_initparam));
    print("after await:" + contentStr);
    Map<String, dynamic> aMap = jsonDecode(contentStr);
    if (aMap == null) {
      print("Fail to create property map...");
    }
    print("end getAppProperitesFromWPpage" + aMap.length.toString());
    return aMap;
    //Response res = await get(Uri.parse(PropertiesUtil.getProp("apiUrl") + "/pages/" + PropertiesUtil.getProp("apiUrl") + "?_fields=id,content"));
  }

  Future<Rendered> getMenuFromWPpage() async {
    print("start getMenuFromWPpage: " + PropertiesUtil.getProp("pageid-menu"));
    if (PropertiesUtil.getProp("pageid-menu") == null) {}
    String contentStr = await PageRestService.getPageContent(PropertiesUtil.getProp("pageid-menu"));
    return Rendered.fromJson(jsonDecode(contentStr));
  }

  Future<Map> getSTRFromWPpage(String pageId) async {
    print("start getSTRFromWPpage");
    String contentStr = await PageRestService.getPageContent(pageId);
    print("after await:" + contentStr);
    Map<String, dynamic> aMap = jsonDecode(contentStr);
    if (aMap == null) {
      print("Fail to create str map...");
    }
    print("end getSTRFromWPpage" + aMap.length.toString());
    return aMap;
  }
}
