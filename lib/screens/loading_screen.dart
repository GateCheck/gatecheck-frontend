import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatecheck_frontend/api/auth_api.dart';
import 'package:gatecheck_frontend/bloc/auth/auth_bloc.dart';
import 'package:gatecheck_frontend/screens/home.dart';
import 'package:gatecheck_frontend/screens/login.dart';

class LoadingScreen extends StatelessWidget {
  final Future<String> tokenFuture = getTokenFromSharedPreferences();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: null,
      future: isValidToken(tokenFuture),
      builder: (context, snap) {
        if (snap.data == null) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snap.data) {
          BlocProvider.of<AuthBloc>(context).add(AuthTokenUpdateEvent(tokenFuture));
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
