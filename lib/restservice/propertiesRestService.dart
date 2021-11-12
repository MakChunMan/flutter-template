import 'dart:convert';
import '../util/propertiesUtil.dart';
import '../util/dbUtil.dart';
import '../util/stringUtil.dart';
import '../util/wppage_menu_model.dart';
import 'commonRestService.dart';

class PropertiesRestService {
  Future<Map> getAppProperitesFromWPpage() async {
    /***
    Future<String> contentStr = getContentFromWPpage(PropertiesUtil.getProp(PropertiesUtil.pageid_initparam));
    contentStr.then((s) {
      return jsonDecode(s);
    }); */
    print("start getAppProperitesFromWPpage");
    String contentStr = await CommonRestService.getPageString(PropertiesUtil.getProp(PropertiesUtil.pageid_initparam));
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
    String contentStr = await CommonRestService.getPageString(PropertiesUtil.getProp("pageid-menu"));
    print("content: " + contentStr);
    print("jsonDecode(contentStr):" + jsonDecode(contentStr));
    return Rendered.fromJson(jsonDecode(contentStr));
  }

  Future<Map> getSTRFromWPpage(String pageId) async {
    print("start getSTRFromWPpage");
    String contentStr = await CommonRestService.getPageString(pageId);
    print("after await:" + contentStr);

    LineSplitter ls = new LineSplitter();
    List<String> lines = ls.convert(contentStr);
    print("How many lines:" + lines.length.toString());
    if (lines.length == 1) {
      lines = contentStr.split("<br>");
    }
    print("How many lines:" + lines.length.toString());
    Map<String, dynamic> aMap = new Map<String, String>();

    lines.forEach((s) {
      print("====>$s");
      List<String> aList = [];
      print("====>1");
      aList = StringUtil.split(s, "=", max: 1);
      print("====>2");
      if (aList == null) {
        print("List = null");
        return;
        //} else if (aList.length > 1) {
      } else {
        print("List is not null");
        aMap[aList[0]] = aList[1];
      }
      //print("Splitting $s into " + aList.length.toString());
    });

    if (aMap == null) {
      print("Fail to create str map...");
    }
    print("end getSTRFromWPpage - records loaded:" + aMap.length.toString());
    return aMap;
  }
}
