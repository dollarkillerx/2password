import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../common/entity/passw_store.dart';
import '../common/library/base_provider.dart';
import '../common/library/dio_adapter.dart';
import '../common/library/interface.dart';

class EncryptionStore {
  static Future<PasswdStore?> GET() async {
    var request = CaptchaGET();
    HiNetAdapter adapter = DioAdapter();

    try {
      var result = await adapter.send(request);
      var err = NetTools.CheckError(result.data);
      if (err != null) {
        print(err);
        SmartDialog.showToast(err);
      }

      PasswdStore cap = PasswdStore.fromJson(result.data);
      return cap;
    } catch (e) {
      print(e);
      SmartDialog.showToast("$e");
    }
    return null;
  }

  static Future<PasswdStore?> Add() async {
    var request = CaptchaGET();
    HiNetAdapter adapter = DioAdapter();

    try {
      var result = await adapter.send(request);
      var err = NetTools.CheckError(result.data);
      if (err != null) {
        print(err);
        SmartDialog.showToast(err);
      }

      PasswdStore cap = PasswdStore.fromJson(result.data);
      return cap;
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