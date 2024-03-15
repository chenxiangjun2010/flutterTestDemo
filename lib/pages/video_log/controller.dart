/// @Description:
/// @Author: 歪脖子
/// @Date: 2023-10-29 14:14

part of pages.video_log;

class VideoLogController extends GetxController {
  final String? id;
  final EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  List<VideoLogModel> logList = [];

  final int _limit = 20;
  int _page = 1;
  bool _noMore = false;

  VideoLogController([this.id]);

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  Future<void> _getLogList([bool isRefresh = false]) async {
    if (isRefresh) _page = 1;
    print('id,$id');

    final result = await VideoAPI.logList(
      id: id!,
      page: _page,
      limit: _limit,
    );
    print('result,$result');

    if (isRefresh) logList.clear();
    logList.addAll(result);
    _page++;
    _noMore = result.length < _limit;
    update();
  }

  void onRefresh() async {
    try {
      await _getLogList(true);
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
      await _getLogList();
      refreshController.finishLoad();
    } catch (error) {
      refreshController.finishLoad(IndicatorResult.fail);
    }
  }
}
