part of models;

class VideoLogModel {
  int? id;
  int? videoDeviceSFID;
  String? deviceID;
  int? projectID;
  String? projectName;
  String? projectNum;
  String? projectOutNum;

  String? deviceName;
  String? deviceUser;

  String? title;
  String? user;
  bool? isBind;
  String? postTime;

  VideoLogModel({
    this.id,
    this.videoDeviceSFID,
    this.projectID,
    this.projectName,
    this.projectNum,
    this.projectOutNum,
    this.deviceID,
    this.deviceName,
    this.deviceUser,
    this.title,
    this.user,
    this.isBind,
    this.postTime,
  });

  factory VideoLogModel.fromJson(Map<String, dynamic> json) => VideoLogModel(
        id: json['id'] as int?,
        videoDeviceSFID: json['videoDeviceSFID'] as int?,
        projectID: json['projectID'] as int?,
        projectName: json['projectName'] as String?,
        projectNum: json['projectNum'] as String?,
        projectOutNum: json['projectOutNum'] as String?,
        deviceID: json['deviceID'] as String?,
        deviceName: json['deviceName'] as String?,
        deviceUser: json['deviceUser'] as String?,
        title: json['title'] as String?,
        user: json['user'] as String?,
        isBind: json['isBind'] as bool?,
        postTime: json['postTime'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'videoDeviceSFID': videoDeviceSFID,
        'projectID': projectID,
        'projectName': projectName,
        'projectNum': projectNum,
        'projectOutNum': projectOutNum,
        'deviceID': deviceID,
        'deviceName': deviceName,
        'deviceUser': deviceUser,
        'title': title,
        'user': user,
        'isBind': isBind,
        'postTime': postTime,
      };
}
