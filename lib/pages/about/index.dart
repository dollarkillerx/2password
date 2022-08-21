import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class AboutPage extends GetView<AboutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AboutController>(
        builder: (controller) {
          return Center(
            child: Text("About"),
          );
        },
      ),
    );
  }
}
