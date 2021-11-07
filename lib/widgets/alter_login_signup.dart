import 'package:flutter/material.dart';
//////// import of config files ////////
import '../configs/constants.dart';
import '../configs/size_config.dart';

class AlterLoginSignup extends StatelessWidget {
  final String? text;
  final String? route;
  final String? routeText;
  const AlterLoginSignup({
    Key? key,
    this.text,
    this.route,
    this.routeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$text ",
          style: TextStyle(fontSize: proportionateWidth(16)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, route!),
          child: Text(
            "$routeText",
            style: TextStyle(
              fontSize: proportionateWidth(16),
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
