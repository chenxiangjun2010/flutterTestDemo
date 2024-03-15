/// @Description:
/// @Author: 歪脖子
/// @Date: 2023-10-28 17:36

part of apis;

abstract class StockAPI {
  static Future<List<CommoditySKUModel>> goods(String goodsID) async {
    final result = await HttpService.to.get(
      '/stock/preview/detail',
      params: {
        'productId': goodsID,
        'filterZero': 0,
      },
    );
    if (result.data is! Map) return [];
    if (result.data['skuListVOS'] is! List) return [];
    return List.generate(result.data['skuListVOS'].length, (index) {
      return CommoditySKUModel.fromJson(result.data['skuListVOS'][index]);
    });
  }

  static Future<void> update({
    required CommodityModel goods,
    List<CommoditySKUModel> skus = const [],
  }) async {
    final List<Map> data = [];
    for (var element in skus) {
      if (element.stock == element.count) continue;
      data.add({
        'skuId': element.id,
        'colourId': element.colorID,
        'colourName': element.colorName,
        'sizeId': element.sizeID,
        'sizeName': element.sizeName,
        'beforeStock': element.stock,
        'afterStock': element.count,
      });
    }
    if (data.isEmpty) return;
    await HttpService.to.post(
      '/stock/check/saveOrUpdate',
      showLoading: true,
      params: {
        'productSkuForms': [
          {
            'productCode': goods.code,
            'productId': goods.id,
            'productName': goods.name,
            'skuForms': data,
          }
        ],
        'isBatch': 1,
      },
    );
  }
}
