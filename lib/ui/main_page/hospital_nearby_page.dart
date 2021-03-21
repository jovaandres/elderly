import 'dart:io';

// import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/data/model/nearby_search.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/provider/hospital_data_provider.dart';
import 'package:workout_flutter/util/result_state.dart';
import 'package:workout_flutter/widget/build_hospital_item.dart';
import 'package:workout_flutter/widget/menu_tile.dart';
import 'package:workout_flutter/widget/sign_in_button.dart';

class HospitalNearbyPage extends StatefulWidget {
  static const routeName = '/hospital_nearby_page';

  @override
  _HospitalNearbyPageState createState() => _HospitalNearbyPageState();
}

class _HospitalNearbyPageState extends State<HospitalNearbyPage> {
  Position? _position;

  void openLocationSetting() async {
    if (Platform.isAndroid) {
      // final AndroidIntent intent = new AndroidIntent(
      //   action: 'android.settings.LOCATION_SOURCE_SETTINGS',
      // );
      // await intent.launch();
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      openLocationSetting();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First"),
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
                        (userData != null)
                            ? "Hello ${userData?.name}"
                            : "Hello User!",
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
                                  state.result?.results?[index] as NearbyResult,
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
      floatingActionButton: FloatingActionButton(
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
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (auth.currentUser != null)
                          ? "Hello ${userData?.name}"
                          : "Hello User!",
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
