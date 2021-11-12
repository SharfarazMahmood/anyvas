import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
//////// import of config files ////////
import '../models/product_model.dart';
import 'package:anyvas/models/httpRequest.dart';
import 'package:anyvas/models_object_create_module/createProductsList.dart';

class ProductListProvider with ChangeNotifier {
  List<Product> _items = [];

  ProductListProvider();

  List<Product> get items {
    return [..._items];
  }

  Future<void> getProducts({int? catId = 1}) async {
    String responseData = "-1";
    try {
      responseData = await compute<int?, String>(fetchFromApi, catId);
    } on Exception catch (error) {
      print(error.toString());
    } finally {
      if (responseData == "-1") {
        print('could not reach server !! Please try again later.');
      } else {
        final extractedData = json.decode(responseData) as Map<String, dynamic>;
        final productsData =
            extractedData['Data']['CatalogProductsModel']['Products'] as List;
        _items = await createProductsList(productsData);
        // _items.forEach((item) {
        //   print(item.productPrice!.price);
        //   print('------------------------------');
        // });
        notifyListeners();
      }
    }
  }
}

/////////// using http request to get products data from API
Future<String> fetchFromApi(int? id) async {
  try {
    var request = http.Request(
      'GET',
      Uri.parse('${HttpRequest.serverUrl}/category/$id'),
    );
    request.body = json.encode({"Id": id});
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
