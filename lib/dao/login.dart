import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../common/entity/captcha.dart';
import '../common/entity/user_auth.dart';
import '../common/library/base_provider.dart';
import '../common/library/dio_adapter.dart';
import '../common/library/interface.dart';

class LoginDao {
  static Future<CaptchaEntity?> captcha() async {
    var request = Captcha();
    HiNetAdapter adapter = DioAdapter();

    try {
      var result = await adapter.send(request);
      var err = NetTools.CheckError(result.data);
      if (err != null) {
        print(err);
        SmartDialog.showToast(err);
      }

      CaptchaEntity cap = CaptchaEntity.fromJson(result.data);
      return cap;
    } catch (e) {
      print(e);
      SmartDialog.showToast("$e");
    }
    return null;
  }

  static Future<bool?> registry(String captchaID, String captchaCode,
      String account, String publicKey, String encryptedPrivateKey) async {
    BaseRequest request = Registry();
    HiNetAdapter adapter = DioAdapter();

    request = request.setParam({
      "captcha_id": captchaID,
      "captcha_code": captchaCode,
      "account": account,
      "public_key": publicKey,
      "encrypted_private_key": encryptedPrivateKey
    });

    try {
      var result = await adapter.send(request);
      var err = NetTools.CheckError(result.data);
      if (err != null) {
        print(err);
        SmartDialog.showToast(err);
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      SmartDialog.showToast("$e");
    }
    return null;
  }

  static Future<UserInfo?> userInfo(String account) async {
    var c = GetUserInfo();
    c.setPath(account);
    BaseRequest request = c;
    HiNetAdapter adapter = DioAdapter();

    try {
      var result = await adapter.send(request);
      var err = NetTools.CheckError(result.data);
      if (err != null) {
        print(err);
        return null;
      }
      UserInfo cap = UserInfo.fromJson(result.data);
      return cap;
    } catch (e) {
      print(e);
      SmartDialog.showToast("$e");
    }
    return null;
  }

  static Future<LoginResponse?> login(
      String captchaId, String captchaCode, String account, String sign) async {
    BaseRequest request = Login();
    HiNetAdapter adapter = DioAdapter();

    request = request.setParam({
      "captcha_id": captchaId,
      "captcha_code": captchaCode,
      "account": account,
      "sign": sign,
    });

    try {
      var result = await adapter.send(request);
      var err = NetTools.CheckError(result.data);
      if (err != null) {
        print(err);
        SmartDialog.showToast(err);
        return null;
      }
      LoginResponse cap = LoginResponse.fromJson(result.data);
      return cap;
    } catch (e) {
      print(e);
      SmartDialog.showToast("$e");
    }
    return null;
  }
}

class Captcha extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool neeLogin() {
    return false;
  }

  @override
  String path() {
    return "captcha";
  }
}

class Registry extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool neeLogin() {
    return false;
  }

  @override
  String path() {
    return "registry";
  }
}

class Login extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool neeLogin() {
    return false;
  }

  @override
  String path() {
    return "login";
  }
}

class GetUserInfo extends BaseRequest {
  String thisPath = "user_info";

  setPath(String account) {
    thisPath = thisPath + "/$account";
  }

  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool neeLogin() {
    return false;
  }

  @override
  String path() {
    return thisPath;
  }
}
