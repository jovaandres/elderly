import 'package:flutter/material.dart';
import 'package:workout_flutter/data/api/api_service.dart';
import 'package:workout_flutter/data/model/detail_places.dart';
import 'package:workout_flutter/util/result_state.dart';

class DetailHospitalProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailHospitalProvider({@required this.apiService});

  DetailPlaces _hospitalDetails;
  String _message;
  ResultState _state;

  DetailPlaces get result => _hospitalDetails;

  String get message => _message;

  ResultState get state => _state;

  Future<dynamic> fetchHospitalDetail(String placeId) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final hospital = await apiService.getHostpitalDetail(placeId);
      if (hospital.result.placeId == null) {
        _state = ResultState.NoData;
        notifyListeners();
        _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _hospitalDetails = hospital;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error->>$e';
    }
  }
}
