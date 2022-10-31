import 'dart:ffi';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    InitializationSettings settings = InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(settings);
  }

  static void handle(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails("book_nook", "book_nook_channel"),
      );
      await _notificationsPlugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails);

    } catch (e) {
      print(e.toString());
    }
    

    // print(e.toString());
  }
}
