import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gatecheck_frontend/api/api_base.dart';
import 'package:gatecheck_frontend/bloc/auth/auth_bloc.dart';
import 'package:gatecheck_frontend/components/featured_text_form_field.dart';
import '../utils/screen_manipulation.dart';

class LoginPage extends StatelessWidget {
  final double _textFieldPercentFromSides = 15;
  final double logoCircleRadiusAsScreenPercentage = 6;

  final GlobalKey<FeaturedTextFormFieldState> usernameGlobalKey = GlobalKey();
  final GlobalKey<FeaturedTextFormFieldState> passwordGlobalKey = GlobalKey();

  Widget getFormTextField(BuildContext ctx, String hint, GlobalKey key, {String Function(String) validator}) {
    return Padding(
      padding: ctx.getProportionalInsets(left: _textFieldPercentFromSides, right: _textFieldPercentFromSides),
      child: FeaturedTextFormField(
        key: key,
        unselectedColor: Colors.blue[900],
        decoration: InputDecoration(
          labelText: hint,
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double avatarCircleRadius = context.widthOf(logoCircleRadiusAsScreenPercentage) + context.heightOf(logoCircleRadiusAsScreenPercentage * 0.6);
    double loginWidth = context.widthOf(100 - _textFieldPercentFromSides * 2);

    double avatarPercentOfHeight = context.getPercentageFromHeight(avatarCircleRadius * 2);
    double percentLeft = (100 - 10 - avatarPercentOfHeight);
    double radius = context.widthOf(15);

    if (BlocProvider
        .of<AuthBloc>(context)
        .onChangeState == null) BlocProvider.of<AuthBloc>(context).setOnStateChange(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.public,
          color: Theme
              .of(context)
              .accentColor,
          size: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Form(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: context.heightOf(10),
              ),
              Material(
                child: CircleAvatar(
                  child: Image.asset("assets/logo_large.png", width: radius * 0.85),
                  radius: avatarCircleRadius,
                  backgroundColor: Colors.white,
                ),
                borderRadius: BorderRadius.circular(radius),
                elevation: 18,
              ),
              SizedBox(
                height: context.heightOf(percentLeft / 100 * 15),
              ),
              getFormTextField(context, "Username", usernameGlobalKey),
              SizedBox(
                height: context.heightOf(percentLeft / 100 * 5),
              ),
              getFormTextField(context, "Password", passwordGlobalKey, validator: ValidationBuilder()
                  .minLength(8, "Password must be at least 8 characters!")
                  .maxLength(30, "Password must not exceed 30 characters!")
                  .required("This field is required!")
                  .build()),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  String text = state.status == DataStatus.Unauthorized ? "Invalid username/password" : "Error!";
                  return state.status == DataStatus.Unauthorized
                      ? Text(
                    text,
                    style: TextStyle(color: Theme
                        .of(context)
                        .errorColor),
                  )
                      : Container();
                },
                buildWhen: (prev, curr) => curr.status != DataStatus.Success && curr.status != DataStatus.ParsingException,
                cubit: BlocProvider.of<AuthBloc>(context),
              ),
              SizedBox(
                height: context.heightOf(percentLeft / 100 * 5),
              ),
              Container(
                width: loginWidth,
                child: ButtonTheme(
                  buttonColor: Theme
                      .of(context)
                      .primaryColor,
                  child: RaisedButton(
                    child: Text("LOGIN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                    onPressed: () {
                      FormState state = Form.of(usernameGlobalKey.currentContext);

                      state.save();
                      String username = usernameGlobalKey.currentState.textEditingController.value.text;
                      String password = passwordGlobalKey.currentState.textEditingController.value.text;

                      if (state.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(AuthLoginEvent(username, password, true));
                      }
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: loginWidth / 2.05,
                    child: ButtonTheme(
                      buttonColor: Theme
                          .of(context)
                          .primaryColor,
                      child: RaisedButton(
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                          overflow: TextOverflow.ellipsis,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  SizedBox(width: loginWidth - ((loginWidth / 2.05) * 2)),
                  Container(
                    width: loginWidth / 2.05,
                    child: ButtonTheme(
                      buttonColor: Theme
                          .of(context)
                          .primaryColor,
                      child: RaisedButton(
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                          overflow: TextOverflow.ellipsis,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
