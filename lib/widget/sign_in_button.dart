import 'package:flutter/material.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/ui/login_page.dart';

Widget signInButton() {
  return OutlineButton(
    splashColor: Colors.grey,
    onPressed: () {
      auth.signOut();
      Navigation.intentReplace(LoginPage.routeName);
    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40),
    ),
    highlightElevation: 0,
    borderSide: BorderSide(color: Colors.grey),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 10,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage("assets/google.png"),
            height: 35.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              (auth.currentUser != null) ? 'Sign out' : 'Sign in',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
