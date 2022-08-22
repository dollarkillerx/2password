import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:password2/theme/app_themes.dart';
import 'common/routes/app_pages.dart';
import 'common/utils/view_ui.dart';
import 'dart:io';

void main() {
  // 设置沉浸式状态栏
  if(Platform.isAndroid){
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
  // changeStatusBar(color: colors.0, statusStyle: statusStyle);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "2Password",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INIT,
      getPages: AppPages.routes,
      unknownRoute: AppPages.unknownRoute,
      debugShowMaterialGrid: false,
      darkTheme: AppThemes.dark,
      theme: AppThemes.light,
      themeMode: ThemeMode.system,
      navigatorObservers: [
        FlutterSmartDialog.observer,
      ],
      builder: FlutterSmartDialog.init(),
    );
  }
}
