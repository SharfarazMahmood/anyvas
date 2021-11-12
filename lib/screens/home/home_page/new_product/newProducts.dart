import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//////// import of config files ////////
import '../../../../configs/constants.dart';
import 'package:anyvas/configs/size_config.dart';
//////// import of other screens, widgets ////////
// import 'package:anyvas/screens/home/home_page/new_product/new_product_list.dart';
import '../../../../models/screen_arguments.dart';
import '../../../../providers/product_list_provider.dart';

class NewProducts extends StatefulWidget {
  int catId = 1;
  String catName = "  ";

  NewProducts({this.catId = 1, this.catName = "  "});

  @override
  State<NewProducts> createState() =>
      _NewProductsState(catId: catId, catName: catName);
}

class _NewProductsState extends State<NewProducts> {
  var _isLoading = false;
  var _isInit = true;

  int catId;
  String catName = "  ";

  _NewProductsState({this.catId = 1, this.catName = "  "});

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
        catId = 1;
      } else {
        var args =
            ModalRoute.of(context)!.settings.arguments as ScreenArguments;
        catId = args.id!;
        catName = args.title.toString();
      }
      var productsList = Provider.of<ProductListProvider>(
        context,
      );
      productsList.getProducts(catId: catId).then((value) {
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
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("New Products"),
          ),
          _isLoading
              ? const Center(
                  child: progressIndicator,
                )
              : Container(
                  height: proportionateHeight(250),
                  // child: NewProductList(catId: catId,),
                ),
        ],
      ),
    );
  }
}
