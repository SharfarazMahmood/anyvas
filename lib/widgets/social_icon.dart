import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//////// import of config files ////////
import '../configs/size_config.dart';

Row iconsRow = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    SocialIcon(
      icon: "assets/icons/social/google-icon.svg",
      onPressed: () {},
    ),
    SocialIcon(
      icon: "assets/icons/social/facebook-2.svg",
      onPressed: () {},
    ),
  ],
);

class SocialIcon extends StatelessWidget {
  final String? icon;
  final Function? onPressed;
  SocialIcon({
    Key? key,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: proportionateWidth(10)),
        padding: EdgeInsets.all(proportionateWidth(12)),
        height: proportionateHeight(55),
        width: proportionateWidth(55),
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon!),
      ),
    );
  }
}
