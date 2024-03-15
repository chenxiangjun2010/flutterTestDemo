/// @Description: 标签数据
/// @Author: 歪脖子
/// @Date: 2023-10-26 21:14

part of store;

class LabelStore extends GetxController {
  static LabelStore get to => Get.find();

  LabelLayoutModel? _layout;
  List<LabelContentModel> _contents = [];

  LabelLayoutModel? get layout => _layout;

  List<LabelContentModel> get contents => _contents;

  @override
  void onInit() {
    final layoutValue = StorageService.to.getString(kLocalLabelLayout);
    final contentsValue = StorageService.to.getList(kLocalLabelContents);
    if (layoutValue.isNotEmpty) {
      final index = kLabelLayouts.indexWhere(
        (element) => element.value == layoutValue,
      );
      if (index > -1) _layout = kLabelLayouts[index];
    }
    for (var value in contentsValue) {
      final index = kLabelContents.indexWhere(
        (element) => element.value == value,
      );
      if (index > -1) _contents.add(kLabelContents[index]);
    }
    super.onInit();
  }

  void save(
    LabelLayoutModel layout,
    List<LabelContentModel> contents,
  ) async {
    _layout = layout;
    _contents = contents;

    final contentsValue = <String>[];
    for (var element in contents) {
      contentsValue.add(element.value ?? '');
    }
    StorageService.to.setString(kLocalLabelLayout, _layout?.value ?? '');
    StorageService.to.setList(kLocalLabelContents, contentsValue);
  }
}
