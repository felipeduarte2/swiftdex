import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainWraoperController extends GetxController {
  late PageController pageControler;
  RxInt currentPage = 0.obs;


  void goToTap(int page){
    currentPage.value = page;
    pageControler.jumpToPage(page);
  }

  
  void animateTopTap(int page){
    currentPage.value = page;
    pageControler.animateToPage(page, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void onInit() {
    pageControler = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void onClose() {
    pageControler.dispose();
    super.onClose();
  }
}