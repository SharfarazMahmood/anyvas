import 'dart:convert';
import 'package:flutter/material.dart';

class Category with ChangeNotifier {
  String? name = '';
  String? seName = '';
  int? numberOfProducts = null;
  bool? includeInTopMenu = null;
  List<Category>? subCategories = [];
  bool? haveSubCategories = false;
  String? route = null;
  String? iconUrl = null;
  int? id = null;
  bool isExpanded = false;

  Category({
    this.name,
    this.seName,
    this.numberOfProducts,
    this.includeInTopMenu,
    this.subCategories,
    this.haveSubCategories,
    this.route,
    this.iconUrl,
    this.id,
  });

  factory Category.fromJson(Map<String, dynamic> jsonData) {
    return Category(
      id: jsonData['id'],
      name: jsonData['name'],
    );
  }

  static Map<String, dynamic> toMap(Category category) => {
        'id': category.id,
        'name': category.name,
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
