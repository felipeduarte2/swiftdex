import 'package:flutter/material.dart';
import 'package:listgenius/services/notification_services.dart';
import 'package:listgenius/src/app.dart';

Future<void> main() async {

  // 
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();

  // 
  runApp(const MyApp());
}
