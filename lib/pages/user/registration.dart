import 'package:encrypt/encrypt.dart' as encrypt; // 加密
import 'package:flutter/material.dart';
import 'package:ninja/asymmetric/rsa/rsa.dart' as ninja; // 生成公钥私钥
// import 'package:pointycastle/asymmetric/api.dart';
import '../../common/entity/captcha.dart';
import '../../common/utils/img.dart';
import '../../common/utils/strings.dart';
import '../../dao/login.dart';
import '../../widget/input.dart';
import '../../widget/loading.dart';
import 'package:get/get.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool loginEnable = false; // 參數校驗完畢 可登錄
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
        title: Text("Register"),
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
                title: "確認密碼",
                hint: "請再次輸入密碼",
                obscureText: true,
                onChanged: (text) {
                  password2 = text;
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
        account!.length >= 4 &&
        password == password2 &&
        password!.length >= 8 &&
        isNotEmpty(captcha)) {
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

  // https://pub.dev/packages/ninja
  // https://github.com/leocavalcante/encrypt
  checkParams() async {
    print(password);
    var newPassword = filling(password!, 32, "0");
    print(newPassword);
    final key = encrypt.Key.fromUtf8(newPassword);
    final iv = encrypt.IV.fromLength(16);

    final privateKey = ninja.RSAPrivateKey.generate(1024);
    var pKey = privateKey.toPem();
    var pbKey = privateKey.toPublicKey.toPem(toPkcs1: true);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(pKey, iv: iv);

    bool? ok = await LoginDao.registry(captchaID!, captcha!, account!, pbKey, encrypted.base64);
    if (ok != null && ok) {
      Get.snackbar("SUCCESS", "注册成功");
    }else {
      upImg();
    }
    // password = filling(password!, 32, "0");
    // final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
    // final key = encrypt.Key.fromUtf8('my 32 length key................');
    // final iv = encrypt.IV.fromLength(16);
    //
    // final encrypter = encrypt.Encrypter(encrypt.AES(key));
    //
    // final encrypted = encrypter.encrypt(plainText, iv: iv);
    // final decrypted = encrypter.decrypt(encrypted, iv: iv);
    //
    // final privateKey = ninja.RSAPrivateKey.generate(1024);
    // var pKey = privateKey.toPem();
    // var pbKey = privateKey.toPublicKey.toPem(toPkcs1: true);
    //
    // RSAPublicKey? publicKey;
    // RSAPrivateKey? privKey;
    //
    // publicKey = encrypt.RSAKeyParser().parse(pbKey) as RSAPublicKey;
    // privKey = encrypt.RSAKeyParser().parse(pKey) as RSAPrivateKey;
    //
    // final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
    // final encrypter = encrypt.Encrypter(
    //     encrypt.RSA(publicKey: publicKey, privateKey: privKey));
    // final signer = encrypt.Signer(encrypt.RSASigner(
    //     encrypt.RSASignDigest.SHA256,
    //     publicKey: publicKey,
    //     privateKey: privKey));
    //
    // final encrypted = encrypter.encrypt(plainText);
    // final decrypted = encrypter.decrypt(encrypted);
    //
    // print(signer.sign('hello world').base64);
    // print(signer.verify64('hello world', signer.sign('hello world').base64));
    //
    // print(decrypted);
    // print(encrypted.base64);
    //
    //
    // bool? cap = await LoginDao.registry(captchaID!, captcha!, account!, publicKey, encryptedPrivateKey);
    // if (cap != null) {
    //   setState(() {
    //     captchaImage = cap.data!.base64Captcha!;
    //     captchaID = cap.data!.captchaId!;
    //   });
    // }
  }
}
