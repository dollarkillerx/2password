import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../dao/password_manager.dart';

class GeneralListController extends GetxController {
  final String ctype = Get.arguments["ctype"];
  final String title = Get.arguments["title"];
  Icon beforeIcon = Icon(Icons.add);

  var loading = true;

  @override
  void onInit() async {
    super.onInit();

    switch (ctype) {
      case "website":
        beforeIcon = Icon(Icons.webhook_outlined);
        break;
      case "card":
        beforeIcon = Icon(Icons.add_card);
        break;
      case "identity":
        beforeIcon = Icon(Icons.perm_identity);
        break;
      case "note":
        beforeIcon = Icon(Icons.note_alt_outlined);
        break;
      case "gallery":
        beforeIcon = Icon(Icons.browse_gallery_rounded);
        break;
    }

    // var passwdStore = await EncryptionStore.GET();
    // if (passwdStore == null) {
    //
    // }

    loading = false;
    update();
  }
}
