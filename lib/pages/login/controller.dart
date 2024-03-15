part of pages.login;

class LoginController extends GetxController {
  final TextEditingController phoneInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();

  @override
  void onInit() {
    // final phone = StorageService.to.getString(kLocalAccount);
    // final password = StorageService.to.getString(kLocalPassword);
    // phoneInput.text = phone;
    // passwordInput.text = password;
    // // /// 测试账号
    // if ((phone.isEmpty || password.isEmpty) && kDebugMode) {
    //   phoneInput.text = '199430000641';
    //   passwordInput.text = 'abc112233';
    // }
    phoneInput.text = 'admin';
    passwordInput.text = '123456';

    // phoneInput.text = '19943000064';
    // passwordInput.text = 'abc112233';
    AuthModel auth =
        AuthModel.fromJson({"isBgUser": true, "name": '123', "area": 0});

    print(auth.toJson());

    super.onInit();
  }

  @override
  void onClose() {
    phoneInput.dispose();
    passwordInput.dispose();
    super.onClose();
  }

  void submit(BuildContext context) async {
    final phone = phoneInput.value.text;
    final password = passwordInput.value.text;
    // final result = await AccountAPI.login(
    //   phone: phone,
    //   password: Tools.generateMD5(password),
    //   role: '1',
    // );
    final result = await AccountAPI.login(phone: phone, password: password);

    if ((result.token ?? '').isEmpty) return;
    StorageService.to.setString(kLocalAccount, phone);
    StorageService.to.setString(kLocalPassword, password);
    await Future.wait([
      UserStore.to.setToken(result.token!),
      UserStore.to.setAuth(result.auth!),
      // ShopStore.to.setInfo(result.auth),
    ]);
    await Future.wait([
      UserStore.to.profile(),
      // ShopStore.to.initSettings(),
    ]);

    if (!context.mounted) return;
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(Routes.main);
    }
  }
}
