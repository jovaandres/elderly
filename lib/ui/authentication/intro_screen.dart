import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
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
        description: "One Exercise A Day Keeps The Whole Worries Away!",
        pathImage: "assets/slide_1.jpg",
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
      ),
    );
    slides.add(
      Slide(
        title: "Are Your Happy?",
        description: "Be Happy And Enjoy Life",
        pathImage: "assets/slide_3.jpg",
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
