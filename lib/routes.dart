import 'package:flutter/material.dart';
import 'package:gatecheck_frontend/screens/home.dart';
import 'package:gatecheck_frontend/screens/login.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/login': (ctx) => LoginPage(),
  '/register': (ctx) => null,
  '/home': (ctx) => HomePage(),
  '/profile': (ctx) => null,
  '/change/email': (ctx) => null,
  '/change/password': (ctx) => null,
};