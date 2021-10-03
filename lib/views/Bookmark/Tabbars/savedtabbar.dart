import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:news/Bottomsheet/bottomsheet.dart';
import 'package:news/Utils/widgetsizecontrol.dart';
import 'package:news/Webview/webview.dart';
import 'package:news/controllers/bookmarkcontroller.dart';
import 'package:news/controllers/newscontroller.dart';
import 'package:share/share.dart';

import 'package:timeago/timeago.dart' as timeago;

class Savedbookmark extends StatelessWidget {
  final bookmarkController = Get.put(BookmarkController());
  final newsController = Get.put(NewsController());
  static late double savedtabWidth;
  static late double savedtabHeight;
  @override
  Widget build(BuildContext context) {
    savedtabWidth = Widgetratio(context).width;
    savedtabHeight = Widgetratio(context).height;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Obx(() {
        if (bookmarkController.bookmarkstore.length != 0) {
          return ListView.separated(
              separatorBuilder: (context, index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 9),
                    child: Divider(
                      thickness: 1,
                      height: 3,
                    ),
                  ),
              itemCount: bookmarkController.bookmarkstore.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          String newsurl =
                              bookmarkController.bookmarkstore[index].url!;
                          Get.to(() => WebviewPage(),
                              arguments: newsurl, fullscreenDialog: true);
                        },
                        child: Card(
                            // margin: EdgeInsets.all(0),
                            elevation: 0,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  ListNews(
                                    bookmarkController: bookmarkController,
                                    index: index,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 250,
                                          child: Row(
                                            children: [
                                              Timeago(
                                                  bookmarkController:
                                                      bookmarkController,
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
                                                  bookmarkController
                                                              .bookmarkstore[
                                                                  index]
                                                              .author !=
                                                          null
                                                      ? bookmarkController
                                                          .bookmarkstore[index]
                                                          .author!
                                                      : "",
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                  splashColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onPressed: () {
                                                    if (bookmarkController
                                                            .bookmarkstore[
                                                                index]
                                                            .like ==
                                                        true) {
                                                      changeboolognews(index);

                                                      bookmarkController
                                                          .bookmarkstore
                                                          .removeAt(index);
                                                    }
                                                  },
                                                  icon: bookmarkController
                                                              .bookmarkstore[
                                                                  index]
                                                              .like ==
                                                          true
                                                      ? Icon(
                                                          CupertinoIcons
                                                              .bookmark_fill,
                                                          size: 20,
                                                          color:
                                                              Color(0xFFC74B16),
                                                        )
                                                      : Icon(
                                                          CupertinoIcons
                                                              .bookmark,
                                                          size: 20,
                                                        )),
                                              IconButton(
                                                  onPressed: () {
                                                    Get.bottomSheet(BottomShit(
                                                      url: bookmarkController
                                                          .bookmarkstore[index]
                                                          .url!,
                                                      subject:
                                                          bookmarkController
                                                              .bookmarkstore[
                                                                  index]
                                                              .title!,
                                                              height:Savedbookmark.savedtabHeight
                                                    ));
                                                  },
                                                  splashColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
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
                              ),
                            )),
                      ),
                    ],
                  ),
                );
              });
        } else {
          return Nobookmarks();
        }
      }),
    );
  }

  void changeboolognews(int index) {
    var newsindex = newsController.newsList().articles!.indexWhere((element) =>
        element.title == bookmarkController.bookmarkstore[index].title);
    print(newsindex);
    if (newsindex != -1) {
      newsController.bookmarkismarked[newsindex] = false;
    }
  }
}

class Nobookmarks extends StatelessWidget {
  const Nobookmarks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              CupertinoIcons.bookmark,
              size: 100,
              color: Colors.grey.shade400,
            ),
            Text(
              "No saved content",
              style: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: "Raleway",
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Looks like you haven't saved anything yet.\nTap on bookmark to start saving content.",
              style: TextStyle(
                color: Colors.grey.shade400,
                fontFamily: "Raleway",
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class ListNews extends StatelessWidget {
  const ListNews({
    required this.bookmarkController,
    required this.index,
  });

  final BookmarkController bookmarkController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (bookmarkController.bookmarkstore[index].urlToImage != null) ...[
          Container(
            // width: 256,
            width: Savedbookmark.savedtabWidth / 1.50,
            height: Savedbookmark.savedtabHeight / 8.3,
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 20),
            child: Text(bookmarkController.bookmarkstore[index].title!,
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                )),
          ),
          Container(
            height: 100.0,
            width: 100.0,
            child: CachedNetworkImage(
              imageUrl: bookmarkController.bookmarkstore[index].urlToImage!,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fitHeight,
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
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ] else ...[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: Savedbookmark.savedtabHeight / 8.3,
              padding: EdgeInsets.only(right: 20),
              child: Text(bookmarkController.bookmarkstore[index].title!,
                  style: TextStyle(
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  )),
            ),
          ),
        ]
      ],
    );
  }
}


class Timeago extends StatelessWidget {
  const Timeago({
    required this.bookmarkController,
    required this.index,
  });

  final BookmarkController bookmarkController;
  final int index;

  @override
  Widget build(BuildContext context) {
    var date = bookmarkController.bookmarkstore[index].publishedAt!.toLocal();

    var ago = DateTime.now().subtract(Duration(minutes: date.minute));

    return Text(timeago.format(ago));
  }
}
