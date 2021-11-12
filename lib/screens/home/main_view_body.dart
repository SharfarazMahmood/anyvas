import 'package:anyvas/screens/home/home_page/new_product/newProducts.dart';
import 'package:flutter/material.dart';

class MainViewBody extends StatefulWidget {
  const MainViewBody({ Key? key }) : super(key: key);

  @override
  _MainViewBodyState createState() => _MainViewBodyState();
}

class _MainViewBodyState extends State<MainViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NewProducts(),
          ],
        ),
      ),
    );
  }
}