import 'package:flutter/material.dart';

class RatingItem extends StatelessWidget {
  final int index;
  final double rating;

  const RatingItem({Key key, this.index, this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      index <= rating ? 'assets/icon_star.png' : 'assets/icon_star_grey.png',
      width: 20,
    );
  }
}
