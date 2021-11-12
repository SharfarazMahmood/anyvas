import 'package:anyvas/models/product_model.dart';

////////// converting API resopnseData string to a products list
Future<List<Product>> createProductsList(List productsData) async {
  List<Product> list = [];
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
