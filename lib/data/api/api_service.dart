import 'dart:convert';

import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/data/model/detail_places.dart';
import 'package:workout_flutter/data/model/nearby_search.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<NearbySearch> getNearbyHospitalList(
      double lat, double lng, int radius) async {
    final response = await http.get(baseUrl +
        'nearbysearch/json?location=$lat,$lng&radius=$radius&type=hospital&key=$apiKey');
    if (response.statusCode == 200) {
      return NearbySearch.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load nearby places list');
    }
  }

  Future<DetailPlaces> getHostpitalDetail(String placeId) async {
    final response =
        await http.get(baseUrl + 'details/json?place_id=$placeId&key=$apiKey');
    if (response.statusCode == 200) {
      return DetailPlaces.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load hospital\'s detail');
    }
  }
}
