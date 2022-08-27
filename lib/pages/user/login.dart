import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:password2/common/storage/user.dart';
import 'package:password2/widget/loading.dart';
import '../../common/entity/captcha.dart';
import '../../common/entity/user_auth.dart';
import '../../common/routes/app_routes.dart';
import '../../common/utils/img.dart';
import '../../common/utils/strings.dart';
import '../../dao/login.dart';
import '../../widget/input.dart';
import 'package:get/get.dart';
import 'package:encrypt/encrypt.dart' as encrypt; // 加密
import 'package:pointycastle/asymmetric/api.dart';

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
    CaptchaEntity? cap = await LoginDao.captcha();
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
      appBar: AppBar(
        title: Text("Login"),
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.Regitry);
            },
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              alignment: Alignment.center,
              child: Text(
                "Regitry",
                // style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
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
                }),
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
                child: () {
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
              child: LoginButton('登錄',
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
    if (isNotEmpty(account) && isNotEmpty(password) && isNotEmpty(captcha)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  upImg() async {
    CaptchaEntity? cap = await LoginDao.captcha();
    if (cap != null) {
      setState(() {
        captchaImage = cap.data!.base64Captcha!;
        captchaID = cap.data!.captchaId!;
      });
    }
  }

  checkParams() async {
    UserInfo? ui = await LoginDao.userInfo(account!);
    if (ui == null) {
      Get.snackbar("Error", "登錄失敗 賬戶或密碼錯誤");
      return;
    }

    try {
      var newPassword = filling(password!, 32, "0");
      final key = encrypt.Key.fromUtf8(newPassword);
      final iv = encrypt.IV.fromLength(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      final pKey = encrypter.decrypt(
          encrypt.Encrypted.fromBase64(ui.data!.encryptedPrivateKey!),
          iv: iv);
      RSAPublicKey? publicKey;
      RSAPrivateKey? privKey;

      publicKey =
          encrypt.RSAKeyParser().parse(ui.data!.publicKey!) as RSAPublicKey;
      privKey = encrypt.RSAKeyParser().parse(pKey) as RSAPrivateKey;

      AuthExpiration loginExpiration = AuthExpiration(
          expiration: DateTime.now()
              .add(new Duration(minutes: 3))
              .millisecondsSinceEpoch);
      var loginExpirationStr = jsonEncode(loginExpiration.toJson());
      var plainText = base64Encode(utf8.encode(loginExpirationStr));

      final signer = encrypt.Signer(encrypt.RSASigner(
          encrypt.RSASignDigest.SHA256,
          publicKey: publicKey,
          privateKey: privKey));

      LoginResponse? loginResponse = await LoginDao.login(captchaID!, captcha!,
          account!, "$plainText:${signer.sign(plainText).base64}");
      if (loginResponse == null) {
        upImg();
        Get.snackbar("Error", "登錄失敗 賬戶或密碼錯誤");
        return;
      }

      // 存储JWT &
      print(loginResponse.data!.jwt!);
      AppData.setJWT(loginResponse.data!.jwt!);
      AppData.setMainPass(password!);
      AppData.setEncryption(ui.data!.publicKey!, pKey);
      Get.snackbar("SUCCESS", "登錄成功");
      LoginDao.loggedIn = true;
      Get.offAllNamed(AppRoutes.DASHBOARD);
    } catch (e) {
      print(e);
      upImg();
      Get.snackbar("Error", "登錄失敗 賬戶或密碼錯誤");
      return;
    }
  }
}
