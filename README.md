# Elderly App Flutter

A flutter project for Google Solution Challenge 2021.

## Getting Started

To Build This Project
> flutter build apk --split-per-abi --no-sound-null-safety

Build In Debug Version
> flutter build apk --debug --no-sound-null-safety

No Sound Null Safety used because this project depend on dependencies that not support null safety yet.
For now, this app is optimize for android user only, we will arrange the things needed to run on iOS in future update.

## Introduce
Introducing, AERA, a healthcare application that provides elders with an easily-access self-care system
Cognitive decline and heart diseases are among the most common problems found in elders. When designing our platform, we decided to start from these 2 concerns.

Aera app is equipped with 3 main features,

(1) AeraMed, a medication reminder to help elders remember to consume their medicines. It is completed with a picture and time, which is connected to phone calendar and reminds each time they have to take medicine. 

![app3](https://user-images.githubusercontent.com/64909665/113159043-7f00a400-9266-11eb-824b-dd231d4a8e7f.png)


(2) AeraHealth shows tutorials of effective exercises for elders to boost circulations. To overcome losing motivation in keeping up with the routines, AeraHealth allows users to receive reward points which can later be exchanged with healthcare vouchers. 

![app2](https://user-images.githubusercontent.com/64909665/113159196-9c357280-9266-11eb-9a98-c8730cc9b4e4.png)

(3) Last one, the AeraCall! a feature that lists hospitals’ hotlines and locations.

![app4](https://user-images.githubusercontent.com/64909665/113159227-a3f51700-9266-11eb-8f05-ee1a4fc2aca7.png)


AeraApp uses 2 services of firebase, firestore to store all the data and storage to save pictures. In building the whole structure, we utilize the features from flutter.

![storage](https://user-images.githubusercontent.com/64909665/113160956-26320b00-9268-11eb-8d2a-93cad525f5ff.png)
![firestore](https://user-images.githubusercontent.com/64909665/113161234-62656b80-9268-11eb-88fa-7fc28c685ba8.png)


We also used Google Maps Platform In Our App

![maps](https://user-images.githubusercontent.com/64909665/113161611-bff9b800-9268-11eb-9189-23b5013357a7.png)



# Credit For Images Used In Our App

- [Christopher Campbell](https://unsplash.com/photos/kFCdfLbu6zA)
- [Manu B](https://unsplash.com/photos/6RI9-xSaELE)
- [Alex McCarthy](https://unsplash.com/photos/a6FHROHuQ9o)
- [Carl Barcelo](https://unsplash.com/photos/nqUHQkuVj3c)
- [People vector created by pch.vector - www.freepik.com](https://www.freepik.com/vectors/people)

# Dependencies Used In Our App
- [cupertino_icons](https://pub.dev/packages/cupertino_icons)
- [intro_slider](https://pub.dev/packages/intro_slider)
- [provider](https://pub.dev/packages/provider)
- [path_provider](https://pub.dev/packages/path_provider)
- [sqflite](https://pub.dev/packages/sqflite)
- [intl](https://pub.dev/packages/intl)
- [flutter_staggered_animations](https://pub.dev/packages/flutter_staggered_animations)
- [url_launcher](https://pub.dev/packages/url_launcher)
- [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
- [android_alarm_manager](https://pub.dev/packages/android_alarm_manager)
- [rxdart](https://pub.dev/packages/rxdart)
- [shared_preferences](https://pub.dev/packages/shared_preferences)
- [cloud_firestore](https://pub.dev/packages/cloud_firestore)
- [firebase_core](https://pub.dev/packages/firebase_core)
- [firebase_auth](https://pub.dev/packages/firebase_auth)
- [firebase_storage](https://pub.dev/packages/firebase_storage)
- [path](https://pub.dev/packages/path)
- [image_picker](https://pub.dev/packages/image_picker)
- [full_screen_image](https://pub.dev/packages/full_screen_image)
- [http](https://pub.dev/packages/http)
- [tuple](https://pub.dev/packages/tuple)
- [encrypt](https://pub.dev/packages/encrypt)
- [aes_crypt](https://pub.dev/packages/aes_crypt)
- [flutter_datetime_picker](https://pub.dev/packages/flutter_datetime_picker)
- [youtube_player_flutter](https://pub.dev/packages/youtube_player_flutter)
- [contacts_service](https://pub.dev/packages/contacts_service)
- [permission_handler](https://pub.dev/packages/permission_handler)
- [geolocator](https://pub.dev/packages/geolocator)
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
- [modal_bottom_sheet](https://pub.dev/packages/modal_bottom_sheet)
- [giffy_dialog](https://pub.dev/packages/giffy_dialog)

