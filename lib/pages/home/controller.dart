import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../dao/store.dart';

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

    var passwdStore = await EncryptionStore.GET();
    if (passwdStore != null) {
      websiteLen = passwdStore.notes!.length;
      cardLen = passwdStore.notes!.length;
      identityLen = passwdStore.notes!.length;
      noteLen = passwdStore.notes!.length;
      galleryLen = passwdStore.notes!.length;
    }

    loading = false;
    update();
  }
}
