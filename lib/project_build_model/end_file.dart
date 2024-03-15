class EndFile {
  String? filePath;
  int? id;

  EndFile({this.filePath, this.id});

  factory EndFile.fromJson(Map<String, dynamic> json) => EndFile(
        filePath: json['filePath'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'filePath': filePath,
        'id': id,
      };
}
