import 'package:flutter/material.dart';
//////// import of config flies ////////
import '../../../configs/constants.dart';
//////// import of other screens, widgets ////////
import '../../../models/screen_arguments.dart';
import '../../../screens/home/main_view_body.dart';
import '../../../screens/products_overview_screen.dart';
import '../../../widgets/app_drawer.dart';
import '../../../widgets/dropdown.dart';

class MainView extends StatefulWidget {
  static String routeName = "/main-view";

  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  String _title = "Anyvas";
  List<Widget> _mainViewPages = [];
  int _currentIndex = 0;

  var _isLoading = false;
  var _isInit = true;

  int catId = 1;
  String catName = "  ";

  @override
  void initState() {
    _mainViewPages = [
      MainViewBody(),
      ProductsOverviewScreen(catId: catId, catName: catName),
      Center(child: Text("Cart", style: TextStyle(fontSize: 20))),
    ];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      bool? isCategory = false;
      if (ModalRoute.of(context)!.settings.arguments == null) {
        catId = 1;
      } else {
        var args =
            ModalRoute.of(context)!.settings.arguments as ScreenArguments;
        catId = args.id!;
        catName = args.title.toString();
        isCategory = args.categorySelected;
      }
      setState(() {
        if (isCategory != null && isCategory) {
          _currentIndex = 1;
        }
        _isLoading = false;
      });
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: <Widget>[DropDownMenu()],
      ),
      drawer: AppDrawer(),
      body: _mainViewPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10.0,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        unselectedItemColor: kSecondaryColor2,
        selectedItemColor: kSecondaryColor,
        selectedFontSize: 15,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: kSecondaryColor2,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Products",
            backgroundColor: kSecondaryColor2,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
            backgroundColor: kSecondaryColor2,
          ),
        ],
      ),
    );
  }
}
