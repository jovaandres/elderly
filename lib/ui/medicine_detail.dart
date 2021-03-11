import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/data/model/medical.dart';
import 'package:workout_flutter/main.dart';

class MedicineDetail extends StatefulWidget {
  static const routeName = '/medicine_detail_page';
  final Medical medicine;

  MedicineDetail({@required this.medicine});

  @override
  _MedicineDetailState createState() => _MedicineDetailState();
}

class _MedicineDetailState extends State<MedicineDetail> {
  Medical medical;
  File _image;
  File medicalImage;
  final picker = ImagePicker();

  void initState() {
    medical = widget.medicine;
    medicalImage = File('$path/${medical.name}.png');
    super.initState();
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
                  !(medicalImage.existsSync())
                      ? (_image == null)
                          ? Text('No image selected')
                          : Image.file(_image)
                      : Image.file(medicalImage),
                  SizedBox(height: 16),
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
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      await File(pickedFile.path).copy('$path/${medical.name}.png');
    }

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
