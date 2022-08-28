import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:password2/common/entity/passw_store.dart';
import '../../../dao/password_manager.dart';
import '../../../common/routes/app_routes.dart';
import '../../../widget/dialog.dart';

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

    await flashData(0);
  }

  flashData(int i) async {
    genList = [
      InkWell(
        child: ListTile(
          leading: beforeIcon,
          title: Text("添加密码"),
          trailing: Icon(Icons.add),
        ),
        onTap: () async {
          await Get.toNamed(AppRoutes.AddPass, arguments: {
            "ctype": ctype,
            "title": title,
            "cid": "",
          });
          await flashData(1);
        },
      )
    ];

    var passwdStore = await PasswordManager.PasswdList(ctype);
    if (passwdStore != null) {
      logins = passwdStore.logins;
      cards = passwdStore.cards;
      identities = passwdStore.identities;
      notes = passwdStore.notes;
    }

    logins.forEach((element) {
      genList.add(Slidable(
        child: ListTile(
          title: Text("${element.name}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("创建时间: ${element.createTime}"),
              Text("Url: ${element.url??""}"),
              Text("备注: ${element.remark??""}")
            ],
          ),
          onTap: () async {
            await Get.toNamed(AppRoutes.AddPass, arguments: {
              "ctype": ctype,
              "title": "查看密码: ${element.name}",
              "cid": element.id,
              "edit": false,
            });

            flashData(1);
          },
        ),
        key: const ValueKey(0),
// The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              flex: 1,
              onPressed: (context) {
                deletePwd(context, element.id!, element.name!);
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

    loading = false;
    update();
  }

  deletePwd(BuildContext context, String id, String name) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return CustomDialog(
            title: '請確認刪除',
            content: name,
            confirmCallback: () async {
              bool? r = await PasswordManager.DeletePwd(id);
              if (r == null) {
                Get.snackbar("SUCCESS", "删除失败");
                return;
              }
              Get.snackbar("SUCCESS", "刪除成功");
              flashData(1);
            },
          );
        });
  }
}
