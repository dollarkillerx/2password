import 'dart:convert';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../common/entity/passw_store.dart';
import '../common/library/base_provider.dart';
import '../common/library/dio_adapter.dart';
import '../common/library/interface.dart';
import '../common/storage/user.dart';
import '../common/utils/strings.dart';
import 'package:encrypt/encrypt.dart' as encrypt; // 加密

class EncryptionStore {
  static Future<PasswdStore?> GET() async {
    var request = CaptchaGET();
    HiNetAdapter adapter = DioAdapter();

    try {
      var result = await adapter.send(request);
      var err = NetTools.CheckError(result.data);
      if (err != null) {
        print(err);
        // SmartDialog.showToast(err);
        return PasswdStore(
          logins: [],
          cards: [],
          identities: [],
          notes: [],
          loginsBak: [],
          cardsBak: [],
          identitiesBak: [],
          notesBak: [],
        );
      }

      print("object");
      print(result.data);
      print("=======");

      var pss = await AppData.getMainPass();
      var newPassword = filling(pss!, 32, "0");
      final key = encrypt.Key.fromUtf8(newPassword);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      print(encrypter.decrypt(encrypt.Encrypted.fromBase64(result.data)));
      final mp = jsonDecode(encrypter.decrypt(encrypt.Encrypted.fromBase64(result.data)));
          
      PasswdStore cap = PasswdStore.fromJson(mp);
      return cap;
    } catch (e) {
      print(e);
      SmartDialog.showToast("$e");
    }
    return PasswdStore(
      logins: [],
      cards: [],
      identities: [],
      notes: [],
      loginsBak: [],
      cardsBak: [],
      identitiesBak: [],
      notesBak: [],
    );
  }

  static Future<bool?> Add(PasswdStore ps) async {
    var request = CaptchaUP();
    HiNetAdapter adapter = DioAdapter();

    var rp = jsonEncode(ps);

    var pss = await AppData.getMainPass();
    var newPassword = filling(pss!, 32, "0");
    final key = encrypt.Key.fromUtf8(newPassword);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final iv = encrypt.IV.fromLength(16);

    var newData = encrypter.encrypt(rp, iv: iv).base64;

    request.setParam({
      "data": newData,
    });

    try {
      var result = await adapter.send(request);
      var err = NetTools.CheckError(result.data);
      if (err != null) {
        SmartDialog.showToast(err);
        return null;
      }

      return true;
    } catch (e) {
      print(e);
      SmartDialog.showToast("$e");
    }
    return null;
  }
}

class CaptchaGET extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool neeLogin() {
    return true;
  }

  @override
  String path() {
    return "internal/all";
  }
}

class CaptchaUP extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool neeLogin() {
    return true;
  }

  @override
  String path() {
    return "internal/update";
  }
}


class Registry extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool neeLogin() {
    return true;
  }

  @override
  String path() {
    return "internal/update";
  }
}