import 'package:anyvas/configs/constants.dart';
import 'package:anyvas/configs/size_config.dart';
import 'package:anyvas/screens/components/ratings/RatingStars.dart';
import 'package:anyvas/screens/components/ratings/rating.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
//////// import of other screens, widgets ////////
import '../../../../models/product_model.dart';
import '../../../../models/screen_arguments.dart';
import '../../../product/product_details.dart';

class NewProductItem extends StatelessWidget {
  const NewProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return Card(
      child: Container(
        width: proportionateWidth(130),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailsScreen.routeName,
              arguments: ScreenArguments(
                id: product.id,
                title: product.name,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: product.defaultPictureModel!.imageUrl,
                      placeholder: (context, url) => progressIndicator,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                SizedBox(height: proportionateHeight(10)),
                Text(
                  product.manufacturerName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: proportionateHeight(5)),
                Text(
                  product.name,
                  softWrap: false,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: proportionateHeight(5)),
                FittedBox(
                  child: Row(
                    children: [
                      Text(
                        product.productPrice!.price,
                        style: TextStyle(
                          color: kCurrencyColor,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: proportionateWidth(5)),
                      Text(
                        product.productPrice!.oldPrice,
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: proportionateHeight(10)),
                product.rating == "NaN"
                    ? Text("  ")
                    : Rating(rating: product.rating),
                SizedBox(
                  child: RatingStars(
                    rating: product.rating,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
