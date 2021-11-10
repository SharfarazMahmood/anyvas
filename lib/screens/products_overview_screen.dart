import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//////// import of config files ////////
import '../configs/constants.dart';
//////// import of other screens, widgets ////////
import '../models/screen_arguments.dart';
import '../providers/product_list_provider.dart';
import '../screens/product/product_list.dart';

class ProductsOverviewScreen extends StatefulWidget {
  static String routeName = '/productOverview';
  int catId = 1;
  String catName = "  ";

  ProductsOverviewScreen({this.catId = 1, this.catName = "  "});

  @override
  State<ProductsOverviewScreen> createState() =>
      _ProductsOverviewScreenState(catId: catId, catName: catName);
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _isLoading = false;
  var _isInit = true;

  int catId;
  String catName = "  ";

  _ProductsOverviewScreenState({this.catId = 1, this.catName = "  "});

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductListProvider>(context, listen: false)
        .getProducts(catId: catId);
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: AppBar(
          title: Text("Category: $catName"),
          titleTextStyle: TextStyle(fontSize: 14, color: kSecondaryColor2),
          automaticallyImplyLeading: false,
        ),
      ),
      // drawer: AppDrawer(),
      body: _isLoading
          ? const Center(
              child: progressIndicator,
            )
          : RefreshIndicator(
              color: kSecondaryColor,
              onRefresh: () => _refreshProducts(context),
              child: ProductList(catId: catId),
            ),
    );
  }
}
