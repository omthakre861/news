import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Recentlytabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: IconButton(
          onPressed: () {
            Get.changeTheme(ThemeData(brightness: Brightness.dark));
          },
          icon: Icon(Icons.access_alarm)),
    ));
  }
}
