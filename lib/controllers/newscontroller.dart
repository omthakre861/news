import 'package:get/get.dart';
import 'package:news/models/newsheadline.dart';
import 'package:news/services/ApiService.dart';

import 'bookmarkcontroller.dart';

class NewsController extends GetxController {
  var newsList = NewsHeadline().obs;
  var saved = Set<Article>().obs;
  var isLoading = true.obs;
  List<bool> bookmarkismarked = <bool>[].obs;
  final bookmarkController = Get.put(BookmarkController());

  @override
  void onInit() {
    // TODO: implement onInit
    fetchNewsHeadline();

    print("Initalized");

    super.onInit();
  }

  void fetchNewsHeadline() async {
    try {
      isLoading(true);
      var news = await ApiService.fetchNewsHeadline();
      if (news != null) {
        newsList.value = news;
        if (bookmarkismarked.isEmpty) {
          bookmarkismarked = new List<bool>.generate(
              newsList.value.articles!.length, (_) => false).obs;
          if (bookmarkController.bookmarkstore.isNotEmpty) {
            bookmarkController.bookmarkstore.forEach((element) {
              var title = element.title;
              print(element.title);
              for (var i = 0; i < newsList.value.articles!.length; i++) {
                if (newsList.value.articles![i].title == title) {
                  bookmarkismarked[i] = true;
                }
              }
              // newsList.value.articles!.forEach((e) {

              //   if (e.title == title) {
              //     bookmarkismarked[e.title.allMatches(string)]
              // }
              // }

              // );
              // if (newsList().articles.) {
              //   print(element.title);
              // }
            });
          }
          print(bookmarkismarked);
        }
      }
    } finally {
      // TODO
      isLoading(false);
    }
  }

  Future<void> refresh() async {
    fetchNewsHeadline();
  }

  void bookmarkbtn(int index) {
    if (bookmarkismarked.isEmpty) {
      bookmarkismarked =
          new List<bool>.generate(newsList.value.articles!.length, (_) => false)
              .obs;
      print("Bookcreated from empy");
    } else {
      bookmarkismarked[index] = !bookmarkismarked[index];
    }
  }
}
