part of pages.commodity;

class CommodityController extends GetxController {
  final EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  List<CommodityModel> commodityList = [];

  final int _limit = 20;
  int _page = 1;
  bool _noMore = false;

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  Future<void> _getCommodityList([bool isRefresh = false]) async {
    if (isRefresh) _page = 1;
    final result = await CommodityAPI.list(
      merchantID: ShopStore.to.info.id ?? '',
      page: _page,
      limit: _limit,
    );
    if (isRefresh) commodityList.clear();
    commodityList.addAll(result);
    _page++;
    _noMore = result.length < _limit;
    update();
  }

  Future<void> onShelves(String? id) async {
    final index = commodityList.indexWhere((element) => element.id == id);
    if (index < 0) throw '没有找到商品';
    final item = commodityList[index];
    final isSales = item.isSales ?? false;
    await CommodityAPI.changeSales(
      ids: [id ?? ''],
      status: !isSales,
    );
    item.isSales = !isSales;
  }

  void onRemove(String? id) async {
    final index = commodityList.indexWhere((element) => element.id == id);
    if (index < 0) return;
    await CommodityAPI.remove(ids: [id ?? '']);
    commodityList.removeAt(index);
    update();
  }

  void changeStock(CommodityModel goods, List<CommoditySKUModel> skus) async {
    await StockAPI.update(goods: goods, skus: skus);
    var total = 0;
    for (var element in skus) {
      total += (element.count ?? 0);
    }
    goods.stock = total;
    update();
  }

  void onRefresh() async {
    try {
      await _getCommodityList(true);
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
      await _getCommodityList();
      refreshController.finishLoad();
    } catch (error) {
      refreshController.finishLoad(IndicatorResult.fail);
    }
  }
}
