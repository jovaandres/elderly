import 'package:flutter/material.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/ui/authentication/registration_page.dart';

class RolePage extends StatefulWidget {
  static const routeName = '/role_page';

  @override
  _RolePageState createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Role"),
      ),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 90,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 22,
                    color: Colors.grey,
                  )
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      "Elderly",
                      style: textStyle.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'SELECT',
                        style: textStyle.copyWith(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        Navigation.intentReplaceWithData(
                            RegistrationPage.routeName, 'elderly');
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 90,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 22,
                    color: Colors.grey,
                  )
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      "Family",
                      style: textStyle.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'SELECT',
                        style: textStyle.copyWith(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        Navigation.intentReplaceWithData(
                            RegistrationPage.routeName, 'family');
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
