import 'package:flutter/material.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/model/user_data.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/ui/main_page/home_page.dart';
import 'package:workout_flutter/ui/authentication/login_page.dart';
import 'package:workout_flutter/ui/family_role/user_activity.dart';

class RegistrationPage extends StatefulWidget {
  static const routeName = '/registration_page';
  final String role;

  RegistrationPage({required this.role});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _nameFieldController = TextEditingController();
  final _ageFieldController = TextEditingController();
  final _weightFieldController = TextEditingController();
  final _heightFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;
  late String _role;

  @override
  void initState() {
    _role = widget.role;
    super.initState();
  }

  @override
  void dispose() {
    _nameFieldController.dispose();
    _ageFieldController.dispose();
    _weightFieldController.dispose();
    _heightFieldController.dispose();
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Registration Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 24),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 150,
                  child: Image.asset('assets/logo.png'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _nameFieldController,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: 'Name',
                  hintText: 'Your Name',
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
                keyboardType: TextInputType.number,
                controller: _ageFieldController,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: 'Age',
                  hintText: 'Your Age',
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
                keyboardType: TextInputType.number,
                controller: _weightFieldController,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: 'Weight',
                  hintText: 'Your Weight (kg)',
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
                keyboardType: TextInputType.number,
                controller: _heightFieldController,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: 'Height',
                  hintText: 'Your Height (cm)',
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
                  hintText: 'Enter secure password',
                ),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              margin: EdgeInsets.all(16.0),
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
                    final email = _emailFieldController.text;
                    final password = _passwordFieldController.text;

                    await auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    await auth.currentUser?.sendEmailVerification();

                    firestore.collection('user_account_bi13rb8').add({
                      "name": _nameFieldController.text,
                      "age": _ageFieldController.text,
                      "weight": _weightFieldController.text,
                      "height": _heightFieldController.text,
                      "email": _emailFieldController.text,
                      "role": _role,
                      "point": 0,
                    });
                    final userDatas = UserData(
                      age: _ageFieldController.text,
                      email: _emailFieldController.text,
                      weight: _weightFieldController.text,
                      height: _heightFieldController.text,
                      name: _nameFieldController.text,
                      role: _role,
                    );
                    databaseHelper.insertUserData(userDatas);
                    userData = await databaseHelper
                        .getUserData(auth.currentUser?.email as String);
                    if (_role == 'elderly') {
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
                            title: Text('AlertDialog Title'),
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
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              child: RichText(
                text: TextSpan(
                  text: 'Already have account? ',
                  style: Theme.of(context).textTheme.bodyText1,
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigation.intentReplace(LoginPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
