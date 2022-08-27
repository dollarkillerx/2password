import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:password2/common/storage/user.dart';
import 'package:password2/common/utils/strings.dart'; // 加密

class Encrypt {
  // 加密
  static Future<String?> AESEncryption(String input) async {
    var vk = await AppData.getMainPass();
    if (vk == null) {
      return null;
    }
    var newPassword = filling(vk, 32, "0");
    final key = encrypt.Key.fromUtf8(newPassword);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(input, iv: iv);
    return encrypted.base64;
  }

  // 解密
  static Future<String?> AESDecrypt(String input) async {
    var vk = await AppData.getMainPass();
    if (vk == null) {
      return null;
    }
    var newPassword = filling(vk, 32, "0");
    final key = encrypt.Key.fromUtf8(newPassword);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));


    final rdata = encrypter.decrypt(
        encrypt.Encrypted.fromBase64(input),
        iv: iv);

    return rdata;
  }
}