import 'package:flutter/material.dart';
import 'package:gps/UI/frontPage.dart';
import 'UI/google/g_map.dart';


void main() => runApp(MaterialApp(
  routes: {
    '/': (context) => loginPage()
  },
  initialRoute: '/',
));