import 'package:flutter/foundation.dart';

class WP_Page_menu {
  final int id;
//  final Rendered content;
  final String content;

  WP_Page_menu({
    @required this.id,
    @required this.content,
  });

  factory WP_Page_menu.fromJson(Map<String, dynamic> json) {
    return WP_Page_menu(
      id: json['id'] as int,
      //content: Rendered.fromJson(json['content']),
      content: json['content'] as String,
    );
  }
}

class Rendered {
  final String rendered;

  Rendered({
    @required this.rendered,
  });

  factory Rendered.fromJson(Map<String, dynamic> json) {
    return Rendered(
      rendered: json['rendered'] as String,
    );
  }
}
