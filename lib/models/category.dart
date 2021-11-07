//   {
//     "Name": "Candles",
//     "SeName": "candles",
//     "NumberOfProducts": null,
//     "IncludeInTopMenu": true,
//     "SubCategories": [],
//     "HaveSubCategories": false,
//     "Route": null,
//     "IconUrl": null,
//     "Id": 100
// }

import 'dart:convert';

import 'package:flutter/material.dart';

class Category with ChangeNotifier {
  String? Name = '';
  String? SeName = '';
  int? NumberOfProducts = null;
  bool? IncludeInTopMenu = null;
  List<Category>? SubCategories = [];
  bool? HaveSubCategories = false;
  String? Route = null;
  String? IconUrl = null;
  int? Id = null;

  Category({
    this.Name,
    this.SeName,
    this.NumberOfProducts,
    this.IncludeInTopMenu,
    this.SubCategories,
    this.HaveSubCategories,
    this.Route,
    this.IconUrl,
    this.Id,
  });

  factory Category.fromJson(Map<String, dynamic> jsonData) {
    return Category(
      Id: jsonData['id'],
      Name: jsonData['name'],
    );
  }

  static Map<String, dynamic> toMap(Category category) => {
        'id': category.Id,
        'name': category.Name,
      };

  static String encode(List<Category> categories) => json.encode(
        categories
            .map<Map<String, dynamic>>((item) => Category.toMap(item))
            .toList(),
      );

  static List<Category> decode(String category) =>
      (json.decode(category) as List<dynamic>)
          .map<Category>((item) => Category.fromJson(item))
          .toList();
}
