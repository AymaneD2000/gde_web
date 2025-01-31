import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  MyCard({super.key, required this.text});
  String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Text(text),
    );
  }
}
