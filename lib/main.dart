import 'package:flutter/material.dart';
import 'package:gps/UI/login/frontPage.dart';
import 'package:gps/UI/login/signup.dart';


void main() => runApp(MaterialApp(
  routes: {
    '/': (context) => loginPage(),
    'signup': (context) => signupPage()
  },
  initialRoute: '/',
));