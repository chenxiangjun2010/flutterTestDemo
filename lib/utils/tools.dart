part of utils;

abstract class Tools {
  static void unfocus() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

  static String toAmount(int? value) {
    final num = (value ?? 0) / 100;
    final format = NumberFormat('#,##0.00');
    return format.format(num);
  }

  static String generateMD5(String data) {
    final bytes = const Utf8Encoder().convert(data);
    return md5.convert(bytes).toString();
  }

  static String generateBarcode([bool hasBegin = true]) {
    final middle = Random().nextInt(kBarcodeChars2.length).floor();
    final middleResult = kBarcodeChars2[middle];
    var beginResult = '';
    var endResult = '';
    for (var index = 0; index < 5; index++) {
      final beginIndex = Random().nextInt(kBarcodeChars1.length).floor();
      final endIndex = Random().nextInt(kBarcodeChars1.length).floor();
      beginResult += kBarcodeChars1[beginIndex];
      endResult += kBarcodeChars1[endIndex];
    }
    if (hasBegin) return beginResult + middleResult + endResult;
    return middleResult + endResult;
  }

  static String dateFromMS(
    int? timestamp, {
    String pattern = 'yyyy-MM-dd',
    bool humanize = false,
  }) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp ?? 0);
    if (humanize) {
      final now = DateTime.now();
      final difference = now.difference(dateTime);
      if (difference.inMinutes < 60) {
        if (difference.inMinutes < 1) return '刚刚';
        return '${difference.inMinutes}分钟前';
      } else if (difference.inHours < 24) {
        return '${difference.inHours}小时前';
      } else if (difference.inDays < 30) {
        return '${difference.inDays}天前';
      } else if (now.year == dateTime.year) {
        return DateFormat('MM-dd').format(dateTime);
      }
    }
    return DateFormat(pattern).format(dateTime);
  }
}
