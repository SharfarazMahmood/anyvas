import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//////// import of config files ////////
import '../../../../configs/constants.dart';
import '../../../../configs/size_config.dart';
//////// import of other screens, widgets ////////
import '../../../../providers/new_products_list_provider.dart';
import '../../../../screens/home/home_page/new_product/new_product_list.dart';


class NewProducts extends StatefulWidget {
  @override
  State<NewProducts> createState() => _NewProductsState();
}

class _NewProductsState extends State<NewProducts> {
  var _isLoading = false;
  var _isInit = true;

  _NewProductsState();

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

      var productsList =
          Provider.of<NewProductListProvider>(context, listen: false);
      productsList.getNewProducts().then((value) {
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
                  child: NewProductList(),
                ),
        ],
      ),
    );
  }
}
