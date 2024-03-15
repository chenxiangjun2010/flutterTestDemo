part of apis;

abstract class SettleAPI {
  static Future<List<CommodityModel>> goodsList({
    int page = 1,
    int limit = 20,
    String? keyword,
  }) async {
    final result = await HttpService.to.get(
      '/sales/product/listV2',
      params: {
        'currentPage': page,
        'pageSize': limit,
        'productNameOrCode': keyword,
      },
    );
    if (result.data is! Map && result.data['records'] is! List) return [];
    return List.generate(result.data['records'].length, (index) {
      return CommodityModel.fromJson(result.data['records'][index]);
    });
  }

  static Future<void> bill({
    required int actualAmount,
    required int totalAmount,
    required double discount,
    required List<CommodityModel> goodsList,
    required String? empID,
    required int? userType,
    required DateTime date,
    String? remark,
  }) async {
    final details = [];
    for (var goods in goodsList) {
      for (var sku in (goods.skus ?? <CommoditySKUModel>[])) {
        if ((sku.count ?? 0) > 0) {
          final price = goods.price ?? 0;
          final goodsDiscount = (goods.discount ?? 0) / 100;
          details.add({
            'productCode': goods.code,
            'productId': goods.id,
            'productName': goods.name,
            'skuId': sku.id,
            'basicsPrice': price,
            'price': (price * goodsDiscount / 100).ceil(),
            'count': sku.count,
            'discountRate': goods.discount,
            'discountChange': 0,
            'discountPrice': 0,
            /*"priceType": 1,
            "skuDiscountPrice": 0,
            "totalPrice": 0,
            "giveFlag": 0,
            "activityId": "",*/
          });
        }
      }
    }
    await HttpService.to.post(
      '/sales/save',
      showLoading: true,
      params: {
        'deviceId': '1390200105-3018334',
        'shouldPrice': actualAmount,
        'actualPrice': actualAmount,
        'totalOrderPrice': totalAmount,
        'empId': empID, //员工ID
        'empType': userType, //员工类型
        'balancePrice': 0, // 找零
        'discountRate': (discount * 100).ceil(),
        'detailForms': details,
        'priceOrderRemnantType': 0, // 目前不知道是什么，必填
        'priceOrderType': 0, // 目前不知道是什么，必填
        'remark': remark,
        'date': Tools.dateFromMS(date.millisecondsSinceEpoch),
        'payForms': [
          {
            'payPrice': actualAmount,
            'payType': 1, // payType 1现金 2刷卡 4微信 5支付宝
          },
        ],
        // "cardVoucherPrice": 0,
        // 'zeroAmount': 0,
        /*"basicForm": {
          "actualPrice": "3600",
          "balancePrice": "0",
          "pointCurrent": 0,
          "resideAmount": 0,
          "residePoint": 0,
          "shouldPrice": "3600"
        },*/
        // "sign": "6iz6ph4r",
        // "memberId": "",
        // "memberName": "",
      },
    );
  }
}
