import 'package:get/get.dart';
import 'controller.dart';

class GeneralListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeneralListController>(() => GeneralListController());
  }
}
