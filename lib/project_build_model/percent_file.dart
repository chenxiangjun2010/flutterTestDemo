class PercentFile {
  String? filePath;
  int? id;

  PercentFile({this.filePath, this.id});

  factory PercentFile.fromJson(Map<String, dynamic> json) => PercentFile(
        filePath: json['filePath'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'filePath': filePath,
        'id': id,
      };
}
