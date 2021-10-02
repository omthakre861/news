import 'package:get/get.dart';
import 'package:news/models/search.dart';
import 'package:news/services/ApiService.dart';

class SearchController extends GetxController {
  var searchnewslist = SearchNews().obs;
  var isLoading = true.obs;
  final List<String> sortlist = <String>[
    "popularity",
    "relevancy",
    "publishedAt"
  ];
  var sortselected = 0.obs;
  final List<bool> isSelected = <bool>[true, false, false, false].obs;
  var storequery = "";
  void fetchSearchList(String query) async {
    try {
      isLoading(true);
      storequery = query;
      var news =
          await SearchService.fetchSearch(query, sortlist[sortselected.value]);
      if (news != null) {
        searchnewslist.value = news;
      }
    } finally {
      // TODO
      isLoading(false);
    }
  }

  Future<void> updatesearchnews() async {
    fetchSearchList(storequery);
  }
}
