import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/model/user_data.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/ui/main_page/home_page.dart';
import 'package:workout_flutter/ui/authentication/role_page.dart';
import 'package:workout_flutter/ui/family_role/user_activity.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;

  @override
  void dispose() {
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 24),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 150,
                  child: Image.asset('assets/flutter-logo.png'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _emailFieldController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: 'Email',
                  hintText: 'Enter valid email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 10,
                bottom: 0,
              ),
              child: TextField(
                controller: _passwordFieldController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  isDense: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (_emailFieldController.text.isNotEmpty) {
                  auth.sendPasswordResetEmail(
                      email: _emailFieldController.text);
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Reset Password'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('Reset Password Email Sent'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                } else {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Can\'t process'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('Fill the email field!'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                }
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    FocusScope.of(context).unfocus();
                    final inputEmail = _emailFieldController.text;
                    final inputPassword = _passwordFieldController.text;

                    await auth.signInWithEmailAndPassword(
                        email: inputEmail, password: inputPassword);

                    final data = await firestore
                        .collection('user_account_bi13rb8')
                        .where('email', isEqualTo: auth.currentUser?.email)
                        .limit(1)
                        .get();
                    final userDocs = data.docs.first;
                    final email = userDocs.data()?['email'];
                    final age = userDocs.data()?['age'];
                    final name = userDocs.data()?['name'];
                    final role = userDocs.data()?['role'];
                    final height = userDocs.data()?['height'];
                    final weight = userDocs.data()?['weight'];
                    final family = userDocs.data()?['family'];
                    final point = userDocs.data()?['point'];
                    final docId = userDocs.id;
                    final userDatas = UserData(
                      age: age,
                      email: email,
                      height: height,
                      name: name,
                      weight: weight,
                      role: role,
                      docId: docId,
                      family: family,
                      point: point,
                    );
                    await databaseHelper.insertUserData(userDatas);
                    userData = await databaseHelper
                        .getUserData(auth.currentUser?.email as String);
                    if (role == 'elderly') {
                      Navigation.intentReplace(MyHomePage.routeName);
                    } else {
                      Navigation.intentReplace(UserActivity.routeName);
                    }
                  } catch (e) {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Login Failed'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(e.toString()),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigation.back();
                                },
                              ),
                            ],
                          );
                        });
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 50),
            GestureDetector(
              child: RichText(
                text: TextSpan(
                  text: 'New User? ',
                  style: Theme.of(context).textTheme.bodyText1,
                  children: [
                    TextSpan(
                      text: 'Create Account',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigation.intentReplace(RolePage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
