import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//////// import of other screens, widgets ////////
import '../../models/screen_arguments.dart';
import '../../screens/products_overview_screen.dart';
import '../../providers/categories_provider.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList();
  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<CategoriesProvider>(context);
    final categories = categoriesData.items;

    return ListView.builder(
      // shrinkWrap: true,
      itemCount: categories.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: categories[index],
        child: ListTile(
          // leading:const Icon(Icons.category),
          title: Text(
            '${categories[index].Name}',
            // style: const TextStyle(color: Colors.white),
          ),
          onTap: () {
            // String categoryId = '${categories[index].Id}';
            Navigator.of(context).pushReplacementNamed(
              ProductsOverviewScreen.routeName,
              arguments: ScreenArguments(
                id: categories[index].Id,
                title: categories[index].Name,
              ),
            );
          },
        ),
      ),
    );
  }
}
