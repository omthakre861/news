import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news/models/bookmark.dart';

class BookmarkController extends GetxController {

  var bookmarkstore = <Bookmark>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    List? storedbookmark = GetStorage('Bookmark').read<List>('bookmarktore');
    if (storedbookmark != null) {
      bookmarkstore =
          storedbookmark.map((e) => Bookmark.fromJson(e)).toList().obs;
    }
    ever(bookmarkstore, (_) {
      GetStorage('Bookmark').write('bookmarktore', bookmarkstore.toList());
    });
    super.onInit();
  }

  
}
