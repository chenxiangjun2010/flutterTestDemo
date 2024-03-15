part of apis;

abstract class ShopAPI {
  static Future<TodaySaleModel> todaySale() async {
    final result = await HttpService.to.get('/submit/workbench');
    if (result.data is! Map) return TodaySaleModel();
    return TodaySaleModel.fromJson(result.data);
  }

  static Future<StatisticsModel> statistics({
    required String merchantID,
    required String startTime,
    required String endTime,
  }) async {
    final result = await HttpService.to.post(
      '/statistics/summary/query',
      params: {
        'merchantId': merchantID,
        'startTime': startTime,
        'endTime': endTime,
      },
    );
    if (result.data is! Map) return StatisticsModel();
    return StatisticsModel.fromJson(result.data);
  }

  static Future<SettingsModel> settings() async {
    final result = await HttpService.to.get('/system/settings/listV2');
    if (result.data is! Map) return SettingsModel();
    return SettingsModel.fromJson(result.data);
  }

  static Future<void> changeSetting({
    required String parentID,
    required String settingsID,
    required String value,
    bool showLoading = true,
  }) async {
    await HttpService.to.post(
      '/system/settings/check',
      showLoading: showLoading,
      params: {
        'parentId': parentID,
        'settingsId': settingsID,
        'value': value,
      },
    );
  }
}
