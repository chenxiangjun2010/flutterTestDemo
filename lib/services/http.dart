part of services;

class HttpService extends GetxService {
  static HttpService get to => Get.find();

  late final Dio _dio;

  @override
  void onInit() {
    super.onInit();

    final options = BaseOptions(
      baseUrl: kServerUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {},
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );

    _dio = Dio(options);

    _dio.interceptors.add(_RequestInterceptor());
  }

  Map<String, dynamic>? _getHeaders({bool excludeToken = false}) {
    final headers = <String, dynamic>{};
    if (Get.isRegistered<UserStore>() &&
        UserStore.to.hasToken &&
        !excludeToken) {
      headers['Authorization'] = 'Bearer ${UserStore.to.token}';
      // headers['Authorization'] =
      // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiIxIiwiaWF0IjoiMTcwODQzMTgwMCIsIm5iZiI6IjE3MDg0MzE4MDAiLCJleHAiOiIxNzA4NDYwNjAwIiwiaXNzIjoiYW5jaG9yc29mdCIsImF1ZCI6ImFuY2hvciJ9.h89XYVLTKceWeahCaBIB6fn3Mxnlae2zGUwyBfX-c24';
    }
    return headers;
  }

  Future<ResponseModel> get(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool excludeToken = false,
    bool showLoading = false,
  }) async {
    if (showLoading) CustomToast.loading();
    try {
      final requestOptions = options ?? Options();
      requestOptions.headers = _getHeaders(excludeToken: excludeToken);

      print('url_get:$url,params:$params');
      final response = await _dio.get(
        url,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken,
      );
      print('response————————————————————————-------,$response');

      if (showLoading) CustomToast.dismiss();
      return ResponseModel.fromJson(response.data);
    } catch (error) {
      print('error？？？？,$error');
      print(error is! DioException);

      if (error is! DioException) CustomToast.dismiss();
      rethrow;
    }
  }

  Future<ResponseModel> post(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool excludeToken = false,
    bool showLoading = false,
  }) async {
    if (showLoading) CustomToast.loading();
    try {
      final requestOptions = options ?? Options();
      requestOptions.headers = _getHeaders(excludeToken: excludeToken);

      print('url_post:$url,params:$params');
      final response = await _dio.post(
        url,
        data: params,
        options: requestOptions,
        cancelToken: cancelToken,
      );
      print('showLoading,$showLoading');

      if (showLoading) CustomToast.dismiss();
      print('response.data');
      print(response.data);

      return ResponseModel.fromJson(response.data);
    } catch (error) {
      print('catch_error____________,$error');
      if (error is! DioException) CustomToast.dismiss();

      rethrow;
    }
  }

  Future<ResponseModel> upload(
    String url, {
    required String path,
    Options? options,
    CancelToken? cancelToken,
    bool excludeToken = false,
    ProgressCallback? onSendProgress,
  }) async {
    final requestOptions = options ?? Options();
    requestOptions.headers = _getHeaders(excludeToken: excludeToken);
    final name = path.substring(path.lastIndexOf('/') + 1, path.length);
    final image = await MultipartFile.fromFile(path, filename: name);
    final formData = FormData.fromMap({'formFile': image});
    final response = await _dio.post(
      url,
      data: formData,
      options: requestOptions,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
    );
    return ResponseModel.fromJson(response.data);
  }
}

class _RequestInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('原始接口返回数据：,$response');
    if (response.data['status'] != 1) {
      // if (response.data['code'] != 0) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ),
        true,
      );
    } else {
      super.onResponse(response, handler);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Console.log(err);
    if (err.toString().contains('401')) {
      CustomToast.fail('401 - Unauthorized');
      UserStore.to.logout();
    }
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        CustomToast.fail('网络连接超时');
        break;
      case DioExceptionType.sendTimeout:
        CustomToast.fail('发送超时');
        break;
      case DioExceptionType.receiveTimeout:
        CustomToast.fail('接收超时');
        break;
      case DioExceptionType.badCertificate:
        CustomToast.fail('证书错误');
        break;
      case DioExceptionType.badResponse:
        final response = err.response;
        final statusCode = response?.statusCode;
        final code = int.tryParse(response?.data['code']?.toString() ?? '');
        var msg = '服务器错误';
        switch (statusCode) {
          case 401:
            msg = '$statusCode - Unauthorized';
            break;
          case 404:
            msg = '$statusCode - Server not found';
            break;
          case 500:
            msg = '$statusCode - Server error';
            break;
          case 502:
            msg = '$statusCode - Bad gateway';
            break;
          default:
            if (code == 901) UserStore.to.logout();
            msg = response?.data?['msg']?.toString() ?? msg;
            break;
        }
        CustomToast.fail(msg);
        break;
      case DioExceptionType.cancel:
        Console.log('请求取消');
        break;
      case DioExceptionType.connectionError:
        CustomToast.fail('网络连接失败');
        break;
      case DioExceptionType.unknown:
        CustomToast.fail('请求发生未知错误');
        break;
    }
    super.onError(err, handler);
  }
}
