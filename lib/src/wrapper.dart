import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/firebaseuser.dart';
import 'screens/authenticate/handler.dart';
import 'screens/home_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);

    if (user == null) {
      return Handler();
    } else {
      return HomeScreen();
    }
  }
}
