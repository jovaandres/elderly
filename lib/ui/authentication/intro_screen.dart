import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/ui/authentication/login_page.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = '/intro_screen';

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: "Are You Healthy?",
        centerWidget: Image.asset('assets/slide_1.jpg'),
        backgroundColor: Color(0xfff5a623),
        styleTitle: textStyle.copyWith(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        styleDescription: textStyle.copyWith(
          fontSize: 20,
          color: Colors.white,
        ),
        widgetDescription: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text(
                "Icons vector created by rawpixel.com - www.freepik.com",
                style: TextStyle(color: Colors.grey.shade100),
                textAlign: TextAlign.center,
              ),
              onPressed: () async {
                if (await canLaunch("https://www.freepik.com/vectors/icons")) {
                  await launch("https://www.freepik.com/vectors/icons");
                } else {
                  throw 'Could not launch';
                }
              },
            ),
            SizedBox(height: 32),
            Text(
              "One Exercise A Day Keeps The Whole Worries Away!",
              textAlign: TextAlign.center,
              style: textStyle.copyWith(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
    slides.add(
      Slide(
        title: "Are Your Happy?",
        centerWidget: Image.asset("assets/slide_3.jpg"),
        backgroundColor: Color(0xff9932CC),
        styleTitle: textStyle.copyWith(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        styleDescription: textStyle.copyWith(
          fontSize: 20,
          color: Colors.white,
        ),
        widgetDescription: Column(
          children: [
            TextButton(
              child: Text(
                "Background vector created by rawpixel.com - www.freepik.com",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade100),
              ),
              onPressed: () async {
                if (await canLaunch(
                    "https://www.freepik.com/vectors/background")) {
                  await launch("https://www.freepik.com/vectors/background");
                } else {
                  throw 'Could not launch';
                }
              },
            ),
            SizedBox(height: 32),
            Text(
              "Be Happy And Enjoy Life",
              textAlign: TextAlign.center,
              style: textStyle.copyWith(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDonePress() {
    Navigation.intentReplace(LoginPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}
