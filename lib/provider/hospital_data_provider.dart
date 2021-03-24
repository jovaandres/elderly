import 'package:flutter/material.dart';
import 'package:workout_flutter/data/api/api_service.dart';
import 'package:workout_flutter/data/model/nearby_search.dart';
import 'package:workout_flutter/util/result_state.dart';

class NearbyHostpitalProvider extends ChangeNotifier {
  final ApiService apiService;

  NearbyHostpitalProvider({required this.apiService});

  NearbySearch? _nearbySearchResult;
  String? _message;
  ResultState? _state;

  NearbySearch? get result => _nearbySearchResult;

  String? get message => _message;

  ResultState? get state => _state;

  Future<dynamic> fetchHostpitalList(double lat, double long) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final hostpitalList =
          await apiService.getNearbyHospitalList(lat, long, 25000);
      if (hostpitalList.results?.isEmpty == true) {
        _state = ResultState.NoData;
        notifyListeners();
        _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _nearbySearchResult = hostpitalList;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error->>$e';
    }
  }
}
