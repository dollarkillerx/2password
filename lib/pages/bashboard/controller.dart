import 'package:get/get.dart';
import 'package:password2/dao/login.dart';
import '../../common/routes/app_routes.dart';
import '../../common/storage/user.dart';

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

   var r = await AppData.getJWT();
   if (r == null) {
     Get.offAllNamed(AppRoutes.Login);
     return;
   }

   if (!LoginDao.loggedIn) {
     Get.offAllNamed(AppRoutes.AuthLocal);
     return;
   }
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //
  //
  // }
}
