class DiscloseFile {
  String? filePath;
  int? id;

  DiscloseFile({this.filePath, this.id});

  factory DiscloseFile.fromJson(Map<String, dynamic> json) => DiscloseFile(
        filePath: json['filePath'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'filePath': filePath,
        'id': id,
      };
}
