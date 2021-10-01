import 'package:get/get.dart';
import 'package:news/models/categornews.dart';
import 'package:news/services/ApiService.dart';

class CategoryController extends GetxController {
  var categoryList = CategoryNews().obs;
  var isLoading = true.obs;

  

  void fetchCategoryList(String catergoryname) async {
    try {
      isLoading(true);
      var news = await CategoryService.fetchCategory(catergoryname);
      if (news != null) {
        categoryList.value = news;
      }
    } finally {
      // TODO
      isLoading(false);
    }
  }

  updateCategory(String index) {
    fetchCategoryList(index);
  }
}
