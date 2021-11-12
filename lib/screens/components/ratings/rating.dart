import 'package:anyvas/configs/constants.dart';
import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  const Rating({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: kSecondaryColor,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Text("${rating.toStringAsFixed(1)}"),
    );
  }
}
