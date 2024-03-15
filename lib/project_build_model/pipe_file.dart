class PipeFile {
  String? filePath;
  int? id;

  PipeFile({this.filePath, this.id});

  factory PipeFile.fromJson(Map<String, dynamic> json) => PipeFile(
        filePath: json['filePath'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'filePath': filePath,
        'id': id,
      };
}
