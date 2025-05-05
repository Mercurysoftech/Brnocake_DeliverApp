import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      //iOS: initializationSettingsIOS
    );
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  _notificationDetails() async {
    //final bigPicture = await ByteArrayAndroidBitmap.fromAsset('assets/notificationlogo.png');
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max,
          icon: 'notificationlogo',
          color: Color(0xFFFF0000)),
    );
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return notificationsPlugin
        .show(id, title, body, await _notificationDetails(), payload: payload);
  }
}
