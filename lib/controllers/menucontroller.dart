import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/Theme/theme.dart';

class MenuController extends GetxController {
  var switchbutton = false.obs;

  void theme(bool isOn) {
    if (isOn) {
      Get.changeTheme(ThemeData(
          brightness: Brightness.dark, primarySwatch: ThemeView().black));
    } else {
      Get.changeTheme(ThemeData(
          primarySwatch: ThemeView().white,
          brightness: Brightness.light,
          // backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white));
    }
  }
}
