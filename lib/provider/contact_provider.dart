import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workout_flutter/util/result_state.dart';

class ContactProvider extends ChangeNotifier {
  ContactProvider() {
    getContactList();
  }

  Iterable<Contact> _contacts = [];
  String? _message;
  ResultState? _state;

  Iterable<Contact> get contacts => _contacts;

  String? get message => _message;

  ResultState? get state => _state;

  Future<void> getContactList() async {
    try {
      _state = ResultState.Loading;
      if (await Permission.contacts.status == PermissionStatus.granted) {
        _contacts = await ContactsService.getContacts();
        if (_contacts.isNotEmpty) {
          _state = ResultState.HasData;
        } else {
          _state = ResultState.NoData;
        }
        notifyListeners();
      } else {
        _contacts = [];
      }
    } catch (e) {
      _contacts = [];
      _state = ResultState.Error;
      notifyListeners();
      _message = e.toString();
    }
  }
}
