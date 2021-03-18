import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/data/model/detail_places.dart';
import 'package:workout_flutter/provider/detail_hospital_provider.dart';
import 'package:workout_flutter/util/phone_call.dart';
import 'package:workout_flutter/util/result_state.dart';

class DetailHospital extends StatefulWidget {
  static const routeName = '/detail_hospital_page';
  final String hospitalId;

  DetailHospital({@required this.hospitalId});

  @override
  _DetailHospitalState createState() => _DetailHospitalState();
}

class _DetailHospitalState extends State<DetailHospital> {
  @override
  void initState() {
    Provider.of<DetailHospitalProvider>(context, listen: false)
        .fetchHospitalDetail(widget.hospitalId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Hospital"),
      ),
      body: Consumer<DetailHospitalProvider>(
        builder: (context, state, _) {
          final DetailResult _hospital = state.result.result;
          if (state.state == ResultState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == ResultState.HasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 22,
                        color: Colors.grey,
                      )
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(
                          _hospital.name,
                          style: textStyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        Image.network('adawda'
                            // _hospital.icon
                            ),
                        TextButton(
                          child: Text(
                            _hospital.internationalPhoneNumber,
                            style: textStyle.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                          onPressed: () {
                            makingPhoneCall(_hospital.internationalPhoneNumber);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (state.state == ResultState.NoData) {
            return Center(
              child: Text('Data not displayed successfully ${state.message}'),
            );
          } else if (state.state == ResultState.Error) {
            return Center(
              child: Text('Data not displayed successfully ${state.message}'),
            );
          } else {
            return Center(child: Text(''));
          }
        },
      ),
    );
  }
}
