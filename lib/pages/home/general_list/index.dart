import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password2/widget/loading.dart';
import '../../../common/routes/app_routes.dart';
import 'controller.dart';

class GeneralListPage extends GetView<GeneralListController> {
  _view() {
    return Container(
      child: ListView(
        children: [
          InkWell(
            child: ListTile(
              leading: controller.beforeIcon,
              title: Text("添加密码"),
              trailing: Icon(Icons.add),
            ),
            onTap: () {
              Get.toNamed(AppRoutes.AddPass,
                  arguments: {
                    "ctype": controller.ctype,
                    "title": controller.title,
                    "cid": "",
                  });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
      ),
      body: GetBuilder<GeneralListController>(
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
