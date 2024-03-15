part of models;

class ProjectBaseModel {
  int? id;
  String? name;
  String? number;
  String? outNumber;
  int? constructType;
  String? constructTypeName;
  int? unitID;
  String? unitName;
  String? unitContent;
  String? unitPhone;
  int? designerId;
  String? designer;
  String? designContent;
  String? designPhone;
  int? place;
  String? placeName;
  String? address;
  double? budget;
  String? signDate;
  String? createTime;
  int? feedType;
  String? feedTypeName;
  List<dynamic>? contractFiles;
  List<dynamic>? projectFiles;
  List<dynamic>? listFiles;
  String? listText;
  String? dep;
  String? editBy;
  String? editDate;
  int? status;
  String? statusName;
  int? state;
  String? stateName;
  bool? isDel;
  int? projecSFID;
  int? bulidStatus;
  int? auditStatus;

  ProjectBaseModel({
    this.id,
    this.name,
    this.number,
    this.outNumber,
    this.constructType,
    this.constructTypeName,
    this.unitID,
    this.unitName,
    this.unitContent,
    this.unitPhone,
    this.designerId,
    this.designer,
    this.designContent,
    this.designPhone,
    this.place,
    this.placeName,
    this.address,
    this.budget,
    this.signDate,
    this.createTime,
    this.feedType,
    this.feedTypeName,
    this.contractFiles,
    this.projectFiles,
    this.listFiles,
    this.listText,
    this.dep,
    this.editBy,
    this.editDate,
    this.status,
    this.statusName,
    this.state,
    this.stateName,
    this.isDel,
    this.projecSFID,
    this.bulidStatus,
    this.auditStatus,
  });

  factory ProjectBaseModel.fromJson(Map<String, dynamic> json) =>
      ProjectBaseModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        number: json['number'] as String?,
        outNumber: json['outNumber'] as String?,
        constructType: json['constructType'] as int?,
        constructTypeName: json['constructTypeName'] as String?,
        unitID: json['unitID'] as int?,
        unitName: json['unitName'] as String?,
        unitContent: json['unitContent'] as String?,
        unitPhone: json['unitPhone'] as String?,
        designerId: json['designerID'] as int?,
        designer: json['designer'] as String?,
        designContent: json['designContent'] as String?,
        designPhone: json['designPhone'] as String?,
        place: json['place'] as int?,
        placeName: json['placeName'] as String?,
        address: json['address'] as String?,
        budget: json['budget'] as double?,
        signDate: json['signDate'] as String?,
        createTime: json['createTime'] as String?,
        feedType: json['feedType'] as int?,
        feedTypeName: json['feedTypeName'] as String?,
        contractFiles: json['contractFiles'] as List<dynamic>?,
        projectFiles: json['projectFiles'] as List<dynamic>?,
        listFiles: json['listFiles'] as List<dynamic>?,
        listText: json['listText'] as String?,
        dep: json['dep'] as String?,
        editBy: json['editBy'] as String?,
        editDate: json['editDate'] as String?,
        status: json['status'] as int?,
        statusName: json['statusName'] as String?,
        state: json['state'] as int?,
        stateName: json['stateName'] as String?,
        isDel: json['isDel'] as bool?,
        projecSFID: json['projecSFID'] as int?,
        bulidStatus: json['bulidStatus'] as int?,
        auditStatus: json['auditStatus'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'number': number,
        'outNumber': outNumber,
        'constructType': constructType,
        'constructTypeName': constructTypeName,
        'unitID': unitID,
        'unitName': unitName,
        'unitContent': unitContent,
        'unitPhone': unitPhone,
        'designerID': designerId,
        'designer': designer,
        'designContent': designContent,
        'designPhone': designPhone,
        'place': place,
        'placeName': placeName,
        'address': address,
        'budget': budget,
        'signDate': signDate,
        'createTime': createTime,
        'feedType': feedType,
        'feedTypeName': feedTypeName,
        'contractFiles': contractFiles,
        'projectFiles': projectFiles,
        'listFiles': listFiles,
        'listText': listText,
        'dep': dep,
        'editBy': editBy,
        'editDate': editDate,
        'status': status,
        'statusName': statusName,
        'state': state,
        'stateName': stateName,
        'isDel': isDel,
        'projecSFID': projecSFID,
        'bulidStatus': bulidStatus,
        'auditStatus': auditStatus,
      };
}
