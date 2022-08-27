import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/entity/passw_store.dart';
import '../../../common/storage/user.dart';
import '../../../common/utils/strings.dart';
import '../../../dao/password_manager.dart';
import 'package:encrypt/encrypt.dart' as encrypt; // 加密

class AddPassController extends GetxController {
  final String ctype = Get.arguments["ctype"];
  String title = Get.arguments["title"];
  final String cid = Get.arguments["cid"];
  Icon beforeIcon = Icon(Icons.add);
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
    }

    loading = false;
    update();
  }

  void checkInput() {
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
    // var passwdStore = await EncryptionStore.GET();
    // if (passwdStore != null) {
    //   switch (ctype) {
    //     case "website":
    //       passwdStore.logins?.add(logins);
    //       break;
    //     case "card":
    //       passwdStore.cards?.add(cards);
    //       break;
    //     case "identity":
    //       passwdStore.identities?.add(identities);
    //       break;
    //     case "note":
    //       passwdStore.notes?.add(notes);
    //       break;
    //   }

    // bool? r = await EncryptionStore.Add(passwdStore);
    // if (r== null) {
    //   Get.snackbar("Error", "添加失败");
    //   return;
    // }
    // Get.snackbar("SUCCESS", "添加成功");
  }
}
