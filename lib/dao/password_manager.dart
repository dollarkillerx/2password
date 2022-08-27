import 'dart:convert';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:password2/common/utils/encrypt.dart';
import '../common/entity/passw_store.dart';
import '../common/library/base_provider.dart';
import '../common/library/dio_adapter.dart';
import '../common/library/interface.dart';

class PasswordManager {
  static Future<PasswordAllInfoEntity?> AllInfo() async {
    var c = PasswordAllInfo();
    HiNetAdapter adapter = DioAdapter();

    try {
      var result = await adapter.send(c);
      var err = NetTools.CheckError(result.data);
      if (err != null) {
        // SmartDialog.showToast("$err");
        return null;
      }

      PasswordAllInfoEntity cap = PasswordAllInfoEntity.fromJson(result.data);
      return cap;
    } catch (e) {
      // print(e);
      // SmartDialog.showToast("$e");
    }
    return null;
  }

  static Future<bool?> AddPassword(String type,Object payload) async {
    var c = AddPasswordInfo();
    HiNetAdapter adapter = DioAdapter();

    var pay = jsonEncode(payload);

    String? payloadStr = await Encrypt.AESEncryption(pay);
    if (payloadStr == null) {
      return null;
    }
    c.setParam(PasswdAdd(type: type, payload: payloadStr).toJson());

    try {
      var result = await adapter.send(c);
      var err = NetTools.CheckError(result.data);
      if (err != null) {
        print(err);
        SmartDialog.showToast("$err");
        return null;
      }

      return true;
    } catch (e) {
      print(e);
      SmartDialog.showToast("$e");
    }
    return null;
  }

  static Future<PasswdListAllEntity?> PasswdList(String type) async {
    var c = PasswordList();
    HiNetAdapter adapter = DioAdapter();
    c.query("type", type);

    try {
      var result = await adapter.send(c);
      var err = NetTools.CheckError(result.data);
      if (err != null) {
        print(err);
        SmartDialog.showToast("$err");
        return null;
      }

      PasswdListEntity cap = PasswdListEntity.fromJson(result.data);

      PasswdListAllEntity passwdListEntity = PasswdListAllEntity();

      for (var i = 0;i< cap.data!.length;i++) {
        var rc = await Encrypt.AESDecrypt(cap.data![i].payload!);
        if (rc == null) {
          continue;
        }
        var pdata = jsonDecode(rc);
        switch (cap.data![i].type!) {
          case "login":
            var k = Logins.fromJson(pdata);
            k.id = cap.data![i].id;
            k.createTime = cap.data![i].createdAt;
            passwdListEntity.logins.add(k);
            break;
        }
      }


      return passwdListEntity;
    } catch (e) {
      print(e);
      SmartDialog.showToast("$e");
    }
    return null;
  }

  static Future<ItemDataEntity?> PasswordInfo(String id) async {
    var c = PasswordInfoReq();
    c = c.setID(id);
    HiNetAdapter adapter = DioAdapter();

    try {
      var result = await adapter.send(c);
      var err = NetTools.CheckError(result.data);
      if (err != null) {
        print(err);
        SmartDialog.showToast("$err");
        return null;
      }

      var item = ItemDataEntity();
      PasswdInfoEntity cap = PasswdInfoEntity.fromJson(result.data);
      var rc = await Encrypt.AESDecrypt(cap.data!.payload!);
      if (rc == null) {
        print(err);
        SmartDialog.showToast("$err");
        return null;
      }
      var pdata = jsonDecode(rc);
      switch (cap.data!.type) {
        case "login":
          var k = Logins.fromJson(pdata);
          k.createTime = cap.data!.createdAt;
          item.logins = k;
          break;
      }

      return item;
    } catch (e) {
      print(e);
      SmartDialog.showToast("$e");
    }
    return null;
  }

  static Future<bool?> DeletePwd(String id) async {
    var c = DeletePasswordInfo();
    HiNetAdapter adapter = DioAdapter();
    c = c.setUrl(id);

    try {
      var result = await adapter.send(c);
      var err = NetTools.CheckError(result.data);
      if (err != null) {
        print(err);
        SmartDialog.showToast("$err");
        return null;
      }

      return true;
    } catch (e) {
      print(e);
      SmartDialog.showToast("$e");
    }
    return null;
  }

  static Future<bool?> UpdatePwd(String id, Object payload) async {
    var c = UpdatePassword();
    HiNetAdapter adapter = DioAdapter();

    var pay = jsonEncode(payload);

    String? payloadStr = await Encrypt.AESEncryption(pay);
    if (payloadStr == null) {
      return null;
    }
    c.setParam(PasswdUpdate(id: id, payload: payloadStr).toJson());

    try {
      var result = await adapter.send(c);
      var err = NetTools.CheckError(result.data);
      if (err != null) {
        print(err);
        SmartDialog.showToast("$err");
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

class PasswordInfoReq extends BaseRequest {
  var basePath = "internal/password/info";

  PasswordInfoReq setID(String id) {
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

class PasswordList extends BaseRequest {
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
    return "internal/password/list";
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

class UpdatePassword extends BaseRequest {
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
