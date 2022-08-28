import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password2/widget/loading.dart';
import 'controller.dart';

class GeneralListPage extends GetView<GeneralListController> {
  _view() {
    return ListView.builder(
        itemCount: controller.genList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => controller.genList[index]);
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
              child: Container(
                child: _view(),
              ),
              isLoading: controller.loading);
        },
      ),
    );
  }
}
