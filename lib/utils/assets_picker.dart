part of utils;

abstract class AssetsPicker {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> image({
    required BuildContext context,
    ImageSource source = ImageSource.gallery,
    double maxWidth = 1920,
    double maxHeight = 1920,
  }) async {
    if (!(await Access.photos())) {
      if (context.mounted) {
        /*CustomDialog.showAccess(
          context: context,
          content: const Text('需要访问您的照片库'),
        );*/
      }
      return null;
    }
    final result = await _picker.pickImage(
        source: source,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        requestFullMetadata: false);
    if (result == null) return null;
    return File(result.path);
  }
}
