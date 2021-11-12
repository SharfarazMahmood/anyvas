import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
//////// import of config files ////////
import 'package:anyvas/models/httpRequest.dart';
import 'package:anyvas/models_object_create_module/createProductsList.dart';
import '../models/product_model.dart';

class NewProductListProvider with ChangeNotifier {
  List<Product> _items = [];

  NewProductListProvider();

  List<Product> get items {
    return [..._items];
  }

  Future<void> getNewProducts() async {
    String responseData = "-1";
    try {
      responseData = await compute<int, String>(fetchFromApi, 1);
    } on Exception catch (error) {
      print("newProd provider :: ${error.toString()}");
    } finally {
      if (responseData == "-1") {
        print(
            'newProd provider:: could not reach server !! Please try again later.');
      } else {
        final extractedData = json.decode(responseData) as Map<String, dynamic>;
        final productsData = extractedData['Data'] as List;
        _items = await createProductsList(productsData);
        notifyListeners();
      }
    }
  }
}

/////////// using http request to get products data from API
Future<String> fetchFromApi(int id) async {
  try {
    var request = http.Request(
      'GET',
      Uri.parse('${HttpRequest.newProductsApi}'),
    );
    request.headers.addAll(HttpRequest.headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      return responseData;
    } else {
      print("${response.statusCode}  ${response.reasonPhrase}");
    }
  } on Exception catch (error) {
    print(error.toString());
    throw error;
  }
  return "-1";
}
