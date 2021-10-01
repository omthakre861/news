import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/controllers/dashboardpagecontroller.dart';

import 'package:news/views/Bookmark/tabbar.dart';
import 'package:news/views/Catergory/categorypage.dart';
import 'package:news/views/Home/homepage.dart';
import 'package:news/Menu/menupage.dart';

class Dashboard extends StatelessWidget {
  buildBottomNavigationMenu(context, dashboardPageController) {
    return Obx(() => BottomNavigationBar(
            fixedColor: Color(0xFFC74B16),
            onTap: dashboardPageController.dashTabIndex,
            currentIndex: dashboardPageController.tabIndex.value,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                activeIcon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    CupertinoIcons.house_fill,
                    size: 20.0,
                  ),
                ),
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    CupertinoIcons.home,
                    size: 20.0,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                activeIcon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    CupertinoIcons.circle_grid_hex_fill,
                    size: 20.0,
                  ),
                ),
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    CupertinoIcons.circle_grid_hex,
                    size: 20.0,
                  ),
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                activeIcon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    CupertinoIcons.bookmark_fill,
                    size: 20.0,
                  ),
                ),
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    CupertinoIcons.bookmark,
                    size: 20.0,
                  ),
                ),
                label: 'Bookmarks',
              ),
              BottomNavigationBarItem(
                activeIcon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    CupertinoIcons.bars,
                    size: 20.0,
                  ),
                ),
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    CupertinoIcons.bars,
                    size: 20.0,
                  ),
                ),
                label: 'Menu',
              ),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    final dashboardPageController = Get.put(DashboardPageController());
    return Obx(() => Scaffold(
        bottomNavigationBar:
            buildBottomNavigationMenu(context, dashboardPageController),
        body: IndexedStack(
          index: dashboardPageController.tabIndex.value,
          children: [HomePage(), CategoryPage(), Tabbar(), MenuPage()],
        )));
  }
}
