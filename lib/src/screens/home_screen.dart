import 'package:askly/services/auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService _auth = AuthService();

  Widget build(BuildContext context) {
    final SignOut = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          await _auth.signOut();
        },
        child: const Text(
          'Logout',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Demo App - HomeScreen'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: SignOut,
      ),
    );
  }
}
