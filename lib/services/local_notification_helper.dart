import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';

NotificationDetails get _noSound 
{
  final androidChannelSpecifics = AndroidNotificationDetails
  (
    'silent channel id',
    'silent channel name',
    'silent channel description',
    playSound: false,
  );
  final iOSChannelSpecifics = IOSNotificationDetails(presentSound: false);

  return NotificationDetails(android: androidChannelSpecifics, iOS: iOSChannelSpecifics);
}

Future showSilentNotification
(
    FlutterLocalNotificationsPlugin notifications, 
    {
      @required String title,
      @required String body,
      int id = 0,
    }
) => showNotification(notifications, title: title, body: body, id: id, type: _noSound);

NotificationDetails get _ongoing 
{
  final androidChannelSpecifics = AndroidNotificationDetails
  (
    'your channel id',
    'your channel name',
    'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    ongoing: true,
    autoCancel: false,
    styleInformation: BigTextStyleInformation(''),
  );
  final iOSChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(android: androidChannelSpecifics, iOS: iOSChannelSpecifics);
}

NotificationDetails get _onetime 
{
  final androidChannelSpecifics = AndroidNotificationDetails
  (
    'your channel id',
    'your channel name',
    'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    ongoing: false,
    autoCancel: false,
    styleInformation: BigTextStyleInformation(''),
  );
  final iOSChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(android: androidChannelSpecifics, iOS: iOSChannelSpecifics);
}

Future showOnGoingNotification
(
  FlutterLocalNotificationsPlugin notifications, 
  {
  @required String title,
  @required String body,
  int id = 0,
}) => showNotification(notifications, title: title, body: body, id: id, type: _ongoing);

Future showOneTimeNotification
(
  FlutterLocalNotificationsPlugin notifications, 
  {
  @required String title,
  @required String body,
  int id = 0,
}) => showNotification(notifications, title: title, body: body, id: id, type: _onetime);

Future showNotification
(
  FlutterLocalNotificationsPlugin notifications, 
  {
    @required String title,
    @required String body,
    @required NotificationDetails type,
    int id = 0,
  }
) => notifications.show(id, title, body, type);