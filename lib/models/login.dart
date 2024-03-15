part of models;

class AuthModel {
  AuthModel({
    this.name,
    this.area,
    this.isBgUser,
  });

  AuthModel.fromJson(dynamic json) {
    name = json['name']?.toString();
    area = json['area'];
    isBgUser = json['isBgUser'];
  }
  AuthModel.fromString(String str) {
    final json = jsonDecode(str);
    // print(bool.tryParse(json(isBgUser)));
    print('jso2n,$json');

    // id = json['merchantId']?.toString();
    name = json['name']?.toString();
    isBgUser = json['isBgUser'] ?? false;
    print('isBgUser,$isBgUser');

    area = int.tryParse(json['area'].toString());
  }
  String? name;
  int? area;
  bool? isBgUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['area'] = area;
    map['isBgUser'] = isBgUser;
    return map;
  }
}

class MerchantModel {
  MerchantModel({this.id, this.token, this.auth});
  MerchantModel.fromJson(dynamic json) {
    token = json['token']?.toString();
    auth = json['auth'] == null
        ? null
        : AuthModel.fromJson(json['auth'] as Map<String, dynamic>);
  }

  String? id;
  String? token;
  AuthModel? auth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['auth'] = auth?.toJson();
    return map;
  }
}
