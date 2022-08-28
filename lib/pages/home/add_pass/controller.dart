import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/entity/passw_store.dart';
import '../../../common/utils/img.dart';
import '../../../common/utils/strings.dart';
import '../../../dao/password_manager.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class AddPassController extends GetxController {
  final String ctype = Get.arguments["ctype"];
  String? title = Get.arguments["title"];
  String? cid = Get.arguments["cid"];
  bool? edit = Get.arguments["edit"];
  Icon beforeIcon = const Icon(Icons.add);
  var loginEnable = false.obs; // 參數校驗完畢 可登錄
  var readOnly = false;
  String modifyName = "修改";
  List<String> imgs = [];
  List<Widget> imgsWidget = [];

  Logins logins = Logins();
  Cards cards = Cards();
  Identities identities = Identities();
  Notes notes = Notes();

  var loading = true;

  @override
  void onInit() async {
    super.onInit();

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
        switch (ctype) {
          case "login":
            if (logins.img != null) {
              imgs = logins.img!;
              updateIMGList();
            }
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

    if (edit != null) {
      readOnly = true;
    }

    loading = false;
    update();
  }

  void checkInputByLogin() {
    bool enable = false;
    if (isNotEmpty(logins.account) &&
        isNotEmpty(logins.password) &&
        isNotEmpty(logins.name)) {
      enable = true;
    } else {
      enable = false;
    }
    loginEnable.value = enable;
  }

  void addParams() async {
    // var passwdStore = await PasswordManager.AllInfo();
    // if (passwdStore != null) {
    switch (ctype) {
      case "login":
        logins.img = imgs;
        bool? r = await PasswordManager.AddPassword(ctype, logins);
        if (r == null) {
          Get.snackbar("Error", "添加失败");
          return;
        }
        Get.back();
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

  void modifyParams() async {
    if (modifyName != "提交修改") {
      readOnly = false;
      modifyName = "提交修改";

      update();
      return;
    }

    switch (ctype) {
      case "login":
        logins.img = imgs;
        bool? r = await PasswordManager.UpdatePwd(cid!, logins);
        if (r == null) {
          Get.snackbar("Error", "修改失败");
          return;
        }
        Get.back();
        Get.snackbar("SUCCESS", "修改成功");
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

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      // 压缩
      File? c = await Img.compressAndGetFile(File(image.path));
      if (c == null) return;
      var byt = await c.readAsBytes();
      imgs.add(base64Encode(byt));
      updateIMGList();
      update();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  updateIMGList() {
    imgsWidget.clear();
    imgs.forEach((element) {
      imgsWidget.add(Slidable(
        child: imageFromBase64String(element),
        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              flex: 1,
              onPressed: (context) {
                Future.delayed(Duration(milliseconds: 100), () {
                  imgs.remove(element);
                  updateIMGList();
                  update();
                });
              },
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              icon: Icons.save,
              label: '刪除',
            ),
          ],
        ),
      ));
    });
  }
}
