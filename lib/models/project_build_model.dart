part of models;

class ProjectBuildDetailModel {
  int? bStatus;
  String? bStatusName;
  List<CommonFile>? constructFiles;
  String? cutEndDate;
  List<CommonFile>? cutFiles;
  String? cutStartDate;
  String? dep;
  String? discloseDate;
  List<CommonFile>? discloseFiles;
  int? duration;
  String? editDate;
  String? endDate;
  List<CommonFile>? endFiles;
  List<CommonFile>? endPicFiles;
  bool? everBound;
  int? id;
  double? lat;
  double? lng;
  double? percent;
  List<CommonFile>? percentFiles;
  List<CommonFile>? pipeFiles;
  String? pipelineDate;
  int? place;
  List<CommonFile>? planFiles;
  int? projecSfid;
  int? projectId;
  String? projectName;
  String? projectNum;
  String? projectOutNum;
  String? startDate;
  List<CommonFile>? startFiles;
  int? state;
  int? status;
  List<VisaList>? visaLists;

  ProjectBuildDetailModel({
    this.bStatus,
    this.bStatusName,
    this.constructFiles,
    this.cutEndDate,
    this.cutFiles,
    this.cutStartDate,
    this.dep,
    this.discloseDate,
    this.discloseFiles,
    this.duration,
    this.editDate,
    this.endDate,
    this.endFiles,
    this.endPicFiles,
    this.everBound,
    this.id,
    this.lat,
    this.lng,
    this.percent,
    this.percentFiles,
    this.pipeFiles,
    this.pipelineDate,
    this.place,
    this.planFiles,
    this.projecSfid,
    this.projectId,
    this.projectName,
    this.projectNum,
    this.projectOutNum,
    this.startDate,
    this.startFiles,
    this.state,
    this.status,
    this.visaLists,
  });

  factory ProjectBuildDetailModel.fromJson(Map<String, dynamic> json) {
    return ProjectBuildDetailModel(
      bStatus: json['bStatus'] as int?,
      bStatusName: json['bStatusName'] as String?,
      constructFiles: (json['constructFiles'] as List<dynamic>?)
          ?.map((e) => CommonFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      cutEndDate: json['cutEndDate'] as String?,
      cutFiles: (json['cutFiles'] as List<dynamic>?)
          ?.map((e) => CommonFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      cutStartDate: json['cutStartDate'] as String?,
      dep: json['dep'] as String?,
      discloseDate: json['discloseDate'] as String?,
      discloseFiles: (json['discloseFiles'] as List<dynamic>?)
          ?.map((e) => CommonFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      duration: json['duration'] as int?,
      editDate: json['editDate'] as String?,
      endDate: json['endDate'] as String?,
      endFiles: (json['endFiles'] as List<dynamic>?)
          ?.map((e) => CommonFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      endPicFiles: (json['endPicFiles'] as List<dynamic>?)
          ?.map((e) => CommonFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      everBound: json['everBound'] as bool?,
      id: json['id'] as int?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      percent: json['percent'] as double?,
      percentFiles: (json['percentFiles'] as List<dynamic>?)
          ?.map((e) => CommonFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      pipeFiles: (json['pipeFiles'] as List<dynamic>?)
          ?.map((e) => CommonFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      pipelineDate: json['pipelineDate'] as String?,
      place: json['place'] as int?,
      planFiles: (json['planFiles'] as List<dynamic>?)
          ?.map((e) => CommonFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      projecSfid: json['projecSFID'] as int?,
      projectId: json['projectID'] as int?,
      projectName: json['projectName'] as String?,
      projectNum: json['projectNum'] as String?,
      projectOutNum: json['projectOutNum'] as String?,
      startDate: json['startDate'] as String?,
      startFiles: (json['startFiles'] as List<dynamic>?)
          ?.map((e) => CommonFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      state: json['state'] as int?,
      status: json['status'] as int?,
      visaLists: (json['visaLists'] as List<dynamic>?)
          ?.map((e) => VisaList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'bStatus': bStatus,
        'bStatusName': bStatusName,
        'constructFiles': constructFiles?.map((e) => e.toJson()).toList(),
        'cutEndDate': cutEndDate,
        'cutFiles': cutFiles?.map((e) => e.toJson()).toList(),
        'cutStartDate': cutStartDate,
        'dep': dep,
        'discloseDate': discloseDate,
        'discloseFiles': discloseFiles?.map((e) => e.toJson()).toList(),
        'duration': duration,
        'editDate': editDate,
        'endDate': endDate,
        'endFiles': endFiles?.map((e) => e.toJson()).toList(),
        'endPicFiles': endPicFiles?.map((e) => e.toJson()).toList(),
        'everBound': everBound,
        'id': id,
        'lat': lat,
        'lng': lng,
        'percent': percent,
        'percentFiles': percentFiles?.map((e) => e.toJson()).toList(),
        'pipeFiles': pipeFiles?.map((e) => e.toJson()).toList(),
        'pipelineDate': pipelineDate,
        'place': place,
        'planFiles': planFiles?.map((e) => e.toJson()).toList(),
        'projecSFID': projecSfid,
        'projectID': projectId,
        'projectName': projectName,
        'projectNum': projectNum,
        'projectOutNum': projectOutNum,
        'startDate': startDate,
        'startFiles': startFiles?.map((e) => e.toJson()).toList(),
        'state': state,
        'status': status,
        'visaLists': visaLists?.map((e) => e.toJson()).toList(),
      };
}

class CommonFile {
  String? bh;
  String? filePath;
  int? id;

  CommonFile({this.filePath, this.id, this.bh});

  factory CommonFile.fromJson(Map<String, dynamic> json) => CommonFile(
        filePath: json['filePath'] as String?,
        bh: json['bh'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'filePath': filePath,
        'id': id,
      };
}

class VisaList {
  String? editDate;
  List<CommonFile>? files;
  int? id;
  String? intro;

  VisaList({this.editDate, this.files, this.id, this.intro});

  factory VisaList.fromJson(Map<String, dynamic> json) => VisaList(
        editDate: json['editDate'] as String?,
        files: (json['files'] as List<dynamic>?)
            ?.map((e) => CommonFile.fromJson(e as Map<String, dynamic>))
            .toList(),
        id: json['id'] as int?,
        intro: json['intro'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'editDate': editDate,
        'files': files?.map((e) => e.toJson()).toList(),
        'id': id,
        'intro': intro,
      };
}
