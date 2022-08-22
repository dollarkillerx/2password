import 'package:password2/pages/user/login.dart';
import 'package:password2/pages/user/registration.dart';

import '../../pages/bashboard/binding.dart';
import '../../pages/bashboard/index.dart';
import '../../pages/notfound/index.dart';
import 'app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static const INIT = AppRoutes.DASHBOARD;

  static final routes = [
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => DashBoardPage(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: AppRoutes.Login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.Regitry,
      page: () => RegistrationPage(),
    ),
  ];

  static final unknownRoute = GetPage(
    name: AppRoutes.NOTFOUND,
    page: () => NotFoundView(),
  );
}
