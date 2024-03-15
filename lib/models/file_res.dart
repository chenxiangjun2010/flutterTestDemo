part of models;

class FileAllCommonModel {
  int? id;
  String? bh;
  String? filePath;

  FileAllCommonModel({this.id, this.bh, this.filePath});

  factory FileAllCommonModel.fromJson(Map<String, dynamic> json) =>
      FileAllCommonModel(
        id: json['id'] as int?,
        bh: json['bh'] as String?,
        filePath: json['filePath'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'bh': bh,
        'filePath': filePath,
      };
}
