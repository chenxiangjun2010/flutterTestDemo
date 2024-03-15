import 'file.dart';

class VisaList {
  String? editDate;
  List<File>? files;
  int? id;
  String? intro;

  VisaList({this.editDate, this.files, this.id, this.intro});

  factory VisaList.fromJson(Map<String, dynamic> json) => VisaList(
        editDate: json['editDate'] as String?,
        files: (json['files'] as List<dynamic>?)
            ?.map((e) => File.fromJson(e as Map<String, dynamic>))
            .toList(),
        id: json['id'] as int?,
        intro: json['intro'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'editDate': editDate,
        'files': files?.map((e) => e.toJson()).toList(),
        'id': id,
        'intro': intro,
      };
}
