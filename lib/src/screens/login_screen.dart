import 'package:askly/models/loginuser.dart';
import 'package:askly/services/auth.dart';
import 'package:askly/src/screens/login_screen_content.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  final Function? toggleView;
  LoginScreen({this.toggleView});
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: _email,
      autofocus: false,
      validator: (value) {
        if (value != null) {
          if (value.contains('@') && value.endsWith('.com')) {
            return null;
          }
          return 'Enter a Valid Email Address';
        }
      },
      decoration: const InputDecoration(
        hintText: 'Email',
        contentPadding:
            EdgeInsets.only(left: 15.0, right: 15.0, top: 30, bottom: 20),
        border: OutlineInputBorder(),
      ),
    );

    final passwordField = TextFormField(
      controller: _password,
      autofocus: false,
      obscureText: _obscureText,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        if (value.trim().length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding:
            const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 35),
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );

    final textButton = TextButton(
      onPressed: () {
        widget.toggleView!();
      },
      child: const Text('New? Register Here'),
    );

    /* Kept just for reference values
    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 0, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => HomeScreen()));
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
    */

    final loginAnonymousButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: const Color.fromARGB(255, 0, 255, 255),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          dynamic result = await _auth.signInAnonymous();
          if (result.uid == null) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(result.code),
                  );
                });
          }
        },
        child: const Text(
          "Login Anonymously",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final loginEmailPasswordButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            dynamic result = await _auth.signInEmailPassword(
              LoginUser(
                email: _email.text,
                password: _password.text,
              ),
            );
            if (result.uid == null) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(result.code),
                    );
                  });
            }
          }
        },
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 1500),
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 0, 255, 255),
                title: const Text("Get Started"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Center(
                        child: Container(
                          width: 275,
                          height: 150,
                          /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                          child: Image.asset(
                              'lib/src/assets/images/askly_logo_1.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 30, bottom: 0),
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                      child: emailField,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 40),
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                      child: passwordField,
                    ),
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 255, 255),
                          borderRadius: BorderRadius.circular(20)),
                      child: loginAnonymousButton,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: loginEmailPasswordButton,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    textButton,
                  ],
                ),
              ),
            ),
            builder: (context, double value, child) {
              return ShaderMask(
                shaderCallback: (rect) {
                  return RadialGradient(
                    radius: value * 5,
                    // ignore: prefer_const_literals_to_create_immutables
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.transparent,
                      Colors.transparent
                    ],
                    stops: const [0.0, 0.55, 0.6, 1.0],
                    center: const FractionalOffset(0.0, 0.70),
                  ).createShader(rect);
                },
                child: child,
              );
            },
          );
        },
      ),
    );
  }
}
