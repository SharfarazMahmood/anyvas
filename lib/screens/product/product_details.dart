import 'package:anyvas/configs/constants.dart';
import 'package:anyvas/configs/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:cached_network_image/cached_network_image.dart';
//////// import of other screens, widgets ////////
import '../../models/product_model.dart';
import '../../models/screen_arguments.dart';

class ProductDetailsScreen extends StatefulWidget {
  static String routeName = "/ProductDetailsScreen";

  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  var _isLoading = false;
  var _isInit = true;
  int? prodId;
  String prodName = "Product Details";
  Product? product;

  Future<void> _refreshProducts(BuildContext context) async {
    product = Provider.of<Product>(context, listen: false);
    await product!.getProductDetails(id: prodId);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      if (ModalRoute.of(context)!.settings.arguments == null) {
        prodId = 1;
      } else {
        var args =
            ModalRoute.of(context)!.settings.arguments as ScreenArguments;
        prodId = args.id;
        prodName = args.title.toString();
      }
      product = Provider.of<Product>(context, listen: false);
      product!.getProductDetails(id: prodId).then((value) {
        setState(() {
          _isLoading = false;
        });
      });
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: progressIndicator,
            )
          : RefreshIndicator(
              color: const Color(0xffe99800),
              onRefresh: () => _refreshProducts(context),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 300,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: EdgeInsets.only(top: proportionateHeight(25)),
                        child: CachedNetworkImage(
                          imageUrl: product!.defaultPictureModel!.imageUrl,
                          placeholder: (context, url) =>
                              const Center(child: Text("Loading...")),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: proportionateHeight(10)),
                              Text(
                                product!.manufacturerName,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: proportionateHeight(5)),
                              Text(
                                product!.name,
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: proportionateHeight(5)),
                              Row(
                                children: [
                                  Text(
                                    product!.productPrice!.price,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: proportionateWidth(5)),
                                  Text(
                                    product!.productPrice!.oldPrice,
                                    style: TextStyle(
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: proportionateHeight(10)),
                              Row(
                                children: [
                                  SizedBox(
                                    child: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.5,
                                          color: kSecondaryColor,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(6),
                                        ),
                                      ),
                                      child: Text(
                                          "${product!.rating != 'NaN' ? product!.rating : '0.0'}"),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      child: RatingBarIndicator(
                                        rating: double.parse(
                                            "${product!.rating != 'NaN' ? product!.rating : '0.0'}"),
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: proportionateWidth(25),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                child: Html(data: product!.shortDescription),
                              ),
                              Html(data: product!.fullDescription),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
