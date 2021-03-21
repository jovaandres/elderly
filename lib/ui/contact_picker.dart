import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/provider/contact_provider.dart';
import 'package:workout_flutter/util/result_state.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workout_flutter/widget/contact_picker_list.dart';

class ContactPicker extends StatefulWidget {
  static const routeName = '/contact_picker';

  @override
  _ContactPickerState createState() => _ContactPickerState();
}

class _ContactPickerState extends State<ContactPicker> {
  Iterable<Contact> contacts = [];

  @override
  void initState() {
    _askPermissions();
    super.initState();
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
      _handleInvalidPermissions(permissionStatus);
    } else {
      Provider.of<ContactProvider>(context, listen: false).getContactList();
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted ||
        permission != PermissionStatus.denied) {
      Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.denied;
    } else {
      Provider.of<ContactProvider>(context, listen: false).getContactList();
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
        code: "PERMISSION_DENIED",
        message: "Access to contact data denied",
        details: null,
      );
    } else if (permissionStatus == PermissionStatus.restricted) {
      throw PlatformException(
        code: "PERMISSION_RESTRICTED",
        message: "Contact data restricted",
        details: null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Contacts"),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(4),
          child: Text(
            'Press and hold to add contact',
            style: textStyle,
          ),
        ),
        Expanded(
          flex: 1,
          child: Consumer<ContactProvider>(
            builder: (context, provider, _) {
              if (provider.state == ResultState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (provider.state == ResultState.HasData) {
                final contacts = provider.contacts;
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    return contactPickerList(
                        context, contacts.elementAt(index));
                  },
                );
              } else if (provider.state == ResultState.NoData) {
                return Center(
                  child: Text('No Contacts Data'),
                );
              } else {
                return Center(
                  child: Text('Error showing data, ${provider.message}'),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
