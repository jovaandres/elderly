import 'package:flutter/material.dart';
import 'package:workout_flutter/data/model/user_data.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/util/result_state.dart';

class SearchUserProvider extends ChangeNotifier {
  SearchUserProvider() {
    fetchUser('');
  }

  List<UserData>? _userData;
  String? _message;
  ResultState? _state;

  List<UserData>? get result => _userData;

  String? get message => _message;

  ResultState? get state => _state;

  Future<dynamic> fetchUser(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final users = await firestore
          .collection('user_account_bi13rb8')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('role', isEqualTo: 'elderly')
          .get()
          .then((value) => value.docs);
      if (users.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        List<UserData> data = [];
        for (var user in users) {
          final name = user.data()?['name'];
          final age = user.data()?['age'];
          data.add(UserData(
            name: name,
            age: age,
          ));
        }
        notifyListeners();
        return _userData = data;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error->>$e';
    }
  }
}
