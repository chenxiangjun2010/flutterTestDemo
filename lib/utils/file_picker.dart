part of utils;

/// 图片选取
Future<String> getDocument() async {
  FlutterDocumentPickerParams? params = FlutterDocumentPickerParams(
    // 允许选取的文件拓展类型，不加此属性则默认支持所有类型
    allowedFileExtensions: ['pdf', 'xls', 'xlsx', 'jpg', 'png', 'jpeg'],
  );

  String? path = await FlutterDocumentPicker.openDocument(
    params: params,
  );

  return path ?? '';
}
