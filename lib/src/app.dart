import 'package:askly/models/firebaseuser.dart';
import 'package:askly/src/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'Askly',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
