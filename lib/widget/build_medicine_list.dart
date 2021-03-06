import 'package:flutter/material.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/common/navigation.dart';
import 'package:workout_flutter/data/model/medical.dart';
import 'package:workout_flutter/ui/medicine_detail.dart';

Widget buildMedicine(BuildContext context, Medical medical) {
  return Center(
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
      height: 75,
      width: MediaQuery.of(context).size.width * 0.95,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ListTile(
          leading: Icon(Icons.medical_services),
          title: Text(
            medical.name as String,
            style: textStyle,
          ),
          subtitle: Text(
            medical.rules as String,
            style: textStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigation.intentWithData(MedicineDetail.routeName, medical);
          },
        ),
      ),
    ),
  );
}
