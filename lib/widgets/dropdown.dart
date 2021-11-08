import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//////// import of config files ////////
import '../configs/enums.dart';
import '../configs/constants.dart';
//////// import of other screens, widgets ////////
import '../providers/login_provider.dart';
import '../screens/signup/signup_screen.dart';
import '../screens/login/login_screen.dart';

class DropDownMenu extends StatefulWidget {
  DropDownMenu({Key? key}) : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
        builder: (BuildContext context, user, Widget? _) {
      return PopupMenuButton(
        onSelected: (AuthenticationType selectedValue) {
          // setState(() {
          if (selectedValue == AuthenticationType.Login) {
            Navigator.of(context).pushNamed(LoginScreen.routeName);
          } else if (selectedValue == AuthenticationType.Logout) {
            user.logout();
          } else if (selectedValue == AuthenticationType.Signup) {
            Navigator.of(context).pushNamed(SignupScreen.routeName);
          } else if (selectedValue == AuthenticationType.None) {}
          // });
        },
        child: Row(
          children: <Widget>[
            Text(
              "${user.loggedIn ? user.user!.firstName : ' '}",
              style: TextStyle(color: kTextColor),
            ),
            SizedBox(width: 4),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(Icons.settings),
            ),
          ],
        ),
        itemBuilder: (_) => [
          PopupMenuItem(
              child: user.loggedIn
                  ? rowItem('Profile', Icons.account_circle)
                  : rowItem('Sigup', Icons.person_add),
              value: user.loggedIn
                  ? AuthenticationType.None
                  : AuthenticationType.Signup),
          PopupMenuItem(
            child: user.loggedIn
                ? rowItem('Logout', Icons.logout)
                : rowItem('Login', Icons.login),
            value: user.loggedIn
                ? AuthenticationType.Logout
                : AuthenticationType.Login,
          ),
        ],
      );
    });
  }

  Row rowItem(String text, IconData icon) {
    return Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}
