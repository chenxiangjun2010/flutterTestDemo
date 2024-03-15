class ConstructFile {
  String? filePath;
  int? id;

  ConstructFile({this.filePath, this.id});

  factory ConstructFile.fromJson(Map<String, dynamic> json) => ConstructFile(
        filePath: json['filePath'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'filePath': filePath,
        'id': id,
      };
}
