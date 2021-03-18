import 'dart:convert';

import 'package:flutter/services.dart';
// import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/data/model/detail_places.dart';
import 'package:workout_flutter/data/model/nearby_search.dart';
// import 'package:http/http.dart' as http;

class ApiService {
  Future<NearbySearch> getNearbyHospitalList(
      double lat, double lng, int radius) async {
    // final url = Uri.parse(baseUrl +
    //     'nearbysearch/json?location=$lat,$lng&radius=$radius&type=hospital&key=$apiKey');
    // final response = await http.get(url);
    // if (response.statusCode == 200) {
    //   return NearbySearch.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to load nearby places list');
    // }
    final String jsonString =
        await rootBundle.loadString('assets/dummy_nearby_places.json');
    return NearbySearch.fromJson(jsonDecode(jsonString));
  }

  Future<DetailPlaces> getHostpitalDetail(String placeId) async {
    // final url =
    //     Uri.parse(baseUrl + 'details/json?place_id=$placeId&key=$apiKey');
    // final response = await http.get(url);
    // if (response.statusCode == 200) {
    //   return DetailPlaces.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to load hospital\'s detail');
    // }
    final String jsonString =
        await rootBundle.loadString('assets/dummy_detail_places.json');
    return DetailPlaces.fromJson(jsonDecode(jsonString));
  }
}
