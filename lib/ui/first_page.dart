import 'package:flutter/material.dart';
import 'package:workout_flutter/widget/menu_tile.dart';
import 'package:workout_flutter/widget/sign_in_button.dart';

class FirstPage extends StatefulWidget {
  static const routeName = '/first_page';

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Hello',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'User!',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hello User!",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: 120,
                      height: 38,
                      child: signInButton(),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              MenuTile(title: 'Item 1'),
              MenuTile(title: 'Item 2'),
              MenuTile(title: 'Item 3'),
              MenuTile(title: 'Item 4'),
              MenuTile(title: 'Item 5'),
            ],
          ),
        ),
      ),
    );
  }
}
