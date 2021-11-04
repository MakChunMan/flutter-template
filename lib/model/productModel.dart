import 'package:flutter/foundation.dart';
import 'dart:convert';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final String shortDescription;
  final double price;
  final double regularPrice;
  final List<String> imagelink;

  ProductModel({@required this.id, @required this.name, @required this.description, this.shortDescription, this.price, this.regularPrice, this.imagelink});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<String> imagelinks = [];
    if (json["images"] != null) {
      print("json is not null");
      List listOfImage = json['images'];
      if (listOfImage != null && listOfImage.length > 0) {
        for (int i = 0; i < listOfImage.length; i++) {
          print(i.toString() + "/" + listOfImage.length.toString());
          if (ProductImage.fromJson(listOfImage[i]) != null) {
            var imageurl = ProductImage.fromJson(listOfImage[i]).src;
            print(imageurl);
            imagelinks.add(imageurl);
          }
        }
      }
    } else {
      print("json is null");
      print("catImage is  null");
      return null;
    }

    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      shortDescription: json['short_description'] as String,
      price: json['price'] as double,
      regularPrice: json['regular_price'] as double,
      imagelink: imagelinks,
    );
  }
}

class ProductImage {
  final int id;
  final String src;

  ProductImage({
    @required this.id,
    this.src,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'] as int,
      src: json['src'] as String,
    );
  }
}
