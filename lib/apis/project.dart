part of apis;

abstract class ProjectAPI {
  /// 所属项目列表
  static Future<List<ProjectModel>> list({
    required String merchantID,
    int page = 1,
    int limit = 20,
  }) async {
    final result = await HttpService.to.get(
      '/api/ProjectBase/List',
      params: {
        'index': page,
        'size': limit,
      },
    );

    return List.generate(result.data.length, (index) {
      return ProjectModel.fromJson(result.data[index]);
    });
  }

  //Info
  static Future<ProjectBaseModel> detail(String id) async {
    final result = await HttpService.to.get(
      '/api/ProjectBase/Info',
      showLoading: true,
      params: {'id': id},
    );

    if (result.data is! Map) return ProjectBaseModel();
    return ProjectBaseModel.fromJson(result.data);
  }
}
