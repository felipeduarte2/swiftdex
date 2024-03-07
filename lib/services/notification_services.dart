import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async{
  const  AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('app_icon');

  const DarwinInitializationSettings initializationSettingsIOS  = DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: initializationSettingsIOS,
  );

  await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
} 

Future<void> mostrarNotificacion() async{
  const  AndroidNotificationDetails andrDetails = AndroidNotificationDetails(
      'channel id',
      'channel name',
  );
  const  DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
  const  NotificationDetails notificationDetails = NotificationDetails(
    android: andrDetails, 
    iOS: iosDetails
  );
  await  _flutterLocalNotificationsPlugin.show(1, 'titulo de la notificación', 'mensaje de la notificación',notificationDetails);
}

