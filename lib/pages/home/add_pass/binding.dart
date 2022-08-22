import 'package:get/get.dart';
import 'controller.dart';

class AddPassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPassController>(() => AddPassController());
  }
}
