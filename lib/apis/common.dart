part of apis;

abstract class CommonAPI {
  static Future<FileAllCommonModel?> upload({
    required String path,
    void Function(int count, int total)? onSendProgress,
  }) async {
    final result = await HttpService.to.upload(
      '/api/Upload/UploadFile',
      path: path,
      onSendProgress: onSendProgress,
    );
    print('result1,$result');

    return FileAllCommonModel.fromJson(result.data);
  }
}
