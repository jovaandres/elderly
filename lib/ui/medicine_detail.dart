import 'package:flutter/material.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/data/model/medical.dart';

class MedicineDetail extends StatefulWidget {
  static const routeName = '/medicine_detail_page';
  final Medical medicine;

  MedicineDetail({@required this.medicine});

  @override
  _MedicineDetailState createState() => _MedicineDetailState();
}

class _MedicineDetailState extends State<MedicineDetail> {
  final _nameFieldController = TextEditingController();
  final _rulesFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Medical medical;

  void initState() {
    medical = widget.medicine;
    super.initState();
  }

  @override
  void dispose() {
    _nameFieldController.dispose();
    _rulesFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medicine Detail"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
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
            width: MediaQuery.of(context).size.width * 0.95,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    medical.name,
                    style: textStyle.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    medical.rules,
                    style: textStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
