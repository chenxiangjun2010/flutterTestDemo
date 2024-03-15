part of models;

class FunctionModel {
  String? name;
  int? id;
  int? projectID;

  FunctionModel({this.name, this.id, this.projectID});

  factory FunctionModel.fromJson(Map<String, dynamic> json) => FunctionModel(
        name: json['name'] as String?,
        id: json['id'] as int?,
        projectID: json['projectID'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'projectID': projectID,
      };
}

class ProjectBuildModel {
  int? id;
  int? projectID;
  String? projectName;
  String? projectNum;
  String? projectOutNum;
  String? discloseDate;
  String? pipelineDate;
  int? duration;
  String? startDate;
  double? percent;
  String? endDate;
  String? cutStartDate;
  String? cutEndDate;
  double? lng;
  double? lat;
  int? bStatus;
  String? bStatusName;
  String? bStateName;
  String? dep;
  String? editDate;
  int? place;
  String? placeName;
  int? status;
  String? statusName;
  int? state;
  String? stateName;
  int? projecSFID;
  String? deviceID;
  bool? everBound;
  String? setting;
  List<FunctionModel>? functions;

  ProjectBuildModel({
    this.id,
    this.projectID,
    this.projectName,
    this.projectNum,
    this.projectOutNum,
    this.discloseDate,
    this.pipelineDate,
    this.duration,
    this.startDate,
    this.percent,
    this.endDate,
    this.cutStartDate,
    this.cutEndDate,
    this.lng,
    this.lat,
    this.bStatus,
    this.bStatusName,
    this.bStateName,
    this.dep,
    this.editDate,
    this.place,
    this.placeName,
    this.status,
    this.statusName,
    this.state,
    this.stateName,
    this.projecSFID,
    this.deviceID,
    this.everBound,
    this.setting,
    this.functions,
  });

  factory ProjectBuildModel.fromJson(Map<String, dynamic> json) {
    return ProjectBuildModel(
      id: json['id'] as int?,
      projectID: json['projectID'] as int?,
      projectName: json['projectName'] as String?,
      projectNum: json['projectNum'] as String?,
      projectOutNum: json['projectOutNum'] as String?,
      discloseDate: json['discloseDate'] as String?,
      pipelineDate: json['pipelineDate'] as String?,
      duration: json['duration'] as int?,
      startDate: json['startDate'] as String?,
      percent: (json['percent'] as num?)?.toDouble(),
      endDate: json['endDate'] as String?,
      cutStartDate: json['cutStartDate'] as String?,
      cutEndDate: json['cutEndDate'] as String?,
      lng: (json['lng'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
      bStatus: json['bStatus'] as int?,
      bStatusName: json['bStatusName'] as String?,
      bStateName: json['bStateName'] as String?,
      dep: json['dep'] as String?,
      editDate: json['editDate'] as String?,
      place: json['place'] as int?,
      placeName: json['placeName'] as String?,
      status: json['status'] as int?,
      statusName: json['statusName'] as String?,
      state: json['state'] as int?,
      stateName: json['stateName'] as String?,
      projecSFID: json['projecSFID'] as int?,
      deviceID: json['deviceID'] as String?,
      everBound: json['everBound'] as bool?,
      setting: json['setting'] as String?,
      functions: (json['functions'] as List<dynamic>?)
          ?.map((e) => FunctionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'projectID': projectID,
        'projectName': projectName,
        'projectNum': projectNum,
        'projectOutNum': projectOutNum,
        'discloseDate': discloseDate,
        'pipelineDate': pipelineDate,
        'duration': duration,
        'startDate': startDate,
        'percent': percent,
        'endDate': endDate,
        'cutStartDate': cutStartDate,
        'cutEndDate': cutEndDate,
        'lng': lng,
        'lat': lat,
        'bStatus': bStatus,
        'bStatusName': bStatusName,
        'bStateName': bStateName,
        'dep': dep,
        'editDate': editDate,
        'place': place,
        'placeName': placeName,
        'status': status,
        'statusName': statusName,
        'state': state,
        'stateName': stateName,
        'projecSFID': projecSFID,
        'deviceID': deviceID,
        'everBound': everBound,
        'setting': setting,
        'functions': functions?.map((e) => e.toJson()).toList(),
      };
}

// 施工状态
class ProjectBuildStatusModel {
  String? name;
  int? id;

  ProjectBuildStatusModel({this.name, this.id});

  factory ProjectBuildStatusModel.fromJson(Map<String, dynamic> json) =>
      ProjectBuildStatusModel(
        name: json['name'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
      };
}
