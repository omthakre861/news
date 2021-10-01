import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CategoryWebView extends StatefulWidget {
  CategoryWebView({Key? key}) : super(key: key);

  @override
  _CategoryWebViewState createState() => _CategoryWebViewState();
}

class _CategoryWebViewState extends State<CategoryWebView> {
  final url = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          return NavigationDecision.prevent;
        },
      ),
    );
  }
}
