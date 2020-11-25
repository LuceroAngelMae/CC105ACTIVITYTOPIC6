import 'package:flutter/material.dart';
import 'package:topic6/screens/auth/register.dart';

import 'package:topic6/screens/auth/signin.dart';

class Authenticate extends StatefulWidget {
  @override
  AuthenticateState createState() => AuthenticateState();
}

class AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
