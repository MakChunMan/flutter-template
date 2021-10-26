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
  Rendered({
    @required this.app_id,
    @required this.menuitems,
  });

  factory Rendered.fromJson(Map<String, dynamic> json) {
    return Rendered(app_id: json['app_id'] == null ? null : json["app_id"], menuitems: json['menuitems'] == null ? null : List<MenuItem>.from(json['menuitems'].map((x) => MenuItem.fromJson(x))));
  }
}

class MenuItem {
  final String name;
  final String pageid;
  final int displayorder;

  MenuItem({
    @required this.name,
    @required this.pageid,
    @required this.displayorder,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'] as String,
      pageid: json['page-id'] as String,
      displayorder: json['display-order'] as int,
    );
  }
}
