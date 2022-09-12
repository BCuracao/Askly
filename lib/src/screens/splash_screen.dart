import 'dart:async';

import 'package:askly/src/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../wrapper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*Timer(
        Duration(milliseconds: 3000),
        (() => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen())))); */
    Timer(
        const Duration(milliseconds: 3000),
        () => Navigator.of(context)
                .push(PageRouteBuilder(pageBuilder: (context, animation, _) {
              return Wrapper();
            })));

    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 250,
          child: Image.asset(
              'lib/src/assets/images/askly_splash_screen_one_loop.gif'),
        ),
      ),
    );
  }
}
