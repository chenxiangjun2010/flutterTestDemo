part of models;

class DeviceModel {
  final String id;
  final String name;

  const DeviceModel({
    required this.id,
    required this.name,
  });

  static DeviceModel fromStr(String str) {
    try {
      final json = jsonDecode(str);
      return DeviceModel(
        id: json['id'],
        name: json['name'],
      );
    } catch (error) {
      return const DeviceModel(id: '', name: '');
    }
  }

  @override
  String toString() {
    return jsonEncode({
      'id': id,
      'name': name,
    });
  }

  @override
  bool operator ==(Object other) {
    return other is DeviceModel &&
        other.runtimeType == runtimeType &&
        other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
