import 'package:flutter/material.dart';
//////// import of config files ////////
import '../../../configs/constants.dart';
import '../../../configs/size_config.dart';
//////// import of other screens, widgets ////////
import '../../../screens/signup/signup_screen.dart';
import '../../../widgets/alter_login_signup.dart';
import '../../../widgets/social_icon.dart' as socialIcons;

import 'login_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: proportionateWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Welcome", style: headingStyle),
                Text(
                  "Login with email/phone & password \nor Continue with social account",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                LoginForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                socialIcons.iconsRow,
                SizedBox(height: proportionateHeight(20)),
                AlterLoginSignup(
                  text: "Don't have an account?",
                  route: SignupScreen.routeName,
                  routeText: "Sign up",
                ),
                SizedBox(height: proportionateHeight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
