import 'package:flutter/foundation.dart';

class GenericPageModel {
  final String id;
  final String title;
  final String content;

  GenericPageModel({
    @required this.id,
    @required this.title,
    @required this.content,
  });

  factory GenericPageModel.fromJson(Map<String, dynamic> json) {
    return GenericPageModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}
