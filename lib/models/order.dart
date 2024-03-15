part of models;

class OrderModel {
  OrderModel({
    this.id,
    this.no,
    this.count,
    this.totalPrice,
    this.discountPrice,
    this.shouldPrice,
    this.discountRate,
    this.deductPrice,
    this.cardVoucherPrice,
    this.actualAmount,
    this.remark,
    this.points,
    this.saleTime,
    this.status,
    this.goodsList,
  });

  OrderModel.fromJson(dynamic json) {
    id = (json['saleOrderId'] ?? json['salesOrderId'])?.toString();
    no = (json['saleOrderNo'] ?? json['salesOrderNo'])?.toString();
    count = int.tryParse((json['count'] ?? json['totalCount']).toString());
    actualAmount = int.tryParse(json['actualPrice'].toString());
    /*totalPrice = json['totalPrice'];
    discountPrice = json['discountPrice'];
    shouldPrice = json['shouldPrice'];
    discountRate = json['discountRate'];
    deductPrice = json['deductPrice'];
    cardVoucherPrice = json['cardVoucherPrice'];*/
    remark = json['remark']?.toString();
    /*points = json['points'];*/
    saleTime = json['salesTime']?.toString();
    /*status = json['status'];*/
    if (json['productList'] is List) {
      goodsList = [];
      json['productList'].forEach((v) {
        goodsList?.add(CommodityModel.fromJson(v));
      });
    }
  }
  String? id;
  String? no;
  int? count;
  int? totalPrice;
  int? discountPrice;
  int? shouldPrice;
  int? discountRate;
  int? deductPrice;
  int? cardVoucherPrice;
  int? actualAmount;
  String? remark;
  int? points;
  String? saleTime;
  int? status;
  List<CommodityModel>? goodsList;
}
