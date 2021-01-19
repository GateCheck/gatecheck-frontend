import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gatecheck_frontend/components/featured_text_form_field.dart';
import '../utils/screen_manipulation.dart';

class LoginPage extends StatelessWidget {
  final double _textFieldPercentFromSides = 15;
  final double logoCircleRadiusAsScreenPercentage = 6;

  Widget getFormTextField(BuildContext ctx, String hint) {
    return Padding(
      padding: ctx.getProportionalInsets(left: _textFieldPercentFromSides, right: _textFieldPercentFromSides),
      child: FeaturedTextFormField(
        unselectedColor: Colors.blue[900],
        decoration: InputDecoration(
          labelText: hint,
        ),
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.public,
          color: Theme.of(context).accentColor,
          size: 50,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Center(
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
            getFormTextField(context, "Email"),
            SizedBox(
              height: context.heightOf(percentLeft / 100 * 5),
            ),
            getFormTextField(context, "Password"),
            SizedBox(
              height: context.heightOf(percentLeft / 100 * 5),
            ),
            Container(
              width: loginWidth,
              child: ButtonTheme(
                buttonColor: Theme.of(context).primaryColor,
                child: RaisedButton(
                  child: Text("LOGIN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                  onPressed: () {},
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: loginWidth / 2.05,
                  child: ButtonTheme(
                    buttonColor: Theme.of(context).primaryColor,
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
                    buttonColor: Theme.of(context).primaryColor,
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
    );
  }
}
