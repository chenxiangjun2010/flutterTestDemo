part of apis;

abstract class AccountAPI {
  static Future<MerchantModel> login({
    required String phone,
    required String password,
    // required String role,
  }) async {
    final result = await HttpService.to.post(
      '/api/User/Login',
      excludeToken: true,
      showLoading: true,
      params: {'name': phone, 'password': password},
    );
    // final result = await HttpService.to.post(
    //   '/login',
    //   excludeToken: true,
    //   showLoading: true,
    //   params: {
    //     'userName': phone,
    //     'password': password,
    //     'userType': role,
    //   },
    // );
    print('result1,$result');
    if (result.data is! Map) return MerchantModel();
    return MerchantModel.fromJson(result.data);
  }
}
