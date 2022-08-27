class PasswdListAllEntity {
  List<Logins> logins = [];
  List<Cards> cards = [];
  List<Identities> identities = [];
  List<Notes> notes = [];
}

class ItemDataEntity {
  String type = "";
  Logins logins = Logins();
  Cards cards = Cards();
  Identities identities = Identities();
  Notes notes = Notes();
}

class Logins {
  String? type;
  String? id;
  String? name;
  String? account;
  String? password;
  String? remark;
  String? url;
  String? createTime;
  List<String?>? img;

  Logins(
      {this.type,
      this.id,
      this.name,
      this.account,
      this.password,
      this.remark,
      this.url,
      this.img});

  Logins.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    name = json['name'];
    account = json['account'];
    password = json['password'];
    remark = json['remark'];
    url = json['url'];

    if (json['img'] != null) {
      img = json['img'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['name'] = this.name;
    data['account'] = this.account;
    data['password'] = this.password;
    data['remark'] = this.remark;
    data['url'] = this.url;
    data['img'] = this.img;
    return data;
  }
}

class Cards {
  String? type;
  String? id;
  String? name;
  String? holder;
  String? number;
  String? brand;
  String? expireDate;
  String? ccv;
  String? remark;
  List<String?>? img;

  Cards(
      {this.type,
      this.id,
      this.name,
      this.holder,
      this.number,
      this.brand,
      this.expireDate,
      this.ccv,
      this.remark,
      this.img});

  Cards.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    name = json['name'];
    holder = json['holder'];
    number = json['number'];
    brand = json['brand'];
    expireDate = json['expire_date'];
    ccv = json['ccv'];
    remark = json['remark'];
    if (json['img'] != null) {
      img = json['img'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['name'] = this.name;
    data['holder'] = this.holder;
    data['number'] = this.number;
    data['brand'] = this.brand;
    data['expire_date'] = this.expireDate;
    data['ccv'] = this.ccv;
    data['remark'] = this.remark;
    data['img'] = this.img;
    return data;
  }
}

class Identities {
  String? type;
  String? id;
  String? name;
  String? address;
  String? remark;
  List<String?>? img;

  Identities(
      {this.type, this.id, this.name, this.address, this.remark, this.img});

  Identities.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    name = json['name'];
    address = json['address'];
    remark = json['remark'];
    if (json['img'] != null) {
      img = json['img'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['remark'] = this.remark;
    data['img'] = this.img;
    return data;
  }
}

class Notes {
  String? type;
  String? id;
  String? name;
  String? remark;
  List<String?>? img;

  Notes({this.type, this.id, this.name, this.remark, this.img});

  Notes.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    name = json['name'];
    remark = json['remark'];
    if (json['img'] != null) {
      img = json['img'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['name'] = this.name;
    data['remark'] = this.remark;
    data['img'] = this.img;
    return data;
  }
}

class PasswordAllInfoEntity {
  String? requestId;
  String? code;
  PasswordAllInfoData? data;

  PasswordAllInfoEntity({this.requestId, this.code, this.data});

  PasswordAllInfoEntity.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    code = json['code'];
    data = json['data'] != null
        ? new PasswordAllInfoData.fromJson(json['data'])
        : null;
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

class PasswordAllInfoData {
  int? loginTypeCount;
  int? cardCount;
  int? identityTypeCount;
  int? noteTypeCount;

  PasswordAllInfoData(
      {this.loginTypeCount,
      this.cardCount,
      this.identityTypeCount,
      this.noteTypeCount});

  PasswordAllInfoData.fromJson(Map<String, dynamic> json) {
    loginTypeCount = json['login_type_count'];
    cardCount = json['card_count'];
    identityTypeCount = json['identity_type_count'];
    noteTypeCount = json['note_type_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login_type_count'] = this.loginTypeCount;
    data['card_count'] = this.cardCount;
    data['identity_type_count'] = this.identityTypeCount;
    data['note_type_count'] = this.noteTypeCount;
    return data;
  }
}

class PasswdAdd {
  String? type;
  String? payload;

  PasswdAdd({this.type, this.payload});

  PasswdAdd.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    payload = json['payload'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['payload'] = this.payload;
    return data;
  }
}

class PasswdListEntity {
  String? requestId;
  String? code;
  List<PasswdListData>? data;

  PasswdListEntity({this.requestId, this.code, this.data});

  PasswdListEntity.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    code = json['code'];
    if (json['data'] != null) {
      data = <PasswdListData>[];
      json['data'].forEach((v) {
        data!.add(new PasswdListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.requestId;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PasswdListData {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? account;
  String? type;
  String? payload;

  PasswdListData(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.account,
      this.type,
      this.payload});

  PasswdListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    account = json['account'];
    type = json['type'];
    payload = json['payload'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['account'] = this.account;
    data['type'] = this.type;
    data['payload'] = this.payload;
    return data;
  }
}

class PasswdInfoEntity {
  String? requestId;
  String? code;
  PasswdInfoEntityData? data;

  PasswdInfoEntity({this.requestId, this.code, this.data});

  PasswdInfoEntity.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    code = json['code'];
    data = json['data'] != null ? new PasswdInfoEntityData.fromJson(json['data']) : null;
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

class PasswdInfoEntityData {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? account;
  String? type;
  String? payload;

  PasswdInfoEntityData(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.account,
        this.type,
        this.payload});

  PasswdInfoEntityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    account = json['account'];
    type = json['type'];
    payload = json['payload'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['account'] = this.account;
    data['type'] = this.type;
    data['payload'] = this.payload;
    return data;
  }
}
