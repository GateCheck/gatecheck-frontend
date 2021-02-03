import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatecheck_frontend/bloc/auth/auth_bloc.dart';
import 'package:gatecheck_frontend/routes.dart';
import 'package:gatecheck_frontend/screens/loading_screen.dart';
import 'package:gatecheck_frontend/screens/login.dart';
import 'package:gatecheck_frontend/theme/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (ctx) => AuthBloc(LoginPage))],
      child: MaterialApp(
        title: 'GateCheck',
        routes: routes,
        theme: theme,
        home: LoadingScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
