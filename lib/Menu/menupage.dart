import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:news/controllers/menucontroller.dart';

class MenuPage extends StatelessWidget {
  final menuController = Get.put(MenuController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: CupertinoColors.extraLightBackgroundGray,
          elevation: 0,
          title: Text("Menu",
              style: TextStyle(
                  // color: Colors.black,
                  fontFamily: "Merriweather",
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            CupertinoFormSection(
                // backgroundColor: CupertinoColors.extraLightBackgroundGray,
                header: Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Colors.black
                  ),
                ),
                children: [
                  ListTile(
                    title: Text("Log In"),
                    trailing: Icon(CupertinoIcons.forward),
                  ),
                  ListTile(
                    title: Text("Create Account"),
                    trailing: Icon(CupertinoIcons.forward),
                  ),
                ]),
            CupertinoFormSection(
                header: Text(
                  "General",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Colors.black
                  ),
                ),
                children: [
                  Obx(() => ListTile(
                        title: Text("Dark Mode"),
                        trailing: CupertinoSwitch(
                            value: menuController.switchbutton.value,
                            onChanged: (value) {
                              menuController.switchbutton.value = value;
                              menuController.theme(value);
                            }),
                      )),
                  ListTile(
                    title: Text("Feedback"),
                    trailing: Icon(CupertinoIcons.forward),
                  ),
                  ListTile(
                    title: Text("Contact Us"),
                    trailing: Icon(CupertinoIcons.forward),
                  ),
                  ListTile(
                    title: Text("Privacy Policy"),
                    trailing: Icon(CupertinoIcons.forward),
                  ),
                  ListTile(
                    title: Text("Terms of Services"),
                    trailing: Icon(CupertinoIcons.forward),
                  ),
                ])
          ],
        ));
  }
}
