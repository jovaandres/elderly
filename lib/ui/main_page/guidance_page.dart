import 'package:flutter/material.dart';
import 'package:workout_flutter/common/constant.dart';

class GuidancePage extends StatefulWidget {
  static const routeName = '/guidance_page';

  @override
  _GuidancePageState createState() => _GuidancePageState();
}

class _GuidancePageState extends State<GuidancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fourth"),
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
                        'Taking Care Guidance',
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 18),
          Column(
            children: [
              Container(
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
                        "Out Of Breath",
                        style: textStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                        child: Text(
                          'DETAIL',
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
              SizedBox(height: 16),
              Container(
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
                        "Headache",
                        style: textStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                        child: Text(
                          'DETAIL',
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
            ],
          )
        ],
      ),
    );
  }
}
