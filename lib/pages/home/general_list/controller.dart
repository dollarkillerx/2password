import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password2/common/entity/passw_store.dart';
import '../../../dao/password_manager.dart';
import '../../../common/routes/app_routes.dart';


class GeneralListController extends GetxController {
  final String ctype = Get.arguments["ctype"];
  final String title = Get.arguments["title"];
  Icon beforeIcon = Icon(Icons.add);

  List<Logins> logins = [];
  List<Cards> cards = [];
  List<Identities> identities = [];
  List<Notes> notes = [];

  List<Widget> genList = [];

  var loading = true;

  @override
  void onInit() async {
    super.onInit();

    switch (ctype) {
      case "login":
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

    this.genList.add(InkWell(
      child: ListTile(
        leading: beforeIcon,
        title: Text("添加密码"),
        trailing: Icon(Icons.add),
      ),
      onTap: () {
        Get.toNamed(AppRoutes.AddPass,
            arguments: {
              "ctype": ctype,
              "title": title,
              "cid": "",
            });
      },
    ));

    var passwdStore = await PasswordManager.PasswdList(ctype);
    if (passwdStore != null) {
      logins = passwdStore.logins;
      cards = passwdStore.cards;
      identities = passwdStore.identities;
      notes = passwdStore.notes;
    }

    logins.forEach((element) {
      genList.add(ListTile(
        title: Text("${element.name}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("创建时间: ${element.createTime}"),
            Text("备注: ${element.remark}")
          ],
        ),
        onTap: () {
          Get.toNamed(AppRoutes.AddPass,
              arguments: {
                "ctype": ctype,
                "title": title,
                "cid": element.id,
                "edit": false,
              });
        },
      ));
    });

    loading = false;
    update();
  }
}
