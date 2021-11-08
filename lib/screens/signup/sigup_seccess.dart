import 'package:anyvas/configs/constants.dart';
import 'package:anyvas/configs/size_config.dart';
import 'package:anyvas/widgets/default_button.dart';
import 'package:flutter/material.dart';

class SignupSuccessScreen extends StatelessWidget {
  static String routeName = "/signup-success";

  const SignupSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Registration Successful !!",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kSuccessColor,
                fontSize: proportionateWidth(28),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.1),
            DefaultButton(
              text: "CONTINUE",
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.of(context).pushReplacementNamed(
                //   ProductsOverviewScreen.routeName,
                // );
              },
            )
          ],
        ),
      ),
    );
  }
}
