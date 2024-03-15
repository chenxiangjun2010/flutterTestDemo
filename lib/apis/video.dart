/// @Description:
/// @Author: 歪脖子
/// @Date: 2023-10-29 14:18

part of apis;

abstract class VideoAPI {
  static Future<List<VideoModel>> list({
    required String merchantID,
    int page = 1,
    int limit = 20,
    String? NumberLike,
    String? OutNumberLike,
    String? ProjectNameLike,
    String? DeviceIDLike,
    String? DeviceNameLike,
    String? NameLike,
  }) async {
    final result = await HttpService.to.get(
      '/api/VideoDevice/List',
      params: {
        'index': page,
        'size': limit,
        'NumberLike': NumberLike,
        'OutNumberLike': OutNumberLike,
        'ProjectNameLike': ProjectNameLike,
        'DeviceIDLike': DeviceIDLike,
        'DeviceNameLike': DeviceNameLike,
        'NameLike': NameLike,
      },
    );

    return List.generate(result.data.length, (index) {
      print('index,$index');

      return VideoModel.fromJson(result.data[index]);
    });
  }

  /// 详情页
  static Future<VideoModel> detail(String id) async {
    final result = await HttpService.to.get(
      '/api/VideoDevice/Info',
      showLoading: true,
      params: {'id': id},
    );

    if (result.data is! Map) return VideoModel();
    return VideoModel.fromJson(result.data);
  }

  /// 添加 编辑
  static Future<void> add({
    String? id = '',
    String? editDate,
    String deviceID = '',
    String deviceName = '',
    String? deviceUser,
    String? userPhone,
    int? projectID,
    // int? projectLat=0,
    //int? projectLng=0,
    // String? projectName,
  }) async {
    final isEdit = (id ?? '').isNotEmpty;

    // 1900-01-01 00:00:00.000
    // final editDate = DateTime.now().toString().substring(0, 23);
    if (!isEdit) {
      editDate = '1900-01-01 00:00:00.000';
    }
    final params = <String, dynamic>{
      'deviceID': deviceID,
      'deviceName': deviceName,
      'id': id ?? '0',
      'deviceUser': deviceUser,
      'userPhone': userPhone,
      'projectID': projectID,
      'editDate': editDate
    };

    await HttpService.to.post(
      isEdit ? '/api/VideoDevice/Edit' : '/api/VideoDevice/Add',
      showLoading: true,
      params: params,
    );
  }

  /// 日志列表
  static Future<List<VideoLogModel>> logList({
    required String id,
    int page = 1,
    int limit = 20,
  }) async {
    final result = await HttpService.to.get(
      '/api/VideoDeviceLog/List',
      params: {
        'VideoDeviceSFID': id,
        'index': page,
        'size': limit,
      },
    );

    return List.generate(result.data.length, (index) {
      return VideoLogModel.fromJson(result.data[index]);
    });
  }
}
