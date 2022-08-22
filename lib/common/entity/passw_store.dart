class PasswdStore {
  List<Logins>? logins;
  List<Cards>? cards;
  List<Identities>? identities;
  List<Notes>? notes;

  List<Logins>? loginsBak;
  List<Cards>? cardsBak;
  List<Identities>? identitiesBak;
  List<Notes>? notesBak;

  PasswdStore(
      {this.logins,
        this.cards,
        this.identities,
        this.notes,
        this.loginsBak,
        this.cardsBak,
        this.identitiesBak,
        this.notesBak});

  PasswdStore.fromJson(Map<String, dynamic> json) {
    if (json['logins'] != null) {
      logins = <Logins>[];
      json['logins'].forEach((v) {
        logins!.add(new Logins.fromJson(v));
      });
    }
    if (json['cards'] != null) {
      cards = <Cards>[];
      json['cards'].forEach((v) {
        cards!.add(new Cards.fromJson(v));
      });
    }
    if (json['identities'] != null) {
      identities = <Identities>[];
      json['identities'].forEach((v) {
        identities!.add(new Identities.fromJson(v));
      });
    }
    if (json['notes'] != null) {
      notes = <Notes>[];
      json['notes'].forEach((v) {
        notes!.add(new Notes.fromJson(v));
      });
    }
    if (json['logins_bak'] != null) {
      loginsBak = <Logins>[];
      json['logins_bak'].forEach((v) {
        loginsBak!.add(new Logins.fromJson(v));
      });
    }
    if (json['cards_bak'] != null) {
      cardsBak = <Cards>[];
      json['cards_bak'].forEach((v) {
        cardsBak!.add(new Cards.fromJson(v));
      });
    }
    if (json['identities_bak'] != null) {
      identitiesBak = <Identities>[];
      json['identities_bak'].forEach((v) {
        identitiesBak!.add(new Identities.fromJson(v));
      });
    }
    if (json['notes_bak'] != null) {
      notesBak = <Notes>[];
      json['notes_bak'].forEach((v) {
        notesBak!.add(new Notes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.logins != null) {
      data['logins'] = this.logins!.map((v) => v.toJson()).toList();
    }
    if (this.cards != null) {
      data['cards'] = this.cards!.map((v) => v.toJson()).toList();
    }
    if (this.identities != null) {
      data['identities'] = this.identities!.map((v) => v.toJson()).toList();
    }
    if (this.notes != null) {
      data['notes'] = this.notes!.map((v) => v.toJson()).toList();
    }
    if (this.loginsBak != null) {
      data['logins_bak'] = this.loginsBak!.map((v) => v.toJson()).toList();
    }
    if (this.cardsBak != null) {
      data['cards_bak'] = this.cardsBak!.map((v) => v.toJson()).toList();
    }
    if (this.identitiesBak != null) {
      data['identities_bak'] =
          this.identitiesBak!.map((v) => v.toJson()).toList();
    }
    if (this.notesBak != null) {
      data['notes_bak'] = this.notesBak!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Logins {
  String? type;
  String? id;
  String? name;
  String? account;
  String? password;
  String? remark;
  String? url;
  List<String>? img;

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
    img = json['img'].cast<String>();
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
  List<String>? img;

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
    img = json['img'].cast<String>();
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
  List<String>? img;

  Identities(
      {this.type, this.id, this.name, this.address, this.remark, this.img});

  Identities.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    name = json['name'];
    address = json['address'];
    remark = json['remark'];
    img = json['img'].cast<String>();
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
  List<String>? img;

  Notes({this.type, this.id, this.name, this.remark, this.img});

  Notes.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    name = json['name'];
    remark = json['remark'];
    img = json['img'].cast<String>();
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
