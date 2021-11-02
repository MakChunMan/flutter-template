import 'package:flutter/foundation.dart';
import 'dart:convert';

class ProductCategoryModel {
  final int id;
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
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      //imagelink: json['image'].src as String,
      imagelink: (CategoryImage.fromJson(json["image"])).src,
      //catlink: json['_links']['self'][0] as String,
      //catcount: json['count'] as int,
    );
  }
}

class CategoryImage {
  final int id;
  final String src;

  CategoryImage({
    @required this.id,
    this.src,
  });

  factory CategoryImage.fromJson(Map<String, dynamic> json) {
    return CategoryImage(
      id: json['id'] as int,
      src: json['src'] as String,
    );
  }
}
