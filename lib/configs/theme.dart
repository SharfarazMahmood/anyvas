import 'package:flutter/material.dart';
//////// import of config files ////////
import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Color(0xfff5f5f6),
    fontFamily: "Muli",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.compact,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    // borderRadius: BorderRadius.circular(5),
    // // borderSide: const BorderSide(color: kTextColor),
    // gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    // contentPadding: const EdgeInsets.symmetric(
    //   horizontal: 20,
    //   vertical: 10,
    // ),
    // // enabledBorder: outlineInputBorder,
    // // focusedBorder: outlineInputBorder,
    // border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Color(0xfff5f5f6),
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Color(0xffe99800)),
    titleTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    textTheme: TextTheme(
      headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    ),
  );
}
