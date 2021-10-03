import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:news/Bottomsheet/bottomsheet.dart';
import 'package:news/Search/searchdeglate.dart';
import 'package:news/Search/searchdetails.dart';
import 'package:news/Utils/widgetsizecontrol.dart';
import 'package:news/controllers/categorycontroller.dart';
import 'package:news/Webview/webview.dart';
import 'package:share/share.dart';
import 'package:timeago/timeago.dart' as timeago;

class Categorydetails extends StatelessWidget {
  Categorydetails({Key? key}) : super(key: key);

  final categoryController = Get.put(CategoryController());
  final categoryindex = Get.arguments;
  static late double categorydetailsWidth;
  static late double categorydetailsHeight;

  @override
  Widget build(BuildContext context) {
    categorydetailsWidth = Widgetratio(context).width;
    categorydetailsHeight = Widgetratio(context).height;
    categoryController.updateCategory(categoryindex);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.black : null,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(categoryindex,
            style: TextStyle(
                // color: Colors.black,
                fontFamily: "Merriweather",
                fontWeight: FontWeight.bold)),
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
        actions: [
          IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () async {
                var search =
                    await showSearch(context: context, delegate: Searchpage());
                if (search != null && search != "") {
                  // print(search);
                  Get.to(() => SearchDetails(), arguments: search);
                }
              },
              icon: Icon(
                CupertinoIcons.search,
                // color: Colors.black,
              ))
        ],
      ),
      // backgroundColor: Colors.white,
      body: Obx(() {
        if (categoryController.isLoading.value) {
          return Center(
              child: CupertinoActivityIndicator(
            radius: 25,
            animating: true,
          ));
        } else {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemCount: categoryController.categoryList().articles!.length,
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
                        String newsurl = categoryController
                            .categoryList()
                            .articles![index]
                            .url!;
                        Get.to(() => WebviewPage(),
                            arguments: newsurl, fullscreenDialog: true);
                      },
                      child: CategoryNewsCard(
                        categoryController: categoryController,
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
          );
        }
      }),
    );
  }
}

class CategoryNewsCard extends StatelessWidget {
  const CategoryNewsCard({
    Key? key,
    required this.categoryController,
    required this.index,
  }) : super(key: key);

  final CategoryController categoryController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          elevation: 0,
          child: Container(
              padding: EdgeInsets.all(5),
              height: categoryController
                          .categoryList()
                          .articles![index]
                          .urlToImage !=
                      null
                  ? Categorydetails.categorydetailsHeight / 2.7
                  : Categorydetails.categorydetailsHeight / 7.5,
              child: Column(
                children: [
                  if (categoryController
                          .categoryList()
                          .articles![index]
                          .urlToImage !=
                      null) ...[
                    Container(
                      // width: 360,
                      // height: 200,
                      width: Categorydetails.categorydetailsWidth,
                      height: Categorydetails.categorydetailsHeight / 4.2,
                      child: CachedNetworkImage(
                        imageUrl: categoryController
                            .categoryList()
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
                    // height: 39,
                    height: Categorydetails.categorydetailsHeight / 19,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      categoryController.categoryList().articles![index].title!,
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
                          // width: 250,
                          width: Categorydetails.categorydetailsWidth / 1.53,
                          child: Row(
                            children: [
                              Timeago(
                                  categoryController: categoryController,
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
                                  categoryController
                                              .categoryList()
                                              .articles![index]
                                              .author !=
                                          null
                                      ? categoryController
                                          .categoryList()
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    Get.bottomSheet(BottomShit(
                                      url: categoryController
                                          .categoryList()
                                          .articles![index]
                                          .url!,
                                      subject: categoryController
                                          .categoryList()
                                          .articles![index]
                                          .title!,
                                      height:
                                          Categorydetails.categorydetailsHeight,
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
              ))),
    );
  }
}

class Timeago extends StatelessWidget {
  const Timeago({
    required this.categoryController,
    required this.index,
  });

  final CategoryController categoryController;
  final int index;

  @override
  Widget build(BuildContext context) {
    var date = categoryController
        .categoryList()
        .articles![index]
        .publishedAt!
        .toLocal();

    var ago = DateTime.now().subtract(Duration(minutes: date.minute));

    return Text(timeago.format(ago));
  }
}
