import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password2/widget/loading.dart';
import '../../../widget/input.dart';
import 'controller.dart';

class AddPassPage extends GetView<AddPassController> {
  _view() {
    return Container(
      child: ListView(
        children: [
          LoginInput(
            title: "name",
            hint: "請輸入名称",
            onChanged: (text) {
              controller.logins.name = text;
              controller.checkInput();
            },
          ),
          LoginInput(
            title: "account",
            hint: "請輸入账户名",
            onChanged: (text) {
              controller.logins.account = text;
              controller.checkInput();
            },
          ),
          LoginInput(
            title: "password",
            hint: "請輸入密码",
            onChanged: (text) {
              controller.logins.password = text;
              controller.checkInput();
            },
          ),
          LoginInput(
            title: "remark",
            hint: "請輸入备注",
            onChanged: (text) {
              controller.logins.remark = text;
              controller.checkInput();
            },
          ),
          LoginInput(
            title: "url",
            hint: "請輸入url",
            onChanged: (text) {
              controller.logins.url = text;
              controller.checkInput();
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: LoginButton('添加',
                enable: controller.loginEnable,
                onPressed: controller.addParams),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("返回")),
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
      body: GetBuilder<AddPassController>(
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
