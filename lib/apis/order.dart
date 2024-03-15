/// @Description:
/// @Author: 歪脖子
/// @Date: 2023-10-29 14:18

part of apis;

abstract class OrderAPI {
  static Future<List<VideoLogModel>> list({
    required String merchantID,
    int page = 1,
    int limit = 20,
  }) async {
    final result = await HttpService.to.get(
      '/sales/invoice/list',
      params: {
        'merchantId': merchantID,
        'currentPage': page,
        'pageSize': limit,
      },
    );
    if (result.data is! Map && result.data['records'] is! List) return [];
    return List.generate(result.data['records'].length, (index) {
      return VideoLogModel.fromJson(result.data['records'][index]);
    });
  }
}
