part of apis;

abstract class CommodityAPI {
  static Future<CommodityModel> detail(String id) async {
    final result = await HttpService.to.get(
      '/product/detail',
      showLoading: true,
      params: {'productId': id},
    );
    if (result.data is! Map) return CommodityModel();
    return CommodityModel.fromJson(result.data);
  }

  static Future<List<CommodityModel>> list({
    required String merchantID,
    int page = 1,
    int limit = 20,
  }) async {
    final result = await HttpService.to.post(
      '/product/list',
      params: {
        'currentPage': page,
        'pageSize': limit,
        'merchantId': merchantID,
      },
    );
    if (result.data is! Map && result.data['records'] is! List) return [];
    return List.generate(result.data['records'].length, (index) {
      return CommodityModel.fromJson(result.data['records'][index]);
    });
  }

  static Future<List<CommodityModel>> listForBarcode({
    int page = 1,
    int limit = 20,
  }) async {
    final result = await HttpService.to.post(
      '/product/barcode/list',
      params: {
        'currentPage': page,
        'pageSize': limit,
      },
    );
    if (result.data is! Map && result.data['records'] is! List) return [];
    return List.generate(result.data['records'].length, (index) {
      return CommodityModel.fromJson(result.data['records'][index]);
    });
  }

  /// status: 1 上架 0 下架
  static Future<void> changeSales({
    required List<String> ids,
    required bool status,
  }) async {
    await HttpService.to.post(
      '/product/batchUpperOrLower',
      params: {
        'ids': ids,
        'type': status ? 1 : 0,
      },
    );
  }

  static Future<void> remove({
    required List<String> ids,
  }) async {
    await HttpService.to.post(
      '/product/batchIsDelete',
      showLoading: true,
      params: {
        'ids': ids,
        'isDelete': 1,
      },
    );
  }

  /// type: 1 季节
  static Future<List<CommodityAttrModel>> attributeList(String type) async {
    final result = await HttpService.to.get(
      '/attr/list',
      params: {'attrType': type},
    );
    if (result.data is! List) return [];
    return List.generate(result.data.length, (index) {
      return CommodityAttrModel.fromJson(result.data[index]);
    });
  }

  static Future<void> add({
    String? id,
    required String name,
    required bool isSales,
    required String barcode,
    required double price,
    required List<CommoditySKUModel> sku,
    String code = '',
    String? cover,
    double? entryPrice,
    int? discount,
    int? salesTime,
    CommodityAttrModel? season,
  }) async {
    final isEdit = (id ?? '').isNotEmpty;
    final attrs = <Map>[];
    if (season != null) {
      attrs.add({
        'attrId': season.id,
        'attrName': season.name,
        'attrType': '1',
        'check': false,
      });
    }
    final params = <String, dynamic>{
      'productName': name,
      'upper': isSales,
      'autoCheck': true,
      'productCode': code,
      'barcode': barcode,
      'retailPrice': (price * 100).toInt(),
      'entryPrice': ((entryPrice ?? 0) * 100).toInt(),
      'discountRate': discount ?? 100,
      'imgIndex': 0,
      'toAttrForms': jsonEncode(attrs),
    };
    if ((cover ?? '').isNotEmpty) params['imgUrl'] = [cover];
    params['skuForm'] = sku.map((item) {
      return {
        'colourId': item.colorID,
        'sizeId': item.sizeID,
        'stock': item.stock,
        'barcode': item.barcode,
      };
    }).toList();
    if (isEdit) {
      params['productId'] = id;
    } else {
      params['onsalesTime'] = Tools.dateFromMS(
        salesTime ?? DateTime.now().millisecondsSinceEpoch,
      );
    }
    await HttpService.to.post(
      isEdit ? '/product/update' : '/product/add',
      showLoading: true,
      params: params,
    );
  }
}
