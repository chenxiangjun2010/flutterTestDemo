class Auth {
  String? name;
  int? area;

  Auth({this.name, this.area});

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        name: json['name'] as String?,
        area: json['area'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'area': area,
      };
}
