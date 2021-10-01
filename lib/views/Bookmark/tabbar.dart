import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:news/controllers/bookmarkcontroller.dart';
import 'package:news/controllers/newscontroller.dart';
import 'package:news/views/Bookmark/Tabbars/recentlytabbar.dart';
import 'package:news/views/Bookmark/Tabbars/savedtabbar.dart';

class Tabbar extends StatelessWidget {
  final bookmarkController = Get.put(BookmarkController());
  final newsController = Get.put(NewsController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
            // backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              "Bookmarks",
              style: TextStyle(
                  // color: Colors.black,
                  fontFamily: "Merriweather",
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            centerTitle: true,
            leading: Icon(
              CupertinoIcons.arrow_up_arrow_down,
              size: 20,
              // color: Colors.grey,
            ),
            actions: [
              TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    bookmarkController.bookmarkstore.clear();
                    newsController.bookmarkismarked.replaceRange(
                        0,
                        newsController.newsList().articles!.length,
                        List.generate(
                            newsController.newsList().articles!.length,
                            (_) => false));
                  },
                  child: Text(
                    "Clear all",
                    style: TextStyle(
                        color: Colors.red[400],
                        fontFamily: "Raleway",
                        fontSize: 18),
                  ))
            ],
            bottom: TabBar(
              tabs: [
                Tab(child: SavedwithNumber()),
                Tab(
                  child: Text(
                    "Recently viewed",
                    style: TextStyle(
                        fontFamily: "RobotoMono",
                        // color: Colors.black,
                        fontSize: 16),
                  ),
                ),
              ],
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              indicatorColor: Color(0xFFC74B16),
              labelColor: Color(0xFFC74B16),
              unselectedLabelColor:
                  Get.isDarkMode ? Colors.white : Colors.black,
            )),
        body: TabBarView(
          children: [Savedbookmark(), Recentlytabbar()],
        ),
      ),
    );
  }
}

class SavedwithNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookmarkController = Get.put(BookmarkController());

    return Obx(() => Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Saved",
                style: TextStyle(fontFamily: "RobotoMono", fontSize: 16),
              ),
              SizedBox(width: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 20,
                  width: 30,
                  alignment: Alignment.center,
                  color: Color(0xFFC74B16),
                  child: Text(
                    bookmarkController.bookmarkstore.length.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
