import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//////// import of other screens, widgets ////////
import '../../../providers/product_list_provider.dart';
import '../../../screens/product/product_item.dart';

class ProductList extends StatelessWidget {
  final int? catId;
  final _noDataText = "Unable to reach server...\n Please Try again later";

  ProductList({Key? key, this.catId = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData =
        Provider.of<ProductListProvider>(context, listen: false);

    final products = productsData.items;
    List<Widget> gridItemList = products
        .map((item) => ChangeNotifierProvider.value(
              value: item,
              child: ProductItem(),
            ))
        .toList();

    return products.isEmpty
        ? ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20.0),
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 300,
                ),
                child: Center(
                  child: Text(_noDataText),
                ),
              ),
            ],
          )
        : GridView.extent(
            childAspectRatio: 9/16,
            maxCrossAxisExtent: 300,
            padding: const EdgeInsets.all(4),
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            children: gridItemList,
          );
  }
}
