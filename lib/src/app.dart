import 'package:flutter/material.dart';
import 'package:listgenius/src/screens/my_home_page.dart';
import 'package:listgenius/src/screens/pages/page_evento.dart';
import 'package:listgenius/src/screens/pages/page_rutina.dart';
import 'package:listgenius/src/screens/pages/page_tarea.dart';
import 'package:listgenius/src/screens/pages/page_viaje.dart';
import 'package:listgenius/src/screens/temas/temas.dart';
import 'package:listgenius/src/screens/vistas/view_evento.dart';
import 'package:listgenius/src/screens/vistas/view_rutina.dart';
import 'package:listgenius/src/screens/vistas/view_tarea.dart';
import 'package:listgenius/src/screens/vistas/view_viaje.dart';
//import 'package:listgenius/src/screens/prueva.dart';

class MyApp extends StatelessWidget {
  // static const primaryColor = Color(0xff632c00);

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navigation Bar Example',
      theme: Temas.lightTema,
      darkTheme: Temas.dartTema,
      // themeMode: ThemeMode.light, //modo claro por defecto
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   colorScheme: const ColorScheme(
      //     brightness: Brightness.light,
          
      //     primary: Color(0xffa37437),
      //     onPrimary: Colors.white,

      //     secondary: Color(0xffd8c690),
      //     onSecondary: Color(0xffd8c690),

      //     background: Color(0xfffdf8ed),
      //     onBackground: Color(0xfffdf8ed),

      //     surface: Color(0xff301500),
      //     onSurface: Colors.black,

      //     error: Colors.red,
      //     onError: Colors.red,
      // ),     
      // ),
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
      },
    );
  }
}