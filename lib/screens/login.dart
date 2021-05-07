import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo-only-text.png', height: 250, width: 300,),
              Container(
                width: 300,
                child: Column(children: [
                  SignInButton(Buttons.GoogleDark, onPressed: () => authService.googleSignIn(context)),
                  SignInButton(Buttons.AppleDark, onPressed: () => null)
              ]),)
            ],
          )
        )
      )
    );
  }
}
