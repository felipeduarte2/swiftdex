import 'package:flutter/material.dart';

class Temas {
  static ThemeData lightTema = ThemeData(
    fontFamily: "Open Sans",
    colorSchemeSeed: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.blue,fontSize: 20),
      iconTheme: IconThemeData(color: Colors.blue),
      backgroundColor: Colors.white,
      elevation: 5,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor:  Colors.blue,
    ),

    bottomAppBarTheme: const BottomAppBarTheme(
      // color: Color(0xff63d3ff),
      color: Colors.white,
      elevation: 2,
    ),
    // iconTheme: const IconThemeData(color: Colors.white),

    // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    //   backgroundColor:  Color(0xff7498b6),
    //   elevation: 0,
    //   // selectedIconTheme: IconThemeData(color: Colors.white),
    //   // unselectedIconTheme: IconThemeData(color: Colors.grey),
    //   selectedItemColor: Colors.white,
    //   unselectedItemColor: Colors.white,
    // ),


    progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.red),
    textTheme: const TextTheme(
     displayLarge: TextStyle(letterSpacing: -1.5,fontSize: 48,color: Colors.black,fontWeight: FontWeight.bold),
     displayMedium: TextStyle(letterSpacing: -1.0,fontSize: 40,color: Colors.black,fontWeight: FontWeight.bold),
     displaySmall: TextStyle(letterSpacing: -1.0,fontSize: 32,color: Colors.black,fontWeight: FontWeight.bold),
     headlineMedium: TextStyle(letterSpacing: -1.0,fontSize: 28,color: Colors.black,fontWeight: FontWeight.w600),
     headlineSmall: TextStyle(letterSpacing: -1.0,fontSize: 24,color: Colors.black,fontWeight: FontWeight.w500),
     titleLarge: TextStyle(letterSpacing: -1.0,fontSize: 22,color: Colors.black,fontWeight: FontWeight.w400),
     titleMedium: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400),
     titleSmall: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
     bodyLarge: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
     bodyMedium: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
     bodySmall: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400),
     labelLarge: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
     labelMedium: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
     labelSmall: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400),
    ),
  );



  static ThemeData dartTema = ThemeData(
    fontFamily: "Open Sans",
    // primaryColor: Colors.yellow,
    colorSchemeSeed: Colors.blue,//color botones
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff00001a),//fondo
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff13122a),
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.blue,fontSize: 20),
      iconTheme: IconThemeData(color: Colors.blue),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor:  Colors.blue,
    ),
    // bottomNavigationBar,
    // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    //   backgroundColor:  Color(0xff13122a),
    //   elevation: 0,
    //   // selectedIconTheme: IconThemeData(color: Colors.white),
    //   // unselectedIconTheme: IconThemeData(color: Colors.grey),
    //   selectedItemColor: Colors.white,
    //   unselectedItemColor: Colors.white,
    // ),
     bottomAppBarTheme: const BottomAppBarTheme(
      // backgroundColor:  Color(0xff7498b6),
      color: Color(0xff13122a),
      elevation: 1,
    ),
    // iconTheme: const IconThemeData(color: Colors.white),
    // navigationBarTheme: const NavigationBarThemeData(
    //   backgroundColor: Colors.red,
    //   iconTheme: MaterialStatePropertyAll(IconThemeData(color: Colors.white)),
    //   ),
    // cardColor: Colors.black,
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.red),
    textTheme: const TextTheme(
     displayLarge: TextStyle(letterSpacing: -1.5,fontSize: 48,color: Colors.white,fontWeight: FontWeight.bold),
     displayMedium: TextStyle(letterSpacing: -1.0,fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold),
     displaySmall: TextStyle(letterSpacing: -1.0,fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),
     headlineMedium: TextStyle(letterSpacing: -1.0,fontSize: 28,color: Colors.white,fontWeight: FontWeight.w600),
     headlineSmall: TextStyle(letterSpacing: -1.0,fontSize: 24,color: Colors.white,fontWeight: FontWeight.w500),
     titleLarge: TextStyle(letterSpacing: -1.0,fontSize: 22,color: Colors.white,fontWeight: FontWeight.w400),
     titleMedium: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
     titleSmall: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
     bodyLarge: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
     bodyMedium: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
     bodySmall: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
     labelLarge: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
     labelMedium: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
     labelSmall: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400),
    ),
  );
}
