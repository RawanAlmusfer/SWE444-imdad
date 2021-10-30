import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Functions/decisions_tree.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'notificationHandler.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: false);

// in backgroung
FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

// trminated
FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    await createLocalNotification(message: message.data);
  });

// foreground
  FirebaseMessaging.onMessageOpenedApp.listen((message) async {
    await createLocalNotification(message: message.data);
  });

  initializeLocalNotification();
  AwesomeNotifications().actionStream.listen((receivedNotification) {
    Get.to(DecisionsTree());
  });

  FirebaseMessaging.instance.getToken().then((token) {
    print(token);
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: DecisionsTree(),
        theme: ThemeData(fontFamily: 'Tajawal'),
      ),
      designSize: const Size(390, 844),
    );
  }
}
