import 'package:flutter/material.dart';
import 'package:gps/UI/Admin/adminbasePage.dart';
import 'package:gps/UI/Driver/driverbase.dart';
import 'package:gps/UI/User/basePage.dart';
import 'package:gps/UI/core/layouts/loading.dart';
import 'UI/Auth/login/frontPage.dart';
import 'UI/Auth/signup/signup.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => loading(),
      '/login': (context) => loginPage(),
      '/signup': (context) => signupPage(),
      '/userbase': (context) => basePage(),
      '/agentbase': (context) => adminbasePage(),
      '/driverbase': (context) => driverbase(),
    },
  ));
}