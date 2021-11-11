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

  String get rating {
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
        await createProductObject(responseData);
        notifyListeners();
      } else {
        print(response.reasonPhrase);
      }
    } on Exception catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<void> createProductObject(String responseData) async {
    final extractedData = json.decode(responseData) as Map<String, dynamic>;
    final productData = extractedData['Data'] as Map;

    var dpmData = productData['DefaultPictureModel'];
    PictureModel dpm = PictureModel(
      imageUrl: dpmData['ImageUrl'],
      fullSizeImageUrl: dpmData['FullSizeImageUrl'],
      title: dpmData['Title'],
      alternateText: dpmData['AlternateText'],
    );
    var productPriceData = productData['ProductPrice'];
    ProductPrice priceData = ProductPrice(
      oldPrice: productPriceData['OldPrice'] ?? "",
      price: productPriceData['Price'],
      priceValue: productPriceData['PriceValue'],
    );
    var reviewData = productData['ProductReviewOverview'];
    ReviewOverviewModel rom = ReviewOverviewModel(
      ratingSum: reviewData['RatingSum'],
      totalReviews: reviewData['TotalReviews'],
    );

    this.name = productData['Name'];
    this.manufacturerName = productData['ProductManufacturers'][0]['Name'];
    this.shortDescription = productData['ShortDescription'];
    this.fullDescription = productData['FullDescription'];
    this.defaultPictureModel = dpm;
    this.productPrice = priceData;
    this.reviewOverviewModel = rom;
    this.discountName = productData['DiscountName'];
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
