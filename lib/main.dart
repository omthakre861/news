import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news/Theme/theme.dart';

import 'views/dashboard/dashboard.dart';

void main() async {
  await GetStorage.init('Bookmark');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          primarySwatch: ThemeView().white,
          scaffoldBackgroundColor: Colors.white),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}
