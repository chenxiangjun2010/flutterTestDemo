/// @Description:
/// @Author: 歪脖子
/// @Date: 2023-10-29 14:14

part of pages.video_admin;

class VideoAdminController extends GetxController {
  final EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  List<VideoModel> videoList = [];

  final int _limit = 20;
  int _page = 1;
  bool _noMore = false;

  final TextEditingController searchProjectName =
      TextEditingController(); //工程名称
  final TextEditingController searchProjectNum = TextEditingController(); //内部编号
  final TextEditingController searchProjectOutNum =
      TextEditingController(); //内部编号
  final TextEditingController searchDeivceId = TextEditingController(); //设备id
  final TextEditingController searchDeivceName =
      TextEditingController(); //设备name
  final TextEditingController searchUserName = TextEditingController(); //使用人

  ///////////////////////////////////////////////////////////////////////////

  void search() async {
    _getDataList(true);
  }

  void reset() async {
    searchProjectOutNum.text = '';
    searchProjectNum.text = '';
    searchProjectName.text = '';

    searchDeivceId.text = '';
    searchDeivceName.text = '';
    searchUserName.text = '';
    _getDataList(true);
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

//index=1&size=10&NumberLike=1&ProjectNameLike=2&OutNumberLike=3&DeviceIDLike=4&DeviceNameLike=5&NameLike=6
  Future<void> _getDataList([bool isRefresh = false]) async {
    if (isRefresh) _page = 1;
    final result = await VideoAPI.list(
      merchantID: ShopStore.to.info.id ?? '',
      NumberLike: searchProjectNum.text.trim(),
      OutNumberLike: searchProjectOutNum.text.trim(),
      ProjectNameLike: searchProjectName.text.trim(),
      DeviceIDLike: searchDeivceId.text.trim(),
      DeviceNameLike: searchDeivceName.text.trim(),
      NameLike: searchUserName.text.trim(),
      page: _page,
      limit: _limit,
    );

    if (isRefresh) videoList.clear();
    videoList.addAll(result);
    _page++;
    _noMore = result.length < _limit;
    update();
  }

  void onRefresh() async {
    try {
      await _getDataList(true);
      refreshController.finishRefresh(IndicatorResult.success);
      refreshController.resetFooter();
    } catch (error) {
      refreshController.finishRefresh(IndicatorResult.fail);
    }
  }

  void onLoading() async {
    if (_noMore) {
      refreshController.finishLoad(IndicatorResult.noMore);
      return;
    }
    try {
      await _getDataList();
      refreshController.finishLoad();
    } catch (error) {
      refreshController.finishLoad(IndicatorResult.fail);
    }
  }
}
