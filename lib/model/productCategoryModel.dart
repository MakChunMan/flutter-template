import 'package:flutter/foundation.dart';
import 'dart:convert';

class ProductCategoryModel {
  final int id;
  final String name;
  final String description;
  final String imagelink;
  final int imageid;
  final String catlink;
  final int catcount;

  ProductCategoryModel({
    @required this.id,
    @required this.name,
    @required this.description,
    this.imagelink,
    this.imageid,
    this.catlink,
    this.catcount,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    var catImage;
    if (json != null) {
      catImage = CategoryImage.fromJson(json["image"]);
      print("catImage is not null");
      print(catImage.src);
    } else {
      print("catImage is  null");
    }

    return ProductCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      //imagelink: json['image'].src as String,
      imagelink: (catImage == null) ? "" : catImage.src,
      imageid: (catImage == null) ? "" : catImage.id,
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
