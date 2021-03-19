import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/provider/search_user_provider.dart';
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
