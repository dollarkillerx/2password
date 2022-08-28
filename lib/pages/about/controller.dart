import 'package:get/get.dart';
import 'dart:math';

class AboutController extends GetxController {
  String pass = "";
  double value = 8; // 长度
  bool uppercaseLetter = true; // 大写字母
  bool lowerCaseLetters = true; // 小写字母
  bool number = true; // 数字
  bool specialCharacters = false; // 特殊字符

  String numberStr = "0123456789";
  String uppercaseLetterStr = "QWERTYUIOPASDFGHJKLZXCVBNM";
  String lowerCaseLettersStr = "qwertyuiopasdfghjklzxcvbnm";
  String specialCharactersStr = "!@#%^&*";

  modifyUppercaseLetter(bool ok) {
    uppercaseLetter = ok;
    update();
  }
  modifyLowerCaseLetters(bool ok) {
    lowerCaseLetters = ok;
    update();
  }
  modifyNumber(bool ok) {
    number = ok;
    update();
  }
  modifySpecialCharacters(bool ok) {
    specialCharacters = ok;
    update();
  }

  setValue(double k) {
    value = k.toInt().toDouble();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    flashData();
  }

  void flashData() {
    String pwd = "";
    String randStr = "";

    if (number) {
      var c = Random().nextInt(numberStr.length);
      pwd += numberStr[c];
      randStr += numberStr;
    }
    if (uppercaseLetter) {
      var c = Random().nextInt(uppercaseLetterStr.length);
      pwd += uppercaseLetterStr[c];
      randStr += uppercaseLetterStr;
    }
    if (lowerCaseLetters) {
      var c = Random().nextInt(lowerCaseLettersStr.length);
      pwd += lowerCaseLettersStr[c];
      randStr += lowerCaseLettersStr;
    }
    if (specialCharacters) {
      var c = Random().nextInt(specialCharactersStr.length);
      pwd += specialCharactersStr[c];
      randStr += specialCharactersStr;
    }

    var end = value-pwd.length;
    for (var i = 0;i<end;i++) {
      var c = Random().nextInt(randStr.length);
      pwd += randStr[c];
    }

    pass = pwd;
    update();
  }
}
