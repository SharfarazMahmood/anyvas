import 'package:anyvas/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      product = Provider.of<Product>(context);
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
                      title: Text(
                        product!.name,
                        style: const TextStyle(
                          backgroundColor: Colors.black54,
                        ),
                      ),
                      background: CachedNetworkImage(
                        imageUrl: product!.defaultPictureModel!.imageUrl,
                        placeholder: (context, url) =>
                            const Center(child: Text("Loading...")),
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
