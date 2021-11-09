import 'dart:convert';
import 'dart:developer';
import 'package:anyvas/models/httpRequest.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  String manufacturerName;
  String discountName;
  String name;
  String shortDescription;
  String fullDescription;
  String? sku;
  int? productType;
  bool? markAsNew;
  ProductPrice? productPrice;
  PictureModel? defaultPictureModel;
  List<PictureModel>? picturModels = [];
  ProductSpecificationModel? productSpecificationModel;
  ReviewOverviewModel? reviewOverviewModel;
  int id;

  String get ratting {
    if (reviewOverviewModel != null) {
      double rating =
          (reviewOverviewModel!.ratingSum / reviewOverviewModel!.totalReviews);
      // print(rating);
      if (rating > 0) {
        return (rating).toStringAsFixed(1);
      }
    }
    return "NaN";
  }

  Product({
    this.name = 'not found',
    this.discountName = "not found",
    this.manufacturerName = "not found",
    this.shortDescription = "not found",
    this.fullDescription = "not found",
    this.productPrice,
    this.id = -1,
    this.defaultPictureModel,
    this.reviewOverviewModel,
  });

  Future<void> getProductDetails({int? id, int? updatecartitemid = 0}) async {
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${HttpRequest.serverUrl}/productdetails/$id/$updatecartitemid'));
      request.body = json.encode({
        "Id": id,
        "updatecartitemid": updatecartitemid,
      });
      request.headers.addAll(HttpRequest.headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();

        final extractedData = json.decode(responseData) as Map<String, dynamic>;
        final productData = extractedData['Data'] as Map;
        name = productData['Name'];

        var dpmData = productData['DefaultPictureModel'];
        PictureModel dpm = PictureModel(
          imageUrl: dpmData['ImageUrl'],
          // thumbImageUrl: dpmData['ThumbImageUrl'],
          fullSizeImageUrl: dpmData['FullSizeImageUrl'],
          title: dpmData['Title'],
          alternateText: dpmData['AlternateText'],
        );
        defaultPictureModel = dpm;
        // log(defaultPictureModel!.imageUrl.toString());
        notifyListeners();
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}

class ProductPrice {
  String currencyCode = "Tk";
  String oldPrice = "not found";
  String price = "not found";
  String priceWithDiscount = "not found";
  double priceValue;
  String? basePricePAngV;
  bool? disableBuyButton;
  bool? disableWishlistButton;
  bool? disableAddToCompareListButton;
  bool? availableForPreOrder;
  String? preOrderAvailabilityStartDateTimeUtc;
  bool? isRental;
  bool? forceRedirectionAfterAddingToCart;
  bool? displayTaxShippingInfo;
  Map? customProperties;

  ProductPrice({
    this.oldPrice = "not found",
    this.price = "not found",
    this.priceValue = 0.00,
    this.priceWithDiscount = "not found",
    this.basePricePAngV = "not found",
    this.disableBuyButton,
    this.disableWishlistButton,
    this.disableAddToCompareListButton,
    this.availableForPreOrder,
    this.preOrderAvailabilityStartDateTimeUtc,
    this.isRental,
    this.forceRedirectionAfterAddingToCart,
    this.displayTaxShippingInfo,
    this.customProperties,
  });
}

class PictureModel {
  String imageUrl;
  String thumbImageUrl;
  String fullSizeImageUrl;
  String? title;
  String? alternateText;
  Map? customProperties;

  PictureModel({
    this.imageUrl = "assets/images/product-placeholder.png",
    this.thumbImageUrl = "assets/images/product-placeholder.png",
    this.fullSizeImageUrl = "assets/images/product-placeholder.png",
    this.title,
    this.alternateText,
    this.customProperties,
  });
}

class ProductSpecificationModel {
  List<String>? groups;
  Map? customProperties;
  Map model = {
    "Groups": [],
    "CustomProperties": {},
  };
}

class ReviewOverviewModel {
  int? productId;
  int ratingSum;
  int totalReviews;
  bool? allowCustomerReviews;
  bool? canAddNewReview;
  Map? customProperties;

  ReviewOverviewModel({
    this.ratingSum = -1,
    this.totalReviews = 1,
  });
}
