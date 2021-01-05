import 'package:flutter/material.dart';
import 'package:gatecheck_frontend/routes.dart';
import 'package:gatecheck_frontend/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GateCheck',
      routes: routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/login",
    );
  }
}
