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
  final String rendered;
  //final List<Menuitem> menuitems;
  Rendered({
    @required this.rendered,
    //@required this.menuitems,
  });

  factory Rendered.fromJson(Map<String, dynamic> json) {
    return Rendered(
      rendered: json['rendered'] as String,
      //menuitems: json['rendered'] as String,
    );
  }
}

class Menuitem {
  final String name;
  final String pageid;
  final int displayorder;

  Menuitem({
    @required this.name,
    @required this.pageid,
    @required this.displayorder,
  });

  factory Menuitem.fromJson(Map<String, dynamic> json) {
    return Menuitem(
      name: json['name'] as String,
      pageid: json['page-id'] as String,
      displayorder: json['display-order'] as int,
    );
  }
}
