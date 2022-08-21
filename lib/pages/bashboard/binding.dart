import 'package:get/get.dart';
import 'package:password2/pages/about/controller.dart';
import 'package:password2/pages/about/provider.dart';
import 'package:password2/pages/home/controller.dart';
import 'package:password2/pages/home/provider.dart';
import 'controller.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(() => DashBoardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AboutController>(() => AboutController());

    Get.put(HomeProvider());
    Get.put(AboutProvider());
  }
}
