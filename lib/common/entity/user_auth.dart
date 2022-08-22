class UserRegistry {
  String? captchaId;
  String? captchaCode;
  String? account;
  String? name;
  String? publicKey;
  String? encryptedPrivateKey;

  UserRegistry(
      {this.captchaId,
        this.captchaCode,
        this.account,
        this.name,
        this.publicKey,
        this.encryptedPrivateKey});

  UserRegistry.fromJson(Map<String, dynamic> json) {
    captchaId = json['captcha_id'];
    captchaCode = json['captcha_code'];
    account = json['account'];
    name = json['name'];
    publicKey = json['public_key'];
    encryptedPrivateKey = json['encrypted_private_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['captcha_id'] = this.captchaId;
    data['captcha_code'] = this.captchaCode;
    data['account'] = this.account;
    data['name'] = this.name;
    data['public_key'] = this.publicKey;
    data['encrypted_private_key'] = this.encryptedPrivateKey;
    return data;
  }
}

class UserLogin {
  String? captchaId;
  String? captchaCode;
  String? account;
  String? sign;

  UserLogin({this.captchaId, this.captchaCode, this.account, this.sign});

  UserLogin.fromJson(Map<String, dynamic> json) {
    captchaId = json['captcha_id'];
    captchaCode = json['captcha_code'];
    account = json['account'];
    sign = json['sign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['captcha_id'] = this.captchaId;
    data['captcha_code'] = this.captchaCode;
    data['account'] = this.account;
    data['sign'] = this.sign;
    return data;
  }
}

class UserInfo {
  String? requestId;
  String? code;
  UserInfoData? data;

  UserInfo({this.requestId, this.code, this.data});

  UserInfo.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    code = json['code'];
    data = json['data'] != null ? new UserInfoData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.requestId;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserInfoData {
  String? encryptedPrivateKey;
  String? publicKey;

  UserInfoData({this.encryptedPrivateKey, this.publicKey});

  UserInfoData.fromJson(Map<String, dynamic> json) {
    encryptedPrivateKey = json['encrypted_private_key'];
    publicKey = json['public_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encrypted_private_key'] = this.encryptedPrivateKey;
    data['public_key'] = this.publicKey;
    return data;
  }
}

class AuthExpiration {
  int? expiration;

  AuthExpiration({this.expiration});

  AuthExpiration.fromJson(Map<String, dynamic> json) {
    expiration = json['expiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expiration'] = this.expiration;
    return data;
  }
}

class LoginResponse {
  String? requestId;
  String? code;
  LoginResponseData? data;

  LoginResponse({this.requestId, this.code, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    code = json['code'];
    data = json['data'] != null ? new LoginResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.requestId;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LoginResponseData {
  String? jwt;

  LoginResponseData({this.jwt});

  LoginResponseData.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwt'] = this.jwt;
    return data;
  }
}

