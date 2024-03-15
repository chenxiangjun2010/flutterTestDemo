class EndPicFile {
  String? filePath;
  int? id;

  EndPicFile({this.filePath, this.id});

  factory EndPicFile.fromJson(Map<String, dynamic> json) => EndPicFile(
        filePath: json['filePath'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'filePath': filePath,
        'id': id,
      };
}
