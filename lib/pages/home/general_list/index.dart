import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password2/widget/loading.dart';
import 'controller.dart';

class GeneralListPage extends GetView<GeneralListController> {
  _view() {
    return Container(
      child: ListView(
        children: controller.genList,
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
