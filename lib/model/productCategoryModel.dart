import 'package:flutter/foundation.dart';
import 'dart:convert';

class ProductCategoryModel {
  final String id;
  final String name;
  final String description;
  final String imagelink;
  final String catlink;
  final int catcount;

  ProductCategoryModel({
    @required this.id,
    @required this.name,
    @required this.description,
    this.imagelink,
    this.catlink,
    this.catcount,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      id: json['id'].toString() as String,
      name: json['name'] as String,
      description: json['description'] as String,
      //imagelink: json['image'].src as String,
      imagelink: jsonDecode(json['image'])['src'] as String,
      //catlink: json['_links']['self'][0] as String,
      //catcount: json['count'] as int,
    );
  }
}
