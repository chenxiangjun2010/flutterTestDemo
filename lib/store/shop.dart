part of store;

class ShopStore extends GetxController {
  static ShopStore get to => Get.find();

  MerchantModel _info = MerchantModel();

  final SettingsModel _settings = SettingsModel();

  MerchantModel get info => _info;

  SettingsModel get settings => _settings;

  @override
  void onInit() {
    final result = StorageService.to.getString(kLocalShop);
    // if (result.isNotEmpty) _info = MerchantModel.fromString(result);
    super.onInit();
  }

  Future<void> setInfo(MerchantModel value) async {
    await StorageService.to.setString(kLocalShop, jsonEncode(value.toJson()));
    _info = value;
  }

  Future<void> initSettings() async {
    if (!UserStore.to.hasToken) return;
    // _settings = await ShopAPI.settings();
  }
}
