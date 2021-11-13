import 'package:flutter/material.dart';
import 'package:gps/UI/core/layouts/loading.dart';
import 'package:gps/UI/google/g_map.dart';
import 'UI/Auth/login/frontPage.dart';
import 'UI/Auth/signup/signup.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/login': (context) => loginPage(),
      '/signup': (context) => signupPage(),
      '/g_map': (context) => g_map(),
      '/': (context) => loading(),
    },
  ));
}