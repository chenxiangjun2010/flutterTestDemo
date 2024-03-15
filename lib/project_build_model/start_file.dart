class StartFile {
  String? filePath;
  int? id;

  StartFile({this.filePath, this.id});

  factory StartFile.fromJson(Map<String, dynamic> json) => StartFile(
        filePath: json['filePath'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'filePath': filePath,
        'id': id,
      };
}
