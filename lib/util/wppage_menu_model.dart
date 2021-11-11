import 'package:flutter/foundation.dart';
import 'dart:convert';

class WP_Page_menu {
  final int id;
  final Rendered content;
//  final String content;

  WP_Page_menu({
    @required this.id,
    @required this.content,
  });

  factory WP_Page_menu.fromJson(Map<String, dynamic> json) {
    return WP_Page_menu(
      id: json['id'] as int,
      //content: Rendered.fromJson(json['content']),
      content: Rendered.fromJson(jsonDecode(json['content'])),
    );
  }
}

class Rendered {
  final String app_id;
  final List<MenuItem> menuitems;
  final List<MenuItem> otherPages;
  Rendered({
    @required this.app_id,
    @required this.menuitems,
    this.otherPages,
  });

  factory Rendered.fromJson(Map<String, dynamic> json) {
    return Rendered(app_id: json['app_id'] == null ? null : json["app_id"], menuitems: json['menuitems'] == null ? null : List<MenuItem>.from(json['menuitems'].map((x) => MenuItem.fromJson(x))), otherPages: json['otherpages'] == null ? null : List<MenuItem>.from(json['otherpages'].map((x) => MenuItem.fromJson(x))));
  }
}

class MenuItem {
  final String name;
  final String pageid;
  final int displayorder;
  final String pagecode;
  final String formid;

  MenuItem({
    @required this.name,
    @required this.pageid,
    @required this.displayorder,
    this.pagecode,
    this.formid,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'] as String,
      pageid: json['page-id'] as String,
      displayorder: json['display-order'] as int,
      pagecode: json['page-code'] as String,
      formid: json['form-id'] as String,
    );
  }
}
