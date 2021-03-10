import 'package:flutter/material.dart';
import 'package:workout_flutter/common/constant.dart';

class ThirdPage extends StatefulWidget {
  static const routeName = '/third_page';

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Third"),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
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
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        "Hello User!",
                        style: textStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Let\'s excercise by doing Yoga or Taichi',
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                child: Container(
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
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(
                          "YOGA",
                          style: textStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        Image(
                          height: 180,
                          image: AssetImage('assets/yoga.jpg'),
                        ),
                        FlatButton(
                          child: Text(
                            'EXERCISE',
                            style: textStyle.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                child: Container(
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
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(
                          "TAICHI",
                          style: textStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        Image(
                          height: 180,
                          image: AssetImage('assets/taichi.jpg'),
                        ),
                        FlatButton(
                          child: Text(
                            'EXERCISE',
                            style: textStyle.copyWith(color: Colors.blue),
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
