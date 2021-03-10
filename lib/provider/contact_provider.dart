import 'package:flutter/material.dart';
import 'package:workout_flutter/data/db/database_helper.dart';
import 'package:workout_flutter/data/model/family_number.dart';
import 'package:workout_flutter/util/result_state.dart';

class ContactProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  ContactProvider({@required this.databaseHelper}) {
    _getContact();
  }

  ResultState _state;

  ResultState get state => _state;

  String _message;

  String get message => _message;

  List<FamilyNumber> _contact = [];

  List<FamilyNumber> get contact => _contact;

  void _getContact() async {
    _state = ResultState.Loading;
    _contact = await databaseHelper.getContact();
    if (_contact.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addContact(FamilyNumber familyNumber) async {
    try {
      await databaseHelper.insertContact(familyNumber);
      _getContact();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error $e';
      notifyListeners();
    }
  }

  Future<bool> isContact(String id) async {
    final contact = await databaseHelper.getContactByName(id);
    return contact.isNotEmpty;
  }

  void removeContact(int id) async {
    try {
      await databaseHelper.removeContact(id);
      _getContact();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error $e';
      notifyListeners();
    }
  }
}
