// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotiAlert {
//   static Future initialize(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var androidInitialize =
//         new AndroidInitializationSettings('mipmap/ic_launcher');
//     var iOSInitialize = new IOSInitializationSettings();
//     var initializationsSettings = new InitializationSettings(
//         android: androidInitialize, iOS: iOSInitialize);
//     await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
//   }

//   static Future showBigTextNotification(
//       {var id = 0,
//       String title,
//       String body,
//       var payload,
//       FlutterLocalNotificationsPlugin fln}) async {
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//         new AndroidNotificationDetails(
//       "notification",
//       "แจ้งเตือน",
//       "แจ้งเตือน",
//       playSound: true,
//       // sound: RawResourceAndroidNotificationSound('notification'),
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     var not = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: IOSNotificationDetails(),
//     );

//     await fln.show(0, title, body, not);
//   }
// }
