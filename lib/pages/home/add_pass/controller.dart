import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/entity/passw_store.dart';
import '../../../common/utils/strings.dart';
import '../../../dao/password_manager.dart';

class AddPassController extends GetxController {
  final String ctype = Get.arguments["ctype"];
  String? title = Get.arguments["title"];
  String? cid = Get.arguments["cid"];
  bool? edit = Get.arguments["edit"];
  Icon beforeIcon = const Icon(Icons.add);
  bool loginEnable = false; // 參數校驗完畢 可登錄

  Logins logins = Logins();
  Cards cards = Cards();
  Identities identities = Identities();
  Notes notes = Notes();

  var loading = true;

  @override
  void onInit() async {
    super.onInit();

    title = "添加 $title";

    switch (ctype) {
      case "website":
        beforeIcon = const Icon(Icons.webhook_outlined);
        break;
      case "card":
        beforeIcon = const Icon(Icons.add_card);
        break;
      case "identity":
        beforeIcon = const Icon(Icons.perm_identity);
        break;
      case "note":
        beforeIcon = const Icon(Icons.note_alt_outlined);
        break;
    }

    if (cid != "") {
     var px = await PasswordManager.PasswordInfo(cid!);
     if (px != null) {
       logins = px.logins;
       cards = px.cards;
       identities = px.identities;
       notes = px.notes;
       print("==============");
       print(logins.name);
       print("==============2");

     }
    }

    loading = false;
    update();
  }

  void checkInputByLogin() {
    bool enable;
    if (isNotEmpty(logins.account) &&
        isNotEmpty(logins.password) &&
        isNotEmpty(logins.name)) {
      enable = true;
    } else {
      enable = false;
    }
    loginEnable = enable;
    update();
  }

  void addParams() async {
    // var passwdStore = await PasswordManager.AllInfo();
    // if (passwdStore != null) {
      switch (ctype) {
        case "login":
          bool? r = await PasswordManager.AddPassword(ctype, logins);
          if (r== null) {
            Get.snackbar("Error", "添加失败");
            return;
          }
          Get.snackbar("SUCCESS", "添加成功");
          break;
        // case "card":
        //   passwdStore.cards?.add(cards);
        //   break;
        // case "identity":
        //   passwdStore.identities?.add(identities);
        //   break;
        // case "note":
        //   passwdStore.notes?.add(notes);
        //   break;
      }


  }
}
