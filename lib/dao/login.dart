import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../common/entity/captcha.dart';
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
    }catch (e) {
      print(e);
      SmartDialog.showToast("$e");
    }
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