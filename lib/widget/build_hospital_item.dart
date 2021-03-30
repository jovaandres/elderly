import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/model/detail_places.dart';
import 'package:workout_flutter/data/model/nearby_search.dart';
import 'package:workout_flutter/provider/detail_hospital_provider.dart';
import 'package:workout_flutter/util/phone_call.dart';
import 'package:workout_flutter/util/result_state.dart';

Widget buildHospitalList(BuildContext context, NearbyResult result) {
  return Center(
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
      height: 80,
      width: MediaQuery.of(context).size.width * 0.95,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ListTile(
          leading: (result.photos != null)
              ? Image.network(
                  baseUrl +
                      'photo?maxwidth=400&photoreference=' +
                      ((result.photos as List<Photo>)..shuffle())
                          .first
                          .photoReference
                          .toString() +
                      '&key=$apiKey',
                  width: 80,
                  height: 70,
                )
              : Image.network(
                  result.icon as String,
                  width: 75,
                  height: 75,
                ),
          title: Text(
            result.name as String,
            style: textStyle.copyWith(fontSize: 14),
          ),
          subtitle: Text(
            result.vicinity as String,
            style: textStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Provider.of<DetailHospitalProvider>(context, listen: false)
                .fetchHospitalDetail(result.placeId as String);
            showModalBottomSheet(
              context: context,
              builder: (context) => Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Consumer<DetailHospitalProvider>(
                        builder: (context, state, _) {
                          final DetailResult _hospital =
                              state.result?.result as DetailResult;
                          if (state.state == ResultState.Loading) {
                            print('Loading');
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state.state == ResultState.HasData) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Text(
                                      _hospital.name as String,
                                      style: textStyle.copyWith(
                                        fontSize: 24,
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    (_hospital.photos?.isNotEmpty == true)
                                        ? Image.network(baseUrl +
                                            'photo?maxwidth=400&photoreference=' +
                                            ((_hospital.photos
                                                    as List<PhotoDetail>)
                                                  ..shuffle())
                                                .first
                                                .photoReference
                                                .toString() +
                                            '&key=$apiKey')
                                        : Image.network(
                                            _hospital.icon as String),
                                    TextButton(
                                      child: Text(
                                        _hospital.internationalPhoneNumber ??
                                            '-',
                                        style: textStyle.copyWith(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      onPressed: () {
                                        makingPhoneCall(
                                            _hospital.internationalPhoneNumber
                                                as String);
                                      },
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      _hospital.formattedAddress as String,
                                      textAlign: TextAlign.center,
                                      style: textStyle.copyWith(fontSize: 18),
                                    ),
                                    SizedBox(height: 32),
                                    Container(
                                      height: 40,
                                      width: 270,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          if (_hospital
                                                  .internationalPhoneNumber !=
                                              null) {
                                            makingPhoneCall(_hospital
                                                    .internationalPhoneNumber
                                                as String);
                                          }
                                        },
                                        child: Text(
                                          'CALL',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else if (state.state == ResultState.NoData) {
                            return Center(
                              child: Text(
                                  'Data not displayed successfully ${state.message}'),
                            );
                          } else if (state.state == ResultState.Error) {
                            return Center(
                              child: Text(
                                  'Data not displayed successfully ${state.message}'),
                            );
                          } else {
                            return Center(child: Text(''));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
            // Navigation.intentWithData(
            //   DetailHospital.routeName,
            //   result.placeId as String,
            // );
          },
        ),
      ),
    ),
  );
}
