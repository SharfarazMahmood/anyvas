import 'package:anyvas/configs/constants.dart';
import 'package:anyvas/models/category.dart';
import 'package:anyvas/screens/home/main_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//////// import of other screens, widgets ////////
import '../../models/screen_arguments.dart';
import '../../providers/categories_provider.dart';

class CategoriesList extends StatefulWidget {
  CategoriesList();

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<CategoriesProvider>(context);
    final categories = categoriesData.items;

    return createCategoryList(categories, context);
  }

  Widget createCategoryList(List<Category>? categories, BuildContext context) {
    return categories == null
        ? Center(
            child: Text("No data found (createCategoryList)"),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                for (Category subCat in categories)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0),
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
                                        MainView.routeName,
                                        arguments: ScreenArguments(
                                          id: subCat.id,
                                          title: subCat.name,
                                          categorySelected: true,
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
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: createCategoryList(
                                    subCat.subCategories, context),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
  }
}
