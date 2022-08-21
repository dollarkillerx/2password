import 'package:flutter/material.dart';
import 'package:password2/widget/loading.dart';
import '../../common/entity/captcha.dart';
import '../../dao/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginEnable = false; // 參數校驗完畢 可登錄
  String? account;
  String? password;
  String? captcha;
  String? captchaID;
  String? captchaImage;
  var loading = true;

  @override
  void initState() {
    super.initState();
    onInitNetwork();
  }

  onInitNetwork() async {
    CaptchaEntity? cap =  await LoginDao.captcha();
    if (cap != null) {
      setState(() {
        captchaImage = cap.data!.base64Captcha!;
        captchaID = cap.data!.captchaId!;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: LoadingWidget(
        child: Text("Login"),
        isLoading: loading,
      ),
    );
  }
}
