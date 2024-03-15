part of apis;

abstract class EnumAPI {
  /// 所属项目列表
  static Future<List<EnumModel>> list({
    int page = 1,
    int limit = 0,
    int Parent = 0,
    int EnumType = 0,
    int OrderByField = 2,
  }) async {
    final result = await HttpService.to.get(
      '/api/EnumType/List',
      params: {
        'index': page,
        'size': limit,
        'Parent': Parent,
        'EnumType': EnumType,
        'OrderByField': OrderByField,
      },
    );

    return List.generate(result.data.length, (index) {
      return EnumModel.fromJson(result.data[index]);
    });
  }
}
