import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/data/model/alarm.dart';
import 'package:workout_flutter/data/model/medical.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/provider/alarm_data_provider.dart';
import 'package:workout_flutter/provider/scheduling_provider.dart';
import 'package:workout_flutter/util/encrypt_decrypt_file.dart';

class MedicineDetail extends StatefulWidget {
  static const routeName = '/medicine_detail_page';
  final Medical medicine;

  MedicineDetail({@required this.medicine});

  @override
  _MedicineDetailState createState() => _MedicineDetailState();
}

class _MedicineDetailState extends State<MedicineDetail> {
  Medical medical;
  File medicalImage;
  final picker = ImagePicker();

  void initState() {
    medical = widget.medicine;
    medicalImage = File('$path/${medical.name}.jpg');
    if (!medicalImage.existsSync()) {
      downloadImageFromFirebase();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medicine Detail"),
      ),
      body: Consumer<AlarmDataProvider>(
        builder: (context, alarm, _) {
          return Center(
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
                          ? Text('No image selected')
                          : FullScreenWidget(
                              child: Hero(
                                tag: medical.name,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.file(
                                    medicalImage,
                                    width: 300,
                                    height: 300,
                                    // fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
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
                      ListTile(
                        title: Text(
                          'Time 1',
                          style: textStyle,
                        ),
                        trailing: Consumer<SchedulingProvider>(
                          builder: (context, provider, _) {
                            alarm.isAlarmScheduled("Time 1");
                            return Switch.adaptive(
                              value: alarm.isReminderActive,
                              onChanged: (value) async {
                                alarm.isAlarmScheduled("Time 1");
                                if (value) {
                                  alarm.updateAlarm(1, 1);
                                  await alarm.getAlarmByName('Time 1');
                                  setState(() {
                                    provider.scheduleNotification(
                                        1, alarm.getAlrm.time, medical);
                                  });
                                } else {
                                  alarm.updateAlarm(0, 1);
                                  await alarm.getAlarmByName('Time 1');
                                  setState(() {
                                    provider.cancelNotification(1);
                                  });
                                }
                              },
                            );
                          },
                        ),
                        onTap: () {
                          DatePicker.showTimePicker(
                            context,
                            showTitleActions: true,
                            currentTime: DateTime.now(),
                            locale: LocaleType.id,
                            onConfirm: (date) {
                              setState(() {
                                alarm.addAlarm(
                                  AlarmData(
                                    id: 1,
                                    name: 'Time 1',
                                    isScheduled: 1,
                                    time:
                                        "${date.hour}:${date.minute}:${date.second}",
                                  ),
                                );
                              });
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(
          Icons.add_a_photo,
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      await File(pickedFile.path).copy('$path/${medical.name}.jpg');
    }

    setState(() {
      if (pickedFile != null) {
        medicalImage = File(pickedFile.path);
        uploadImageToFirebase();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImageToFirebase() async {
    final encryptedImage = EncryptData.encryptFile(medicalImage.path);
    Reference firebaseStorageRef =
        storage.ref().child('${auth.currentUser.email}/${medical.name}.jpg');
    await firebaseStorageRef.putFile(File(encryptedImage));
  }

  Future downloadImageFromFirebase() async {
    Reference firebaseStorageRef =
        storage.ref().child('${auth.currentUser.email}/${medical.name}.jpg');
    DownloadTask downloadTask =
        firebaseStorageRef.writeToFile(File('$path/${medical.name}.jpg.aes'));
    await downloadTask.whenComplete(() {
      medicalImage =
          File(EncryptData.decryptFile('$path/${medical.name}.jpg.aes'));
      setState(() {});
    });
  }
}
