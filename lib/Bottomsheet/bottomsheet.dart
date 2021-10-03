import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class BottomShit extends StatelessWidget {
  const BottomShit({
    required this.url,
    required this.subject,
    required this.height,
    Key? key,
  }) : super(key: key);

  final String url;
  final String subject;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height / 3.6,
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
