part of models;

class ProjectModel {
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
  int? designerID;
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
  String? listText;
  String? dep;
  String? editBy;
  String? editDate;
  int? status;
  String? statusName;
  int? state;
  String? stateName;
  bool? isDel;
  String? setting;
  int? projecSFID;
  int? bulidStatus;
  int? auditStatus;

  ProjectModel({
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
    this.designerID,
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
    this.listText,
    this.dep,
    this.editBy,
    this.editDate,
    this.status,
    this.statusName,
    this.state,
    this.stateName,
    this.isDel,
    this.setting,
    this.projecSFID,
    this.bulidStatus,
    this.auditStatus,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
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
        designerID: json['designerID'] as int?,
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
        listText: json['listText'] as String?,
        dep: json['dep'] as String?,
        editBy: json['editBy'] as String?,
        editDate: json['editDate'] as String?,
        status: json['status'] as int?,
        statusName: json['statusName'] as String?,
        state: json['state'] as int?,
        stateName: json['stateName'] as String?,
        isDel: json['isDel'] as bool?,
        setting: json['setting'] as String?,
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
        'designerID': designerID,
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
        'listText': listText,
        'dep': dep,
        'editBy': editBy,
        'editDate': editDate,
        'status': status,
        'statusName': statusName,
        'state': state,
        'stateName': stateName,
        'isDel': isDel,
        'setting': setting,
        'projecSFID': projecSFID,
        'bulidStatus': bulidStatus,
        'auditStatus': auditStatus,
      };
}
