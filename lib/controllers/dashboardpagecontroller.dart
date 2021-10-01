import 'package:get/get.dart';

class DashboardPageController extends GetxController {
  var tabIndex = 0.obs;

  void dashTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
