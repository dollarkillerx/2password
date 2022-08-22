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
