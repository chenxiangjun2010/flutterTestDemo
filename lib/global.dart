import 'package:get/get.dart';
import 'package:xiaoerban_business/services/index.dart';
import 'package:xiaoerban_business/store/index.dart';

class Global {
  static final Global _instance = Global._internal();

  factory Global() => _instance;

  Global._internal();

  static Future<void> init() async {
    // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    await Future.wait([
      Get.putAsync<StorageService>(() => StorageService().init()),
    ]).whenComplete(() {
      Get.put<HttpService>(HttpService());
      // Get.put<PrinterService>(PrinterService());
      Get.put<ShopStore>(ShopStore());
      Get.put<UserStore>(UserStore());
      Get.put<LabelStore>(LabelStore());
    });
  }
}
