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
      final extractedData = json.decode(_savedData!) as Map<String, dynamic>;
      final categoriesData = extractedData['Data']['Categories'] as List;
      _items = createCategoryObject(categoriesData);
      // _items = Category.decode(_savedData!);
      print("--------------From shared preferences------------");
      notifyListeners();
    }

    if (_items.length <= 0) {
      await fetchFromAPI();
    }
  }

  Future<bool> fetchFromAPI() async {
    print("--------------From API------------");
    try {
      var request =
          http.Request('GET', Uri.parse('${HttpRequest.serverUrl}/categories'));
      request.headers.addAll(HttpRequest.headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();

        final extractedData = json.decode(responseData) as Map<String, dynamic>;
        final categoriesData = extractedData['Data']['Categories'] as List;
        _items = createCategoryObject(categoriesData);
        notifyListeners();

        String toBeSaved = responseData;
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

  int level = 1;
  List<Category> createCategoryObject(List<dynamic> categoriesData) {
    List<Category> list = [];
    for (var i = 0; i < categoriesData.length; i++) {
      // print("${categoriesData[i]['Name']}   has sub cat: ${categoriesData[i]['HaveSubCategories'].toString()}");
      List<Category> subCats = [];
      if (categoriesData[i]['HaveSubCategories']) {
        // level++;
        // print('Level ----  $level');
        subCats =
            createCategoryObject(categoriesData[i]['SubCategories'] as List);
        // print('Level ----  $level');
        // level--;
      }
      list.add(Category(
        name: categoriesData[i]['Name'],
        includeInTopMenu: categoriesData[i]['IncludeInTopMenu'],
        subCategories: subCats,
        haveSubCategories: categoriesData[i]['HaveSubCategories'],
        id: categoriesData[i]['Id'],
      ));
    }
    return list;
  }
}
