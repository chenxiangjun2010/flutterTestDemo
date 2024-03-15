part of models;

class EnumModel {
  int? id;
  String? name;
  int? enumType;
  int? parent;
  int? value;
  bool? isDefault;
  String? typeName;
  String? editBy;
  String? editDate;
  String? setting;

  EnumModel({
    this.id,
    this.name,
    this.enumType,
    this.parent,
    this.value,
    this.isDefault,
    this.typeName,
    this.editBy,
    this.editDate,
    this.setting,
  });

  factory EnumModel.fromJson(Map<String, dynamic> json) => EnumModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        enumType: json['enumType'] as int?,
        parent: json['parent'] as int?,
        value: json['value'] as int?,
        isDefault: json['isDefault'] as bool?,
        typeName: json['typeName'] as String?,
        editBy: json['editBy'] as String?,
        editDate: json['editDate'] as String?,
        setting: (json['setting'] ?? '') as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'enumType': enumType,
        'parent': parent,
        'value': value,
        'isDefault': isDefault,
        'typeName': typeName,
        'editBy': editBy,
        'editDate': editDate,
        'setting': setting,
      };
}
