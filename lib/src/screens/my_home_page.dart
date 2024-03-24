import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:listgenius/src/screens/views/calendar.dart';
import 'package:listgenius/src/screens/views/controlador.dart';
import 'package:listgenius/src/screens/views/list.dart';
import 'package:listgenius/src/screens/views/usser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MainWraoperController controller = Get.put(MainWraoperController());

  @override
  void initState() {
    loadId();
    super.initState();
  }

  void loadId() async {
    String id = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('ID') ?? '';
    });
    if (id == "") {
      prefs.setString('ID', '0');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("SwiftDex", style: TextStyle(fontSize: 20,)),
        centerTitle: true,
      ),

      body: PageView(
        onPageChanged: controller.animateTopTap,
        controller: controller.pageControler,
        physics: const BouncingScrollPhysics(),
        children: const [
          ListViewPage(),
          TableCalendarPage(),
          UserPage(),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Obx(
            ()=> Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _bottomAppBarIten(context, icon: IconlyLight.document, page: 0, label: "LISTA"),
                _bottomAppBarIten(context, icon: IconlyLight.calendar, page: 1, label: "CALENDARIO"),
                _bottomAppBarIten(context, icon: IconlyLight.profile, page: 2, label: "USUARIO"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBarIten(BuildContext context,{required icon, required page, required label}){
    return ZoomTapAnimation(
      onTap: () => controller.goToTap(page),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: controller.currentPage.value == page ? Colors.blue : Colors.blue[200],
          ),
          Text(
            label,
            style: TextStyle(color: controller.currentPage.value == page ? Colors.blue : Colors.blue[200],),)
        ],
      ),
    );
  }
  
}


