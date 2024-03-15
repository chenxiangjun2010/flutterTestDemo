part of models;

class LabelLayoutModel {
  const LabelLayoutModel({
    this.name,
    this.size,
    this.value,
  });

  final String? name;
  final Size? size;
  final String? value;
}

class LabelContentModel {
  const LabelContentModel({
    this.name,
    this.value,
    this.sort,
  });

  final String? name;
  final String? value;
  final int? sort;
}

/// 绘制标签参数。
///
/// @param x 水平坐标，单位mm。
///
/// @param y 垂直坐标，单位mm。
///
/// @param width 图片宽度，单位mm。
///
/// @param height 图片高度，单位mm。
///
/// @param text 内容。
///
/// @param fontSize 字体大小。
///
/// @param textAlign 文本水平对齐方式  0 左对齐、1 居中对齐、2 右对齐。
///
/// @param type 内容类型  0 文本、1 条码。
class LabelContentParamModel {
  LabelContentParamModel({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.type,
    required this.text,
    required this.fontSize,
    required this.textAlign,
  });

  late double x;
  late double y;
  late double width;
  late double height;
  late double fontSize;
  late int type;
  late String text;
  late int textAlign;
}

// class LabelPrintDataModel {
//   LabelPrintDataModel({
//     required this.count,
//     required this.template,
//   });

//   late LabelTemplate template;
//   late int count;
// }
