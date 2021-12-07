// To parse this JSON data, do
//
//     final exchangeRatesModel = exchangeRatesModelFromJson(jsonString);

import 'dart:convert';

ExchangeRatesModel exchangeRatesModelFromJson(String str) => ExchangeRatesModel.fromJson(json.decode(str));

String exchangeRatesModelToJson(ExchangeRatesModel data) => json.encode(data.toJson());

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

    factory ExchangeRatesModel.fromJson(Map<String, dynamic> json) => ExchangeRatesModel(
        disclaimer: json["disclaimer"] == null ? null : json["disclaimer"],
        license: json["license"] == null ? null : json["license"],
        timestamp: json["timestamp"] == null ? null : json["timestamp"],
        base: json["base"] == null ? null : json["base"],
        rates: json["rates"] == null ? null : Map.from(json["rates"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "disclaimer": disclaimer == null ? null : disclaimer,
        "license": license == null ? null : license,
        "timestamp": timestamp == null ? null : timestamp,
        "base": base == null ? null : base,
        "rates": rates == null ? null : Map.from(rates!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
