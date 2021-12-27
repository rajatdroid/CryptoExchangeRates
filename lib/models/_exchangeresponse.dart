

class ExchangeRate {

  String? asset_id_base;
  String? asset_id_quote;
  double? rate;

  ExchangeRate(this.asset_id_base, this.asset_id_quote, this.rate);

  factory ExchangeRate.getFromJson(Map<String, dynamic> json){
    return ExchangeRate(json['asset_id_base'] as String, json['asset_id_quote'] as String , json['rate'] as double);
  }




}