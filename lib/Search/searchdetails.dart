import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/Webview/webview.dart';
import 'package:news/controllers/searchcontroller.dart';

import 'package:timeago/timeago.dart' as timeago;

class SearchDetails extends StatelessWidget {
  final searchController = Get.put(SearchController());
  final query = Get.arguments;
  final List<String> sortmenu = <String>["Popular", "Relevance", "Date"];
  final List<bool> isSelected = <bool>[true, false, false, false];

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  @override
  Widget build(BuildContext context) {
    searchController.fetchSearchList(query);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.black : null,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          capitalize(query),
          style: TextStyle(
              // color: Colors.black,
              fontFamily: "Merriweather",
              fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(
              CupertinoIcons.back,
              // color: Colors.black,
            )),
      ),
      // backgroundColor: Colors.white,
      body: Obx(() {
        if (searchController.isLoading.value) {
          return Center(
              child: CupertinoActivityIndicator(
            radius: 25,
            animating: true,
          ));
        } else {
          return Column(
            children: [
              SortMenu(
                  sortmenu: sortmenu,
                  searchController: searchController,
                  isSelected: isSelected),
              Expanded(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemCount: searchController.searchnewslist().articles!.length,
                  separatorBuilder: (context, index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        thickness: 1,
                        height: 5,
                      )),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              String newsurl = searchController
                                  .searchnewslist()
                                  .articles![index]
                                  .url!;
                              Get.to(() => WebviewPage(),
                                  arguments: newsurl, fullscreenDialog: true);
                            },
                            child: CategoryNewsCard(
                              searchController: searchController,
                              index: index,
                            ),
                          ),
                          // Divider(
                          //   thickness: 1,
                          //   color: Colors.grey.shade200,
                          // )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

class SortMenu extends StatelessWidget {
  const SortMenu({
    Key? key,
    required this.sortmenu,
    required this.searchController,
    required this.isSelected,
  }) : super(key: key);

  final List<String> sortmenu;
  final SearchController searchController;
  final List<bool> isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Get.isDarkMode ? Colors.black : Colors.white,
        padding: EdgeInsets.all(5),
        height: 40.0,
        child: Row(
          children: [
            Container(
                child: Text(
              "Sort:",
              style: TextStyle(
                  color: Colors.grey[400],
                  fontFamily: "RobotoMono",
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )),
            SizedBox(width: 5),
            Expanded(
              child: Container(
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                icon: Icon(
                  CupertinoIcons.chevron_down,
                  size: 15,
                ),
                isExpanded: true,
                value: sortmenu[searchController.sortselected.value],
                borderRadius: BorderRadius.circular(15),
                items: sortmenu
                    .map((items) => DropdownMenuItem<String>(
                        value: items,
                        child: Text(items,
                            style: TextStyle(
                              fontFamily: "RobotoMono",
                              fontWeight: FontWeight.bold,
                            ))))
                    .toList(),
                onChanged: (value) async {
                  int index = sortmenu.indexOf(value!);
                  searchController.sortselected.value = index;
                  await searchController.updatesearchnews();
                },
              ))),
            ),
            SizedBox(
              width: 14,
            ),
            ToggleButtons(
              splashColor: Colors.transparent,
              fillColor: Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text("All")),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text("Week")),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text("Month")),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text("Year")),
              ],
              isSelected: isSelected,
              selectedColor: Color(0xFFC74B16),
              onPressed: (index) {},
            )
          ],
        ));
  }
}

class CategoryNewsCard extends StatelessWidget {
  const CategoryNewsCard({
    Key? key,
    required this.searchController,
    required this.index,
  }) : super(key: key);

  final SearchController searchController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          child: Card(
              elevation: 0,
              child: Container(
                  padding: EdgeInsets.all(5),
                  height: searchController
                              .searchnewslist()
                              .articles![index]
                              .urlToImage !=
                          null
                      ? 305
                      : 105,
                  child: Column(
                    children: [
                      if (searchController
                              .searchnewslist()
                              .articles![index]
                              .urlToImage !=
                          null) ...[
                        Container(
                          width: 360,
                          height: 200,
                          child: CachedNetworkImage(
                            imageUrl: searchController
                                .searchnewslist()
                                .articles![index]
                                .urlToImage!,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Center(
                                child: CupertinoActivityIndicator(
                              animating: false,
                              radius: 15,
                            )),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ] else ...[
                        SizedBox()
                      ],
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 39,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          searchController
                              .searchnewslist()
                              .articles![index]
                              .title!,
                          style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              child: Row(
                                children: [
                                  Timeago(
                                      searchController: searchController,
                                      index: index),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('·'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      searchController
                                                  .searchnewslist()
                                                  .articles![index]
                                                  .author !=
                                              null
                                          ? searchController
                                              .searchnewslist()
                                              .articles![index]
                                              .author!
                                          : "",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onPressed: () {},
                                      icon: Icon(
                                        CupertinoIcons.bookmark,
                                        size: 20,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        Get.bottomSheet(Container(
                                            height: 250,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      (Radius.circular(15.0)),
                                                  topRight:
                                                      (Radius.circular(15.0))),
                                            ),
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  leading: Icon(
                                                    CupertinoIcons.share,
                                                    size: 25,
                                                    color: Colors.black,
                                                  ),
                                                  title: Text('Share too ...'),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                    CupertinoIcons.link,
                                                    size: 25,
                                                    color: Colors.black,
                                                  ),
                                                  title: Text('Copy link'),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                    CupertinoIcons
                                                        .eye_slash_fill,
                                                    size: 25,
                                                    color: Colors.black,
                                                  ),
                                                  title:
                                                      Text('Not interesting'),
                                                ),
                                                ListTile(
                                                  leading: Icon(
                                                    CupertinoIcons
                                                        .exclamationmark_circle,
                                                    size: 25,
                                                    color: Colors.black,
                                                  ),
                                                  title: Text('Report'),
                                                ),
                                              ],
                                            )));
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      icon: Icon(
                                        CupertinoIcons.ellipsis,
                                        size: 20,
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ))),
        ));
  }
}

class Timeago extends StatelessWidget {
  const Timeago({
    required this.searchController,
    required this.index,
  });

  final SearchController searchController;
  final int index;

  @override
  Widget build(BuildContext context) {
    var date = searchController
        .searchnewslist()
        .articles![index]
        .publishedAt!
        .toLocal();

    var ago = DateTime.now().subtract(Duration(minutes: date.minute));

    return Text(timeago.format(ago));
  }
}
