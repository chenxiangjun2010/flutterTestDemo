part of utils;

abstract class Access {
  static Future<bool> photos() async {
    if (Platform.isIOS) {
      final result = await [Permission.photos].request();
      return result[Permission.photos] == PermissionStatus.granted ||
          result[Permission.photos] == PermissionStatus.limited;
    }
    if (Platform.isAndroid) {
      final result = await [Permission.storage, Permission.photos].request();
      return result[Permission.storage] == PermissionStatus.granted ||
          result[Permission.photos] == PermissionStatus.granted;
    }
    return false;
  }

  static Future<bool> bluetooth() async {
    if (Platform.isIOS) {
      final result = await [Permission.bluetooth].request();
      return result[Permission.bluetooth] == PermissionStatus.granted;
    }
    if (Platform.isAndroid) {
      final result = await [
        Permission.bluetooth,
        Permission.bluetoothAdvertise,
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.location,
      ].request();
      return result[Permission.bluetoothAdvertise] ==
              PermissionStatus.granted &&
          result[Permission.location] == PermissionStatus.granted &&
          result[Permission.bluetoothScan] == PermissionStatus.granted &&
          result[Permission.bluetoothConnect] == PermissionStatus.granted &&
          result[Permission.bluetooth] == PermissionStatus.granted;
    }
    return false;
  }

  static Future<void> setting() async => await openAppSettings();
}
