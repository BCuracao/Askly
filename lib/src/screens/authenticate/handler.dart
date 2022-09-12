import 'package:askly/src/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'register.dart';

class Handler extends StatefulWidget {
  @override
  _HandlerState createState() => _HandlerState();
}

class _HandlerState extends State<Handler> {
  bool showSignin = true;

  void toggleView() {
    setState(() => showSignin = !showSignin);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignin) {
      return LoginScreen(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
