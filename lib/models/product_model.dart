import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductMdl with ChangeNotifier {
  String? manufacturerName;
  String? discountName;
  String name = 'not found';
  String? shortDescription;
  String? fullDescription;
  String? sku;
  int? productType;
  bool? markAsNew;
  ProductPrice? productPrice;
  PictureModel? defaultPictureModel;
  List<PictureModel>? picturModels = [];
  ProductSpecificationModel? productSpecificationModel;
  ReviewOverviewModel? reviewOverviewModel;
  int id;

  ProductMdl({
    this.name = 'not found',
    this.id = -1,
    this.defaultPictureModel,
  });



  Future<void> getProductDetails({int? id, int? updatecartitemid = 0}) async {
    var headers = {
      'NST':
          'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJOU1RfS0VZIjoidGVzdGFwaTEyM3Nha2hhdyJ9.l9txvKvpCrPsW78C9CFfUEVBbZcPpC7kBESRWBUthWjBG6dfP0YgrtoNKoe-PHExT_LGzYXoT1vvxGzWKxDGMA',
      'Token':
          'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJOU1RfS0VZIjoidGVzdGFwaTEyM3Nha2hhdyJ9.ca-7lHYgFnU_LXR_Q6_j3pIVb8oAkbn7kDonJn_4SepPhewJ6AHJyLUoITkAsIeOhakoePZ1bjq1rAb3f0GwrQ',
      'DeviceId': 'DeviceId',
      'Content-Type': 'application/json',
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://incap.bssoln.com/api/productdetails/$id/$updatecartitemid'));
    request.body = json.encode({
      "Id": id,
      "updatecartitemid": updatecartitemid,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      // print(responseData);
      // log(responseData);

      final extractedData = json.decode(responseData) as Map<String, dynamic>;
      final productData = extractedData['Data'] as Map;
      name = productData['Name'];
      // productPrice = productData['ProductPrice']['Price'] ;

      // log(name);
      // log(productData['ProductPrice']['Price']);
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
  }
}

class ProductPrice {
  String currencyCode = "Tk";
  String? OldPrice;
  String? Price;
  String? priceWithDiscount;
  int? PriceValue;
  String? BasePricePAngV;
  bool? DisableBuyButton;
  bool? DisableWishlistButton;
  bool? DisableAddToCompareListButton;
  bool? AvailableForPreOrder;
  String? PreOrderAvailabilityStartDateTimeUtc;
  bool? IsRental;
  bool? ForceRedirectionAfterAddingToCart;
  bool? DisplayTaxShippingInfo;
  Map? CustomProperties;

  ProductPrice({
    this.OldPrice,
    this.Price,
    this.PriceValue,
    this.BasePricePAngV,
    this.DisableBuyButton,
    this.DisableWishlistButton,
    this.DisableAddToCompareListButton,
    this.AvailableForPreOrder,
    this.PreOrderAvailabilityStartDateTimeUtc,
    this.IsRental,
    this.ForceRedirectionAfterAddingToCart,
    this.DisplayTaxShippingInfo,
    this.CustomProperties,
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
  int? ratingSum;
  int? totaReviews;
  bool? allowCustomerReviews;
  bool? canAddNewReview;
  Map? customProperties;
}
