class CutFile {
  String? filePath;
  int? id;

  CutFile({this.filePath, this.id});

  factory CutFile.fromJson(Map<String, dynamic> json) => CutFile(
        filePath: json['filePath'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'filePath': filePath,
        'id': id,
      };
}
