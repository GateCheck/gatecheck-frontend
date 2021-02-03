import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:gatecheck_frontend/api/api_base.dart';
import 'package:gatecheck_frontend/api/auth_api.dart';
import 'package:gatecheck_frontend/model/auth_response_model.dart';
import 'package:gatecheck_frontend/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  void Function(Change<AuthState>) onChangeState;
  final dynamic loginPageClass;

  AuthBloc(this.loginPageClass) : super(AuthInitial());

  void setOnStateChange(BuildContext context) {
    onChangeState = (Change<AuthState> auth) {
      print(auth);
      if (auth.nextState.loggedIn) {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString("token", auth.nextState.token);
          if (context.widget is LoginPage) {
            Navigator.pushReplacementNamed(context, "/home");
          }
        });
      } else if (auth.currentState.loggedIn && !auth.nextState.loggedIn) Navigator.pushReplacementNamed(context, "/login");
    };
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    if (onChangeState != null) onChangeState(change);
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthLoginEvent) {
      ApiData<AuthResponseModel> res = await login(event.username, event.password);

      if (res.status != DataStatus.Success) {
        yield AuthState(token: null, loggedIn: false, status: res.status);
        return;
      }

      yield AuthState(token: res.data.token, loggedIn: res.status == DataStatus.Success, status: res.status);
    } else if (event is AuthTokenUpdateEvent) {
      yield AuthState(token: await event.token, loggedIn: true, status: DataStatus.Success);
    }
  }
}
