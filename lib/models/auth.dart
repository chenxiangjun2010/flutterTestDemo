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
