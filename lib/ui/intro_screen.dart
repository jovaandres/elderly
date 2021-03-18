import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/ui/login_page.dart';

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
        title: "Lorem Ipsum",
        description:
            "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        pathImage: "assets/slide_1.jpg",
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      Slide(
        title: "Lorem Ipsum",
        description:
            "Ye indulgence unreserved connection alteration appearance",
        pathImage: "assets/slide_2.jpg",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      Slide(
        title: "Lorem Ipsum",
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        pathImage: "assets/slide_3.jpg",
        backgroundColor: Color(0xff9932CC),
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
