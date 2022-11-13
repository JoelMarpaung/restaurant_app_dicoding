import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splashscreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(
          context, '/home_page', (route) => false);
    });

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Image.asset(
          'assets/splashscreen.jpeg',
        ),
      ),
    );
  }
}
