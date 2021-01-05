import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gatecheck_frontend/components/featured_text_form_field.dart';
import '../utils/screen_manipulation.dart';

class LoginPage extends StatelessWidget {
  Widget getFormTextField(BuildContext ctx, String hint) {
    return Padding(
      padding: ctx.getProportionalInsets(left: 30, right: 30),
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
    double avatarCircleRadiusAsScreenPercentage = 6;
    double avatarCircleRadius =
        context.getPixelCountFromScreenPercentage(height: avatarCircleRadiusAsScreenPercentage).height * 1 +
            context.getPixelCountFromScreenPercentage(width: avatarCircleRadiusAsScreenPercentage).width * 0.6;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: context.getPixelCountFromScreenPercentage(height: 15).height,
            ),
            Material(
              child: CircleAvatar(
                child: Image.asset(
                  "assets/logo_large.png",
                  width: context
                              .getPixelCountFromScreenPercentage(height: avatarCircleRadiusAsScreenPercentage * 1.5)
                              .height *
                          1 +
                      context.getPixelCountFromScreenPercentage(width: avatarCircleRadiusAsScreenPercentage * 1.5).width *
                          0.6,
                ),
                radius: avatarCircleRadius,
                backgroundColor: Colors.white,
              ),
              borderRadius: BorderRadius.circular(avatarCircleRadius),
              elevation: 18,
            ),
            SizedBox(
              height: context.getPixelCountFromScreenPercentage(height: 10).height,
            ),
            getFormTextField(context, "Email"),
            SizedBox(
              height: context.getPixelCountFromScreenPercentage(height: 5).height,
            ),
            getFormTextField(context, "Password"),
            SizedBox(
              height: context.getPixelCountFromScreenPercentage(height: 5).height,
            ),
            ButtonTheme(
              minWidth: context
                  .getPixelCountFromScreenPercentage(
                      width: 25.0 / (100.0 / 75.0 /* 75% of the 75% of the screen the text field takes */))
                  .width,
              buttonColor: Theme.of(context).primaryColor,
              child: RaisedButton(
                child: Text("LOGIN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
