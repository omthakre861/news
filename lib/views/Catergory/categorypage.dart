import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/Search/searchdeglate.dart';
import 'package:news/Search/searchdetails.dart';

import 'categorydetails.dart';
import 'categorylist.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // backgroundColor: Colors.white,
          appBar: AppBar(
            // backgroundColor: Colors.white,
            elevation: 0,
            title: Text("Categories",
                style: TextStyle(
                    // color: Colors.black,
                    fontFamily: "Merriweather",
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            centerTitle: true,
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
                iconSize: 30,
                // color: Colors.black87,
                padding: EdgeInsets.only(right: 20),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              )
            ],
          ),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (2 / 1),
            ),
            physics: BouncingScrollPhysics(),
            itemCount: categoryinfo.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  String categoryindex = categoryinfo[index].id!;
                  // print(categoryinfo[index].id);
                  Get.to(() => Categorydetails(), arguments: categoryindex);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Card(
                  elevation: 0,
                  color: Get.isDarkMode ? null : Colors.grey[200],
                  margin: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: Text(
                              categoryinfo[index].emoji!,
                            ),
                          ),
                          Container(
                            child: Text(
                              categoryinfo[index].title!,
                              style: TextStyle(
                                fontFamily: 'RobotoMono',
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7),
                        child: Text(
                          categoryinfo[index].desc!,
                          style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            // color: Colors.grey.shade600
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
