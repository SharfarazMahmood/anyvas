import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//////////// import of config files ////////////
import '../configs/size_config.dart';
//////////// import of screens, widgets ////////////
import '../providers/auth_provider.dart';
import '../screens/products_overview_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  //////////// methods ////////////
  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProductsOverviewScreen()),
      );
    });
  }

  //////////// overriden methods ////////////
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var auth = Provider.of<AuthProvider>(context, listen: false);
    auth.autoLogin();
    if (auth.loggedIn) {
    } else if (!auth.loggedIn) {}
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // SizedBox(
                // child: 
                Image(
                  height: proportionateHeight(80),
                  width: proportionateWidth(80),
                  image: AssetImage('assets/images/logo/anyvas-icon-Logo.png'),
                ),
              // ),
              Text(
                "Anyvas",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffe99800),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
