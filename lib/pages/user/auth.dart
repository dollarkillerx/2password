import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password2/dao/password_manager.dart';
import '../../common/routes/app_routes.dart';
import '../../common/storage/user.dart';
import '../../dao/login.dart';
import '../../widget/input.dart';
import 'package:get/get.dart';


class AuthLol extends StatefulWidget {
  const AuthLol({Key? key}) : super(key: key);

  @override
  State<AuthLol> createState() => _AuthLolState();
}

class _AuthLolState extends State<AuthLol> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  String mps = "";

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
          ? _SupportState.supported
          : _SupportState.unsupported),
    );
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = '驗證';
      });
      authenticated = await auth.authenticate(
        localizedReason:
        '2Password 密码管理器生物识别验证',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating2';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });

    if (_authorized == "Authorized") {
      LoginDao.loggedIn = true;
      Get.offAllNamed(AppRoutes.DASHBOARD);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("验证主密码"),),
      body: Container(
        child: Column(
          children: [
            LoginInput(
              title: "主密码",
              hint: "验证主密码",
              onChanged: (text) {
                mps = text;
              },
            ),
            LoginButton("使用生物识别解锁",onPressed: _authenticateWithBiometrics),
            LoginButton("提交",onPressed: () {
              if (AppData.getMainPass() == mps) {
                LoginDao.loggedIn = true;
                Get.offAllNamed(AppRoutes.DASHBOARD);
              }
            }),
          ],
        ),
      ),
    );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}