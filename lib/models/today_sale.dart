part of models;

class TodaySaleModel {
  TodaySaleModel({
    this.amount,
    this.piece,
    this.profit,
  });

  TodaySaleModel.fromJson(dynamic json) {
    amount = int.tryParse(json['saleAmount'].toString());
    piece = int.tryParse(json['salePiece'].toString());
    profit = int.tryParse(json['profitMargin'].toString());
  }

  int? amount;
  int? piece;
  int? profit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['saleAmount'] = amount;
    map['salePiece'] = piece;
    map['profitMargin'] = profit;
    return map;
  }
}
