part of store;

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  bool _isLogin = false;
  bool _isBgUser = false;
  String _token = '';
  AuthModel _info = AuthModel(); //账号信息

  AuthModel get info => _info;
  bool get isLogin => _isLogin;
  bool get isBgUser => _isBgUser;
  String get token => _token;
  bool get hasToken => _token.isNotEmpty;

  @override
  void onInit() {
    _token = StorageService.to.getString(kLocalToken);
    _isBgUser = StorageService.to.getBool(kLocalIsBgUser);

    final result = StorageService.to.getString(kLocalAuth);

    if (result.isNotEmpty) _info = AuthModel.fromString(result);

    super.onInit();
  }

// 设置token
  Future<void> setToken(String value) async {
    await StorageService.to.setString(kLocalToken, value);
    _token = value;
  }

  // 设置个人信息
  // Future<void> setAuth(String value) async {
  //   await StorageService.to.setString(kLocalToken, value);
  //   _token = value;
  // }
  Future<void> setAuth(AuthModel value) async {
    print('setAuth,$value');
    print(jsonEncode(value.toJson()));
    await StorageService.to.setBool(kLocalIsBgUser, value.isBgUser ?? false);
    _isBgUser = value.isBgUser ?? false;
    await StorageService.to.setString(kLocalAuth, jsonEncode(value.toJson()));
    _info = value;
  }

  Future<void> logout() async {
    await StorageService.to.remove(kLocalToken);
    await StorageService.to.remove(kLocalAuth);
    _token = '';
    _isLogin = false;
  }

  Future<void> profile() async {
    if (!hasToken) return;
    _isLogin = true;
    update();
  }
}
