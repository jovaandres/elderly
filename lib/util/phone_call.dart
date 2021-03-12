import 'package:url_launcher/url_launcher.dart';

Future<dynamic> makingPhoneCall(String number) async {
  String url = 'tel:$number';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $number';
  }
}
