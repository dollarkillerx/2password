import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password2/widget/loading.dart';
import '../../common/routes/app_routes.dart';
import 'controller.dart';

class HomePage extends GetView<HomeController> {
  _view() {
    return Container(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.webhook_outlined),
            title: Text("网站"),
            trailing: Text("${controller.websiteLen}"),
            onTap: () {
              Get.toNamed(AppRoutes.GeneralList,
                  arguments: {
                    "ctype": "website",
                    "title": "网站密码",
                  });
            },
          ),
          ListTile(
            leading: Icon(Icons.add_card),
            title: Text("支付卡"),
            trailing: Text("${controller.cardLen}"),
            onTap: () {
              Get.toNamed(AppRoutes.GeneralList,
                  arguments: {
                    "ctype": "card",
                    "title": "支付卡",
                  });
            },
          ),
          ListTile(
            leading: Icon(Icons.perm_identity),
            title: Text("身份"),
            trailing: Text("${controller.identityLen}"),
            onTap: () {
              Get.toNamed(AppRoutes.GeneralList,
                  arguments: {
                    "ctype": "identity",
                    "title": "身份",
                  });
            },
          ),
          ListTile(
            leading: Icon(Icons.note_alt_outlined),
            title: Text("安全笔记"),
            trailing: Text("${controller.noteLen}"),
            onTap: () {
              Get.toNamed(AppRoutes.GeneralList,
                  arguments: {
                    "ctype": "note",
                    "title": "安全笔记",
                  });
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return LoadingWidget(
              child: Center(
                child: _view(),
              ),
              isLoading: controller.loading);
        },
      ),
    );
  }
}
