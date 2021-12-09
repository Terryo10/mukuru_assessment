// To parse this JSON data, do
//
//     final exchangeRatesModel = exchangeRatesModelFromJson(jsonString);

import 'dart:convert';

ExchangeRatesModel exchangeRatesModelFromJson(String str) =>
    ExchangeRatesModel.fromJson(json.decode(str));

String exchangeRatesModelToJson(ExchangeRatesModel data) =>
    json.encode(data.toJson());

class ExchangeRatesModel {
  ExchangeRatesModel({
    this.disclaimer,
    this.license,
    this.timestamp,
    this.base,
    this.rates,
  });

  String? disclaimer;
  String? license;
  int? timestamp;
  String? base;
  Map<String, double>? rates;

  factory ExchangeRatesModel.fromJson(Map<String, dynamic> json) =>
      ExchangeRatesModel(
        disclaimer: json["disclaimer"],
        license: json["license"],
        timestamp: json["timestamp"],
        base: json["base"],
        rates: Map.from(json["rates"])
            .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "disclaimer": disclaimer,
        "license": license,
        "timestamp": timestamp,
        "base": base,
        "rates":
            Map.from(rates!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
