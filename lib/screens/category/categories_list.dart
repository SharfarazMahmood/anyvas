import 'package:anyvas/configs/constants.dart';
import 'package:anyvas/configs/size_config.dart';
import 'package:anyvas/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//////// import of other screens, widgets ////////
import '../../models/screen_arguments.dart';
import '../../screens/products_overview_screen.dart';
import '../../providers/categories_provider.dart';

class CategoriesList extends StatefulWidget {
  CategoriesList();

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  double height = proportionateHeight(40);
  double _sizedBoxWidth = proportionateWidth(20);

  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<CategoriesProvider>(context);
    final categories = categoriesData.items;

    return createCategoryList2(categories, context);
  }

  Widget createCategoryList2(List<Category>? categories, BuildContext context) {
    return categories == null
        ? Center(
            child: Text("No data found (createCategoryList)"),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                for (Category subCat in categories)
                  SingleChildScrollView(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Card(
                          elevation: 4,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                          ProductsOverviewScreen.routeName,
                                          arguments: ScreenArguments(
                                            id: subCat.id,
                                            title: subCat.name,
                                          ),
                                        );
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${subCat.name}",
                                          style: TextStyle(color: kTextColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (subCat.haveSubCategories == true)
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            subCat.isExpanded =
                                                !subCat.isExpanded;
                                          });
                                        },
                                        icon: Icon(subCat.isExpanded
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down),
                                      ),
                                    ),
                                ],
                              ),
                              if (subCat.haveSubCategories == true &&
                                  subCat.isExpanded)
                                createCategoryList2(
                                    subCat.subCategories, context)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
  }
}
