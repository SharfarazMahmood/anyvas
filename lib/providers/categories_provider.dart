import 'dart:convert';
import 'package:anyvas/models/httpRequest.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//////// import of config files ////////
import '../helpers/storage_helper.dart';
import '../models/category.dart';

class CategoriesProvider with ChangeNotifier {
  List<Category> _items = [];

  CategoriesProvider() {}

  List<Category> get items {
    return [..._items];
  }

  Future<void> getCategories() async {
    String? _savedData = null;
    await StorageHelper.loadData(key: 'categoryList').then((String result) {
      _savedData = result;
    });
    if (_savedData != null &&
        !_savedData!.contains("no data found in storage.")) {
      _items = Category.decode(_savedData!);
      notifyListeners();
    }

    if (_items.length <= 0) {
      await fetchFromAPI();
    }
  }

  Future<bool> fetchFromAPI() async {
    try {
      var request = http.Request(
          'GET', Uri.parse('http://incap.bssoln.com/api/categories'));
      request.headers.addAll(HttpRequest.headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();

        final extractedData = json.decode(responseData) as Map<String, dynamic>;
        final categoriesData = extractedData['Data']['Categories'] as List;
        _items = createCategoryObject(categoriesData);
        notifyListeners();

        String toBeSaved = Category.encode(_items);
        try {
          await StorageHelper.saveData(key: "categoryList", data: toBeSaved);
        } on Exception catch (e) {
          print(e);
        }
        return true;
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (error) {
      print(error.toString());
      throw error;
    }
    return false;
  }

  List<Category> createCategoryObject(List<dynamic> categoriesData) {
    List<Category> list = [];
    for (var i = 0; i < categoriesData.length; i++) {
      list.add(Category(
        Name: categoriesData[i]['Name'],
        SeName: categoriesData[i]['SeName'],
        NumberOfProducts: categoriesData[i]['NumberOfProducts'],
        IncludeInTopMenu: categoriesData[i]['IncludeInTopMenu'],
        // SubCategories: categoriesData[i]['SubCategories'],
        HaveSubCategories: categoriesData[i]['HaveSubCategories'],
        Route: categoriesData[i]['Route'],
        IconUrl: categoriesData[i]['IconUrl'],
        Id: categoriesData[i]['Id'],
      ));
    }
    return list;
  }
}
