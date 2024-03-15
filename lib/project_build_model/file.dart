class File {
  String? filePath;
  int? id;

  File({this.filePath, this.id});

  factory File.fromJson(Map<String, dynamic> json) => File(
        filePath: json['filePath'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'filePath': filePath,
        'id': id,
      };
}
