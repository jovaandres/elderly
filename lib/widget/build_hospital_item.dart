import 'package:flutter/material.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/model/nearby_search.dart';
import 'package:workout_flutter/ui/hospital_detail.dart';

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
      width: MediaQuery.of(context).size.width * 0.9,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ListTile(
          leading: (result.photos != null)
              ? Image.network(baseUrl +
                  'photo?maxwidth=400&photoreference=' +
                  ((result.photos as List<Photo>)..shuffle())
                      .first
                      .photoReference
                      .toString() +
                  '&key=$apiKey')
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
            Navigation.intentWithData(
              DetailHospital.routeName,
              result.placeId as String,
            );
          },
        ),
      ),
    ),
  );
}
