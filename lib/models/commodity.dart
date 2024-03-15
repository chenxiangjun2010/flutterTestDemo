part of models;

class CommodityModel {
  CommodityModel({
    this.id,
    this.cover,
    this.code,
    this.barcode,
    this.name,
    this.stock,
    this.entryPrice,
    this.price,
    this.discount,
    this.isSales,
    this.salesTime,
    this.salesCount,
    this.colors,
    this.sizes,
    this.season,
    this.skus,
  });

  CommodityModel.fromJson(dynamic json) {
    id = json['productId']?.toString();
    if (json['img'] is String) {
      cover = json['img']?.toString();
    } else if (json['imgUrl'] is List && json['imgUrl'].isNotEmpty) {
      cover = json['imgUrl'].first;
    }
    code = json['productCode']?.toString();
    barcode = json['barcode']?.toString();
    name = json['productName']?.toString();
    stock = int.tryParse((json['totalStock'] ?? json['stock']).toString());
    entryPrice = int.tryParse(json['entryPrice'].toString());
    price = int.tryParse(json['retailPrice'].toString());
    discount = int.tryParse(json['discountRate'].toString());
    isSales = int.tryParse(json['onsales'].toString()) == 1;
    salesTime = json['onsalesTime']?.toString();
    salesCount = int.tryParse(json['salesCount'].toString());
    if (json['colours'] is List) {
      colors = [];
      for (var element in json['colours']) {
        colors!.add(CommoditySpecModel.fromJson(element));
      }
    }
    if (json['sizes'] is List) {
      sizes = [];
      for (var element in json['sizes']) {
        sizes!.add(CommoditySpecModel.fromJson(element));
      }
    }
    if (json['attrForm'] is List) {
      for (var element in json['attrForm']) {
        if (element['attrType'].toString() == '1') {
          season = CommodityAttrModel.fromJson(element);
        }
      }
    }
    if (json['skuList'] is List) {
      skus = [];
      for (var element in json['skuList']) {
        skus!.add(CommoditySKUModel.fromJson(element));
      }
    }
  }

  String? id;
  String? cover;
  String? code;
  String? barcode;
  String? name;
  int? stock;
  int? entryPrice;
  int? price;
  int? discount;
  bool? isSales;
  String? salesTime;
  int? salesCount;
  CommodityAttrModel? season;
  List<CommoditySpecModel>? colors;
  List<CommoditySpecModel>? sizes;
  List<CommoditySKUModel>? skus;

  CommodityModel copyWith({
    String? id,
    String? cover,
    String? code,
    String? barcode,
    String? name,
    int? stock,
    int? entryPrice,
    int? price,
    int? discount,
    bool? isSales,
    String? salesTime,
    int? salesCount,
    CommodityAttrModel? season,
    List<CommoditySpecModel>? colors,
    List<CommoditySpecModel>? sizes,
    List<CommoditySKUModel>? skus,
  }) =>
      CommodityModel(
        id: id ?? this.id,
        cover: cover ?? this.cover,
        code: code ?? this.code,
        barcode: barcode ?? this.barcode,
        name: name ?? this.name,
        stock: stock ?? this.stock,
        entryPrice: stock ?? this.stock,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        isSales: isSales ?? this.isSales,
        salesTime: salesTime ?? this.salesTime,
        salesCount: salesCount ?? this.salesCount,
        season: season ?? this.season,
        colors: colors ?? this.colors,
        sizes: sizes ?? this.sizes,
        skus: skus ?? this.skus,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = id;
    map['img'] = cover;
    map['productCode'] = code;
    map['productName'] = name;
    map['stock'] = stock;
    map['entryPrice'] = entryPrice;
    map['retailPrice'] = price;
    map['onsales'] = isSales == true ? 1 : 0;
    map['onsalesTime'] = salesTime;
    map['salesCount'] = salesCount;
    return map;
  }

  @override
  bool operator ==(Object other) {
    return other is CommodityModel &&
        other.runtimeType == runtimeType &&
        other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class CommodityAttrModel {
  CommodityAttrModel({
    this.id,
    this.name,
  });

  CommodityAttrModel.fromJson(dynamic json) {
    id = json['attrId']?.toString();
    name = json['attrName']?.toString();
  }

  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attrId'] = id;
    map['attrName'] = name;
    return map;
  }

  @override
  bool operator ==(Object other) {
    return other is CommodityAttrModel &&
        other.runtimeType == runtimeType &&
        other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class CommoditySpecModel {
  CommoditySpecModel({
    this.id,
    this.name,
    this.type,
  });

  CommoditySpecModel.fromJson(dynamic json) {
    id = json['specsAttrId']?.toString();
    name = json['attrName']?.toString();
    type = int.tryParse(json['specsType'].toString());
  }

  String? id;
  String? name;
  int? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['specsAttrId'] = id;
    map['attrName'] = name;
    map['specsType'] = type;
    return map;
  }

  @override
  bool operator ==(Object other) {
    return other is CommoditySpecModel &&
        other.runtimeType == runtimeType &&
        other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class CommoditySKUModel {
  CommoditySKUModel({
    this.id,
    this.colorName,
    this.sizeName,
    this.barcode,
    this.colorID,
    this.sizeID,
    this.stock,
    this.count,
  });

  CommoditySKUModel.fromJson(dynamic json) {
    id = (json['skuId'] ?? json['id'])?.toString();
    colorName = (json['colourName'] ?? json['colorName'])?.toString();
    sizeName = json['sizeName']?.toString();
    barcode = json['barcode']?.toString();
    colorID = json['colourId']?.toString();
    sizeID = json['sizeId']?.toString();
    stock = int.tryParse(json['stock'].toString());
    count = int.tryParse(json['count'].toString());
  }

  String? id;
  String? colorName;
  String? sizeName;
  String? barcode;
  String? colorID;
  String? sizeID;
  int? stock;
  int? count;

  CommoditySKUModel copyWith({
    String? id,
    String? colorName,
    String? sizeName,
    String? barcode,
    String? colorID,
    String? sizeID,
    int? stock,
    int? count,
  }) =>
      CommoditySKUModel(
        id: id ?? this.id,
        colorName: colorName ?? this.colorName,
        sizeName: sizeName ?? this.sizeName,
        barcode: barcode ?? this.barcode,
        colorID: colorID ?? this.colorID,
        sizeID: sizeID ?? this.sizeID,
        stock: stock ?? this.stock,
        count: count ?? this.count,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['colorName'] = colorName;
    map['sizeName'] = sizeName;
    map['barcode'] = barcode;
    map['colourId'] = colorID;
    map['sizeId'] = sizeID;
    map['stock'] = stock;
    map['count'] = count;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
