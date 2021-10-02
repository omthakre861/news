import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:news/Search/searchdeglate.dart';
import 'package:news/Search/searchdetails.dart';
import 'package:news/Theme/theme.dart';
import 'package:news/Webview/webview.dart';
import 'package:news/controllers/bookmarkcontroller.dart';
import 'package:news/controllers/categorycontroller.dart';
import 'package:news/controllers/newscontroller.dart';
import 'package:news/models/bookmark.dart';
import 'package:news/views/Catergory/categorydetails.dart';
import 'package:share/share.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatelessWidget {
  final newsController = Get.put(NewsController());
  final bookmarkController = Get.put(BookmarkController());

  @override
  Widget build(BuildContext context) {
    Future<void> update() async {
      newsController.refresh();
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Get.isDarkMode ? Colors.black : null,
          elevation: 0,
          title: Text("IMAGINE",
              style: TextStyle(
                  // color: Colors.black,
                  fontFamily: "Merriweather",
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
          actions: [
            IconButton(
              onPressed: () async {
                var search =
                    await showSearch(context: context, delegate: Searchpage());
                if (search != null && search != "") {
                  print(search);
                  Get.to(() => SearchDetails(), arguments: search);
                }
              },
              icon: Icon(CupertinoIcons.search),
              iconSize: 25,
              // color: Colors.black87,
              padding: EdgeInsets.only(right: 20),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            )
          ],
        ),
        // backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: update,
          child: Obx(() {
            if (newsController.isLoading.value) {
              return Center(
                  child: CupertinoActivityIndicator(
                radius: 25,
                animating: true,
              ));
            } else {
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: newsController.newsList().articles!.length,
                separatorBuilder: (context, index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    child: Divider(
                      thickness: 1,
                      height: 5,
                    )),
                itemBuilder: (context, index) {
                  return CardTile(
                      newsController: newsController,
                      index: index,
                      bookmarkController: bookmarkController);
                },
              );
            }
          }),
        ));
  }
}

class CardTile extends StatelessWidget {
  const CardTile(
      {Key? key,
      required this.newsController,
      required this.index,
      required this.bookmarkController})
      : super(key: key);

  final NewsController newsController;
  final int index;
  final BookmarkController bookmarkController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  String newsurl =
                      newsController.newsList().articles![index].url!;
                  Get.to(() => WebviewPage(),
                      arguments: newsurl, fullscreenDialog: true);
                },
                child: Card(
                  // margin: EdgeInsets.all(0),
                  elevation: 0,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    // alignment: Alignment.topCenter,
                    height: index == 0 ? 320 : 160,
                    child: Column(
                      children: [
                        if (index == 0) ...[
                          HeadNews(
                            newsController: newsController,
                            index: index,
                          )
                        ] else ...[
                          ListNews(
                              newsController: newsController, index: index),
                        ],
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 250,
                                child: Row(
                                  children: [
                                    Timeago(
                                        newsController: newsController,
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
                                        newsController
                                                    .newsList()
                                                    .articles![index]
                                                    .author !=
                                                null
                                            ? newsController
                                                .newsList()
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
                                        onPressed: () {
                                          newsController.bookmarkbtn(index);

                                          // print(index);
                                          print(bookmarkvalue());
                                          if (newsController
                                              .bookmarkismarked[index]) {
                                            bookmarkController.bookmarkstore
                                                .add(bookmarkvalue());
                                            print(bookmarkController
                                                .bookmarkstore[0]);
                                            Get.snackbar("Saved",
                                                "You can find this story in Bookmarks.",
                                                isDismissible: true,
                                                dismissDirection:
                                                    SnackDismissDirection
                                                        .HORIZONTAL,
                                                titleText: Text("Saved",
                                                    style: TextStyle(
                                                      fontFamily: "RobotoMono",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    )),
                                                messageText: Text(
                                                    "You can find this story in Bookmarks."),
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                barBlur: 8,
                                                icon: Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: Icon(
                                                    CupertinoIcons
                                                        .bookmark_fill,
                                                    size: 40,
                                                    color: Color(0xFFC74B16),
                                                  ),
                                                ),
                                                shouldIconPulse: false);
                                          } else {
                                            bookmarkController.bookmarkstore
                                                .removeWhere((element) =>
                                                    element.title ==
                                                    newsController
                                                        .newsList()
                                                        .articles![index]
                                                        .title);
                                            print(bookmarkController
                                                .bookmarkstore);
                                          }
                                        },
                                        icon: !newsController
                                                .bookmarkismarked[index]
                                            ? Icon(
                                                CupertinoIcons.bookmark,
                                                size: 20,
                                              )
                                            : Icon(
                                                CupertinoIcons.bookmark_fill,
                                                size: 20,
                                                color: Color(0xFFC74B16),
                                              )),
                                    IconButton(
                                        onPressed: () {
                                          Get.bottomSheet(BottomSheet(
                                            url: newsController
                                                .newsList()
                                                .articles![index]
                                                .url!,
                                            subject: newsController
                                                .newsList()
                                                .articles![index]
                                                .title!,
                                          ));
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
                    ),
                  ),
                ),
              ),
              // Divider(
              //   thickness: 1,
              //   color: Colors.grey.shade200,
              // )
            ],
          ),
        ));
  }

  Bookmark bookmarkvalue() {
    return Bookmark(
      like: newsController.bookmarkismarked[index],
      author: newsController.newsList().articles![index].author,
      title: newsController.newsList().articles![index].title,
      description: newsController.newsList().articles![index].description,
      url: newsController.newsList().articles![index].url,
      urlToImage: newsController.newsList().articles![index].urlToImage,
      publishedAt: newsController.newsList().articles![index].publishedAt,
      content: newsController.newsList().articles![index].content,
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    required this.url,
    required this.subject,
    Key? key,
  }) : super(key: key);

  final String url;
  final String subject;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: (Radius.circular(15.0)),
              topRight: (Radius.circular(15.0))),
        ),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                CupertinoIcons.share,
                size: 25,
                color: Colors.black,
              ),
              title: Text(
                'Share too ...',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Share.share(
                  url,
                  subject: subject,
                );
              },
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.link,
                size: 25,
                color: Colors.black,
              ),
              title: Text(
                'Copy link',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: url));
                Get.back();
                Fluttertoast.showToast(
                    msg: "Link is Copied !!!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.eye_slash_fill,
                size: 25,
                color: Colors.black,
              ),
              title: Text(
                'Not interesting',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.exclamationmark_circle,
                size: 25,
                color: Colors.black,
              ),
              title: Text(
                'Report',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ));
  }
}

class HeadNews extends StatelessWidget {
  const HeadNews({
    required this.newsController,
    required this.index,
  });

  final NewsController newsController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          if (newsController.newsList().articles![index].urlToImage !=
              null) ...[
            Container(
              width: 360,
              height: 200,
              child: CachedNetworkImage(
                imageUrl:
                    newsController.newsList().articles![index].urlToImage!,
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
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ] else ...[
            SizedBox()
          ],
          SizedBox(
            height: 8,
          ),
          Container(
            child: Text(
              newsController.newsList().articles![index].title!,
              style: TextStyle(
                fontFamily: 'RobotoMono',
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListNews extends StatelessWidget {
  const ListNews({
    required this.newsController,
    required this.index,
  });

  final NewsController newsController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (newsController.newsList().articles![index].urlToImage != null) ...[
          Container(
            alignment: Alignment.topCenter,
            // color: Colors.red,
            width: 256,
            height: 90,
            padding: EdgeInsets.only(right: 20),
            child: Text(newsController.newsList().articles![index].title!,
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
              imageUrl: newsController.newsList().articles![index].urlToImage!,
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
              height: 95,
              padding: EdgeInsets.only(right: 20),
              child: Text(newsController.newsList().articles![index].title!,
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
    required this.newsController,
    required this.index,
  });

  final NewsController newsController;
  final int index;

  @override
  Widget build(BuildContext context) {
    var date =
        newsController.newsList().articles![index].publishedAt!.toLocal();

    var ago = DateTime.now().subtract(Duration(minutes: date.minute));

    return Text(timeago.format(ago));
  }
}
