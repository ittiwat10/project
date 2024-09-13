import 'package:flutter/material.dart';

class Iconlogin extends StatelessWidget {
  final String imagePath;

  const Iconlogin({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.asset(
      imagePath,
      height: 40,
    ));
  }
}
