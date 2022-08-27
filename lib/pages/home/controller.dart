import 'package:get/get.dart';
import 'package:password2/common/entity/passw_store.dart';
import '../../dao/password_manager.dart';

class HomeController extends GetxController {
  var loading = true;

  int websiteLen = 0;
  int cardLen = 0;
  int identityLen = 0;
  int noteLen = 0;
  int galleryLen = 0;

  @override
  void onInit() async {
    super.onInit();

    PasswordAllInfoEntity? passwordAllInfoEntity = await PasswordManager.AllInfo();
    if (passwordAllInfoEntity == null) {
      // Get.snackbar("Error", "登錄失敗 賬戶或密碼錯誤");
      loading = false;
      update();
      return;
    }

    this.websiteLen = passwordAllInfoEntity.data!.loginTypeCount!;
    this.cardLen = passwordAllInfoEntity.data!.cardCount!;
    this.identityLen = passwordAllInfoEntity.data!.identityTypeCount!;
    this.noteLen = passwordAllInfoEntity.data!.noteTypeCount!;

    loading = false;
    update();
  }
}
