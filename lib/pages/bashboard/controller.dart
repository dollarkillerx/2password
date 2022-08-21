import 'package:get/get.dart';

class DashBoardController extends GetxController {
  String storehouse = "";
  var title = "";
  var tabIndex = 0.obs;

  changeTabIndex(int index) async {
    tabIndex.value = index;
    update();
  }

  @override
  Future<void> onInit() async {
    update();
    super.onInit();
  }
}
