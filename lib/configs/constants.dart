import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'size_config.dart';

// const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryColor = Color(0xff001a41);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xffe99800);
const kSecondaryColor2 = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kSuccessColor = Colors.green;
const kCurrencyColor = Colors.green;
const socialIconBackgroundColor = Color(0xffededed);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: proportionateWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 300);
const progressIndicator = CupertinoActivityIndicator(
  radius: 20,
);

// Form Regex
final RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z.]+");
final RegExp phoneNumberRegExp = RegExp(r"^(088|\+88){0,1}0[0-9]{10}");

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: proportionateWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(proportionateWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}
