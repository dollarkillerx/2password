import 'package:flutter/material.dart';
import 'package:ninja/asymmetric/rsa/rsa.dart';
import '../../common/entity/captcha.dart';
import '../../common/utils/img.dart';
import '../../common/utils/strings.dart';
import '../../dao/login.dart';
import '../../widget/input.dart';
import '../../widget/loading.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool loginEnable = true; // 參數校驗完畢 可登錄
  String? account;
  String? password;
  String? password2;
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
      appBar: AppBar(title: Text("Register"),),
      body: LoadingWidget(
        child: ListView(
          children: [
            LoginInput(
              title: "用戶名",
              hint: "請輸入用戶名",
              onChanged: (text) {
                account = text;
                checkInput();
              },
            ),
            LoginInput(
                title: "密碼",
                hint: "請輸入密碼",
                obscureText: true,
                onChanged: (text) {
                  password = text;
                  checkInput();
                }
            ),
            LoginInput(
                title: "確認密碼",
                hint: "請再次輸入密碼",
                obscureText: true,
                onChanged: (text) {
                  password2 = text;
                  checkInput();
                }
            ),
            LoginInput(
              title: "驗證碼",
              hint: "請輸驗證碼",
              obscureText: false,
              onChanged: (text) {
                captcha = text;
                checkInput();
              },

              rightWidget: Container(
                height: 40,
                padding: EdgeInsets.only(right: 10),
                child: (){
                  if (this.captchaImage != null) {
                    return InkWell(
                      child: imageFromBase64String(this.captchaImage!),
                      onTap: () async {
                        await upImg();
                      },
                    );
                  }
                  return Container();
                }(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton('注冊',
                  enable: loginEnable, onPressed: checkParams),
            )
          ],
        ),
        isLoading: loading,
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(account) &&
        isNotEmpty(password) &&
        isNotEmpty(password2)  && isNotEmpty(captcha)) {
      enable = true;
    } else {
      enable = false;
    }

    setState(() {
      loginEnable = enable;
    });
  }

  upImg() async {
    CaptchaEntity? cap =  await LoginDao.captcha();
    if (cap != null) {
      setState(() {
        captchaImage = cap.data!.base64Captcha!;
        captchaID = cap.data!.captchaId!;
      });
    }
  }

  checkParams() async {
    final privateKey = RSAPrivateKey.generate(1024);
    print(privateKey.p);
    print(privateKey.q);
    print(privateKey.n.bitLength);
    print(privateKey.toPem());
    print(privateKey.toPublicKey.toPem(toPkcs1: true));
  }
}
