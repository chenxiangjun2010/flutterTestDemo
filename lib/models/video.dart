part of models;

class VideoModel {
  int? id;
  int? sfid;
  int? projectID;
  String? projectName;
  String? projectNum;
  String? projectOutNum;
  double? projectLng;
  double? projectLat;
  String? deviceID;
  String? deviceName;
  String? deviceUser;
  String? userPhone;
  String? editBy;
  String? editDate;
  bool? isDel;
  String? setting;

  VideoModel({
    this.id,
    this.sfid,
    this.projectID,
    this.projectName,
    this.projectNum,
    this.projectOutNum,
    this.projectLng,
    this.projectLat,
    this.deviceID,
    this.deviceName,
    this.deviceUser,
    this.userPhone,
    this.editBy,
    this.editDate,
    this.isDel,
    this.setting,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json['id'] as int?,
        sfid: json['sfid'] as int?,
        projectID: json['projectID'] as int?,
        projectName: json['projectName'] as String?,
        projectNum: json['projectNum'] as String?,
        projectOutNum: json['projectOutNum'] as String?,
        projectLng: (json['projectLng'] as num?)?.toDouble(),
        projectLat: (json['projectLat'] as num?)?.toDouble(),
        deviceID: json['deviceID'] as String?,
        deviceName: json['deviceName'] as String?,
        deviceUser: json['deviceUser'] as String?,
        userPhone: json['userPhone'] as String?,
        editBy: json['editBy'] as String?,
        editDate: json['editDate'] as String?,
        isDel: json['isDel'] as bool?,
        setting: json['setting'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'sfid': sfid,
        'projectID': projectID,
        'projectName': projectName,
        'projectNum': projectNum,
        'projectOutNum': projectOutNum,
        'projectLng': projectLng,
        'projectLat': projectLat,
        'deviceID': deviceID,
        'deviceName': deviceName,
        'deviceUser': deviceUser,
        'userPhone': userPhone,
        'editBy': editBy,
        'editDate': editDate,
        'isDel': isDel,
        'setting': setting,
      };
}
