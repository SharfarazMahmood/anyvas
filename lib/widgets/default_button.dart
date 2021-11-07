import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.onPressed,
  }) : super(key: key);
  final String? text;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('$text'),
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
        textStyle: TextStyle(
          color: Theme.of(context).primaryTextTheme.button!.color,
        ),
      ),
    );
  }
}
