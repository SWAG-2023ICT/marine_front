import 'package:flutter/material.dart';

class CenteredDivider extends StatelessWidget {
  final String text;
  final double thickness;
  final double fontSize;
  final Color color;

  const CenteredDivider({
    super.key,
    required this.text,
    this.thickness = 1.0,
    this.fontSize = 16.0,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            thickness: thickness,
            color: color,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: thickness,
            color: color,
          ),
        ),
      ],
    );
  }
}
