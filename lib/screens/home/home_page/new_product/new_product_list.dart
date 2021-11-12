import 'package:anyvas/screens/home/home_page/new_product/new_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//////// import of other screens, widgets ////////
import '../../../../providers/product_list_provider.dart';

class NewProductList extends StatelessWidget {
  final int? catId;
  final _noDataText = "Unable to reach server...\n Please Try again later";

  NewProductList({Key? key, this.catId = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData =
        Provider.of<ProductListProvider>(context, listen: false);

    final products = productsData.items;
    return products.isEmpty
        ? Center(
            child: Text(_noDataText),
          )
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: products[index],
              child: NewProductItem(),
            ),
          );
  }
}
