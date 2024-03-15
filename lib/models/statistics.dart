part of models;

class StatisticsModel {
  StatisticsModel({
    this.sales,
  });

  StatisticsModel.fromJson(dynamic json) {
    sales = json['saleStatisticsDAO'] is Map
        ? StatisticsSalesModel.fromJson(json['saleStatisticsDAO'])
        : null;
  }

  StatisticsSalesModel? sales;
}

class StatisticsSalesModel {
  StatisticsSalesModel({
    this.count,
    this.amount,
  });

  StatisticsSalesModel.fromJson(dynamic json) {
    count = int.tryParse(json['count'].toString());
    amount = int.tryParse(json['price'].toString());
  }

  int? count;
  int? amount;
}
