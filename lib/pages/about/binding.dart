import 'package:get/get.dart';
import 'provider.dart';
import 'controller.dart';

class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutController>(() => AboutController());
    Get.lazyPut<AboutProvider>(() => AboutProvider());
  }
}
