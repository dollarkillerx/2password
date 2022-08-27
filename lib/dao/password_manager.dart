import 'dart:convert';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../common/entity/passw_store.dart';
import '../common/library/base_provider.dart';
import '../common/library/dio_adapter.dart';
import '../common/library/interface.dart';
import '../common/storage/user.dart';
import '../common/utils/strings.dart';
import 'package:encrypt/encrypt.dart' as encrypt; // 加密

class PasswordManager {
  static Future<PasswordAllInfoEntity?> AllInfo() async {
    var c = PasswordAllInfo();
    HiNetAdapter adapter = DioAdapter();

    try {
      var result = await adapter.send(c);
      var err = NetTools.CheckError(result.data);
      if (err != null) {
        print(err);
        SmartDialog.showToast("$err");
        return null;
      }

      PasswordAllInfoEntity cap = PasswordAllInfoEntity.fromJson(result.data);
      return cap;
    } catch (e) {
      print(e);
      SmartDialog.showToast("$e");
    }
    return null;
  }
}

class PasswordAllInfo extends BaseRequest {
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
    return "internal/password/all_info";
  }
}

class PasswordInfo extends BaseRequest {
  var basePath = "internal/password/info";

  PasswordInfo setUrl(String id) {
    basePath += "/$id";
    return this;
  }

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
    return basePath;
  }
}

class AddPasswordInfo extends BaseRequest {
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
    return "internal/password/add";
  }
}

class DeletePasswordInfo extends BaseRequest {
  var basePath = "internal/password/delete";

  DeletePasswordInfo setUrl(String id) {
    basePath += "/$id";
    return this;
  }

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
    return basePath;
  }
}

class UpdatePasswordInfo extends BaseRequest {
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
    return "internal/password/update";
  }
}
