class PlanFile {
  String? filePath;
  int? id;

  PlanFile({this.filePath, this.id});

  factory PlanFile.fromJson(Map<String, dynamic> json) => PlanFile(
        filePath: json['filePath'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'filePath': filePath,
        'id': id,
      };
}
