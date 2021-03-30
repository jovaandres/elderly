import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/provider/search_user_provider.dart';
import 'package:workout_flutter/ui/authentication/login_page.dart';
import 'package:workout_flutter/util/result_state.dart';

var _textQuery = BehaviorSubject<String>();

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchQueryController;
  static const title = 'Search Elderly';
  String _oldString = '';

  @override
  void initState() {
    _searchQueryController = TextEditingController();
    _searchQueryController.addListener(updateList);
    super.initState();
  }

  @override
  void dispose() {
    _searchQueryController.removeListener(updateList);
    _searchQueryController.dispose();
    super.dispose();
  }

  updateList() {
    _textQuery.add(_searchQueryController.text);
    _textQuery
        .where((value) => value.isNotEmpty && value != _oldString)
        .debounceTime(Duration(milliseconds: 500))
        .listen((query) {
      Provider.of<SearchUserProvider>(context, listen: false).fetchUser(query);
      _oldString = _searchQueryController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              key: Key('texy field'),
              style: textStyle,
              keyboardType: TextInputType.name,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Search Elderly',
                hintText: 'Search by name',
                isDense: true,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.lightBlueAccent,
                  size: 24,
                ),
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              controller: _searchQueryController,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Consumer<SearchUserProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.state == ResultState.HasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8.0),
                        itemCount: state.result?.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.result?[index].name as String),
                            subtitle: Text(state.result?[index].age as String),
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Add Family'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text(
                                                'Add ${state.result?[index].name} to family?'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () async {
                                            await firestore
                                                .collection(
                                                    'user_notification_bi13rb8')
                                                .add({
                                              "id": state.result?[index].email,
                                              "message":
                                                  "want to add you as family",
                                              "name": userData?.name,
                                              "sender": auth.currentUser?.email,
                                              "userDocId": userData?.docId,
                                            });
                                            Navigation.back();
                                            showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('Re-Login'),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ListBody(
                                                        children: <Widget>[
                                                          Text(
                                                              'Please re-login to load your new family activity'),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text('OK'),
                                                        onPressed: () {
                                                          auth.signOut();
                                                          Navigation
                                                              .intentReplace(
                                                                  LoginPage
                                                                      .routeName);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigation.back();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                          );
                        });
                  } else if (state.state == ResultState.NoData) {
                    return Center(child: Text(''));
                  } else if (state.state == ResultState.Error) {
                    return Center(child: Text(''));
                  } else {
                    return Center(child: Text(''));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
