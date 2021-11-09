import 'dart:convert';
import 'dart:developer';
import 'package:anyvas/models/httpRequest.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//////// import of config files ////////
import '../models/product_model.dart';

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
        _items = await createProductObject(responseData);
        // _items.forEach((item) {
          // print(item.reviewOverviewModel!.ratingSum);
          // print(item.reviewOverviewModel!.totalReviews);
          //   print(item.productPrice!.oldPrice);
          //   print(item.productPrice!.price);
          //   print(item.productPrice!.priceValue);
          // print(item.ratting);
          // print('------------------------------');
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

////////// converting API resopnseData string to a product list
Future<List<Product>> createProductObject(String responseData) async {
  List<Product> list = [];
  final extractedData = json.decode(responseData) as Map<String, dynamic>;
  final productsData =
      extractedData['Data']['CatalogProductsModel']['Products'] as List;

  for (var i = 0; i < productsData.length; i++) {
    var dpmData = productsData[i]['DefaultPictureModel'];
    PictureModel dpm = PictureModel(
      imageUrl: dpmData['ImageUrl'],
      fullSizeImageUrl: dpmData['FullSizeImageUrl'],
      title: dpmData['Title'],
      alternateText: dpmData['AlternateText'],
    );
    var productPriceData = productsData[i]['ProductPrice'];
    ProductPrice priceData = ProductPrice(
      oldPrice: productPriceData['OldPrice'] ?? "",
      price: productPriceData['Price'],
      priceValue: productPriceData['PriceValue'],
    );
    var reviewData = productsData[i]['ReviewOverviewModel'];
    ReviewOverviewModel rom = ReviewOverviewModel(
      ratingSum: reviewData['RatingSum'],
      totalReviews: reviewData['TotalReviews'],
    );

    list.add(Product(
      name: productsData[i]['Name'],
      discountName: productsData[i]['DiscountName'],
      id: productsData[i]['Id'],
      manufacturerName: productsData[i]['ManufacturerName'],
      defaultPictureModel: dpm,
      productPrice: priceData,
      reviewOverviewModel: rom,
    ));
  }
  return list;
}
