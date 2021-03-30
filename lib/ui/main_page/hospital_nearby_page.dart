import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/model/nearby_search.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/provider/hospital_data_provider.dart';
import 'package:workout_flutter/ui/authentication/login_page.dart';
import 'package:workout_flutter/util/result_state.dart';
import 'package:workout_flutter/widget/build_hospital_item.dart';

class HospitalNearbyPage extends StatefulWidget {
  static const routeName = '/hospital_nearby_page';

  @override
  _HospitalNearbyPageState createState() => _HospitalNearbyPageState();
}

class _HospitalNearbyPageState extends State<HospitalNearbyPage> {
  Position? _position;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Can\'t Perform This Feature'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        "Please turn on location services to use this feature"),
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
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: Text('Cannot access location'),
                children: [
                  Text(
                      'Can\'t perform this feature without location service enabled')
                ],
              );
            });
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: Text('Cannot access location'),
                children: [
                  Text(
                      'Can\'t perform this feature without location service enabled')
                ],
              );
            });
        return Future.error('Location permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      if (auth.currentUser?.emailVerified != true) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Verify Email'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Please verify your email to continue'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Re-Send'),
                  onPressed: () async {
                    auth.currentUser?.sendEmailVerification();
                    await auth.signOut();
                    Navigation.intentReplace(LoginPage.routeName);
                  },
                ),
                TextButton(
                  child: Text('OK'),
                  onPressed: () async {
                    await auth.signOut();
                    Navigation.intentReplace(LoginPage.routeName);
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                          "AeraCall",
                          style: textStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Find or call nearest hospital",
                          style: textStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<NearbyHostpitalProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.state == ResultState.HasData) {
                    return AnimationLimiter(
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8.0),
                          itemCount: state.result?.results?.length as int,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: buildHospitalList(
                                    context,
                                    state.result?.results?[index]
                                        as NearbyResult,
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  } else if (state.state == ResultState.NoData) {
                    return Center(
                      child: Text('Data not displayed successfully-no data'),
                    );
                  } else if (state.state == ResultState.Error) {
                    return Center(
                      child: Text(
                          'Data not displayed successfully-eror ${state.message}'),
                    );
                  } else {
                    return Center(child: Text(''));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Find Hospital',
        backgroundColor: Colors.white,
        splashColor: Colors.blue,
        child: Icon(
          Icons.my_location,
          color: Colors.blueAccent,
        ),
        onPressed: () async {
          _position = await _determinePosition();
          Provider.of<NearbyHostpitalProvider>(context, listen: false)
              .fetchHostpitalList(
            _position?.latitude as double,
            _position?.longitude as double,
          );
        },
      ),
    );
  }
}
