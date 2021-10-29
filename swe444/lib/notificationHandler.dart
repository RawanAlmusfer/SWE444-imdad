import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

createLocalNotification({required Map<String, dynamic> message}) async {
  print(message);

  final Map<String, String> data = {};

  message.forEach((key, value) {
    data[key] = value.toString();
  });

  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: int.parse(randomNumeric(3)),
          channelKey: 'basic_channel',
          title: message['title'],
          body: message['message'],
          payload: data));
}

// Converts remote notifcation to local notification
handleNetworkNotification(RemoteMessage message) {
  print(message.notification);
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: int.parse(randomNumeric(3)),
          channelKey: 'basic_channel',
          title: message.notification!.title,
          body: message.notification!.body,
          payload: {}));
}

// It will be called when the app is terminated
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await createLocalNotification(message: message.data);
}

dynamic initializeLocalNotification() {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        importance: NotificationImportance.Max,
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Colors.black,
        ledColor: Colors.white)
  ]);
}
