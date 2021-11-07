import 'package:flutter/material.dart';
//////// import of config files ////////
import '../../../configs/constants.dart';
import '../../../configs/size_config.dart';
//////// import of other screens, widgets ////////
import '../../../screens/login/login_screen.dart';
import '../../../screens/signup/components/signup_form.dart';
import '../../../widgets/alter_login_signup.dart';
import '../../../widgets/social_icon.dart' as socialIcons;

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: proportionateHeight(20),
            vertical: proportionateWidth(5),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Text(
                  "Registration",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: proportionateWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Text(
                  "Fill up the form \nor continue with social accounts.",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: proportionateWidth(15),
                  ),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                socialIcons.iconsRow,
                SizedBox(height: proportionateHeight(20)),
                AlterLoginSignup(
                  text: "Alredy a Member?",
                  route: LoginScreen.routeName,
                  routeText: "Login",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
