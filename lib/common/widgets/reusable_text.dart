import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  const ReusableText({super.key, required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      textAlign: TextAlign
          .left, //three lines are used to cut the text overflows so that a particular text is presented properly in a screen
      softWrap: false,
      overflow: TextOverflow.fade,
      style: style,
    );
  }
}
