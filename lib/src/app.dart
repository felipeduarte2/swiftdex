import 'package:flutter/material.dart';
import 'package:listgenius/src/screens/my_home_page.dart';
import 'package:listgenius/src/screens/pages/page_evento.dart';
import 'package:listgenius/src/screens/pages/page_rutina.dart';
import 'package:listgenius/src/screens/pages/page_tarea.dart';
import 'package:listgenius/src/screens/pages/page_viaje.dart';
import 'package:listgenius/src/screens/temas/temas.dart';
import 'package:listgenius/src/screens/views/login_screen.dart';
import 'package:listgenius/src/screens/vistas/view_evento.dart';
import 'package:listgenius/src/screens/vistas/view_rutina.dart';
import 'package:listgenius/src/screens/vistas/view_tarea.dart';
import 'package:listgenius/src/screens/vistas/view_viaje.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navigation Bar Example',
      theme: Temas.lightTema,
      darkTheme: Temas.dartTema,
      //home: MyHomePage(),
      routes: {
        "/":(BuildContext builder)=> const MyHomePage(),
        // "/second":(BuildContext builder)=> Secon_Page(),
        "/evento":(BuildContext builder)=> const EventoPage(),
        "/rutina":(BuildContext builder)=> const RutinaPage(),
        "/tarea":(BuildContext builder)=> const TareaPage(),
        "/viaje":(BuildContext builder)=> const ViajePage(),
        "/viewevento":(BuildContext builder)=> const EventoDetails(),
        "/viewrutina":(BuildContext builder)=> const RutinaDetails(),
        "/viewviaje":(BuildContext builder)=> const ViajeDetails(),
        "/viewtarea":(BuildContext builder)=> const TareaDetails(),
        "/user_info":(BuildContext builder)=> const LoginScreen(),
      },
    );
  }
}