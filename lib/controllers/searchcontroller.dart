import 'package:get/get.dart';
import 'package:news/models/search.dart';
import 'package:news/services/ApiService.dart';

class SearchController extends GetxController{

 var searchnewslist = SearchNews().obs;
  var isLoading = true.obs;


  void fetchSearchList(String query) async {
    try {
      isLoading(true);
      var news = await SearchService.fetchSearch(query);
      if (news != null) {
        searchnewslist.value = news;
      }
    } finally {
      // TODO
      isLoading(false);
    }
  }


}