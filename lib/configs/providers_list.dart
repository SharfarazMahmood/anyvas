import 'package:anyvas/providers/signup_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
//////// import of other screens, widgets ////////
import '../models/product_model.dart';
import '../providers/login_provider.dart';
import '../providers/categories_provider.dart';
import '../providers/product_list_provider.dart';

class ProvidersList {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider.value(
      value: LoginProvider(),
    ),
    ChangeNotifierProvider.value(
      value: SignupProvider(),
    ),
    ChangeNotifierProvider.value(
      value: CategoriesProvider(),
    ),
    ChangeNotifierProvider.value(
      value: ProductListProvider(),
    ),
    ChangeNotifierProvider.value(
      value: Product(),
    )
  ];
}
