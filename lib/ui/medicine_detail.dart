import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:workout_flutter/common/constant.dart';
import 'package:workout_flutter/data/model/medical.dart';
import 'package:workout_flutter/main.dart';
import 'package:workout_flutter/provider/alarm_data_provider.dart';
import 'package:workout_flutter/provider/scheduling_provider.dart';
import 'package:workout_flutter/util/cryptojs_aes_encryption_helper.dart';
import 'package:workout_flutter/util/encrypt_decrypt_file.dart';

class MedicineDetail extends StatefulWidget {
  static const routeName = '/medicine_detail_page';
  final Medical medicine;

  MedicineDetail({required this.medicine});

  @override
  _MedicineDetailState createState() => _MedicineDetailState();
}

class _MedicineDetailState extends State<MedicineDetail> {
  late Medical medical;
  late File medicalImage;
  final picker = ImagePicker();

  void initState() {
    medical = widget.medicine;
    Provider.of<AlarmDataProvider>(context, listen: false)
        .isAlarmScheduled(medical.docId as String);
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
        title: Text(medical.name ?? 'Medicine Detail'),
      ),
      body: Consumer<AlarmDataProvider>(
        builder: (context, alarm, _) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(4),
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
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    children: [
                      !(medicalImage.existsSync())
                          ? Text('No image selected')
                          : FullScreenWidget(
                              child: Hero(
                                tag: medical.name as String,
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
                      SizedBox(height: 6),
                      Text(
                        medical.name as String,
                        style: textStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        medical.rules as String,
                        style: textStyle.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return ListTile(
                            enabled: !alarm.isReminderActive,
                            title: Text(
                              'Time-${index + 1}',
                              style: textStyle,
                            ),
                            subtitle: Text(medical.times?[index] as String),
                            onTap: () {
                              DatePicker.showTimePicker(
                                context,
                                showTitleActions: true,
                                currentTime: DateTime.now(),
                                locale: LocaleType.id,
                                onConfirm: (date) {
                                  medical.times?[index] =
                                      "${date.hour}:${date.minute}:${date.second}";
                                  setState(() {
                                    firestore
                                        .collection("medicine_bi13rb8")
                                        .doc(medical.docId)
                                        .update({
                                      'times': medical.times
                                          ?.map((e) => encryptAESCryptoJS(
                                              e, passwordEncrypt))
                                          .toList()
                                    });
                                  });
                                },
                              );
                            },
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Delete'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text(
                                                'Delete current reminder time?'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            medical.times?[index] = '-';
                                            setState(() {
                                              firestore
                                                  .collection(
                                                      "medicine_bi13rb8")
                                                  .doc(medical.docId)
                                                  .update({
                                                'times': medical.times
                                                    ?.map((e) =>
                                                        encryptAESCryptoJS(
                                                            e, passwordEncrypt))
                                                    .toList()
                                              });
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                          );
                        },
                      ),
                      Consumer<SchedulingProvider>(
                        builder: (context, scheduled, _) {
                          return ListTile(
                            title: Text('Reminder'),
                            subtitle: Text('Turn on/off reminder'),
                            trailing: Switch.adaptive(
                              value: alarm.isReminderActive,
                              onChanged: (value) async {
                                await alarm.updateSchedule(
                                    medical.docId as String, value);
                                await alarm
                                    .isAlarmScheduled(medical.docId as String);
                                setState(() {
                                  if (value) {
                                    for (var i
                                        in (medical.times as List<String>)) {
                                      if (i != '-') {
                                        scheduled.scheduleNotification(
                                            medical.alarmId?[
                                                medical.times?.indexOf(i) ??
                                                    0] as int,
                                            i,
                                            medical);
                                      }
                                    }
                                  } else {
                                    medical.alarmId?.forEach((element) {
                                      scheduled.cancelNotification(element);
                                    });
                                  }
                                });
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16),
                      ListTile(
                        title: Text('Setelah makan?'),
                        subtitle: Text('Iya/Tidak'),
                        trailing: Switch.adaptive(
                            value: false, onChanged: (value) {}),
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
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
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
        storage.ref().child('${auth.currentUser?.email}/${medical.name}.jpg');
    await firebaseStorageRef.putFile(File(encryptedImage));
  }

  Future downloadImageFromFirebase() async {
    Reference firebaseStorageRef =
        storage.ref().child('${auth.currentUser?.email}/${medical.name}.jpg');
    DownloadTask downloadTask =
        firebaseStorageRef.writeToFile(File('$path/${medical.name}.jpg.aes'));
    await downloadTask.whenComplete(() {
      medicalImage =
          File(EncryptData.decryptFile('$path/${medical.name}.jpg.aes'));
      setState(() {});
    });
  }
}
