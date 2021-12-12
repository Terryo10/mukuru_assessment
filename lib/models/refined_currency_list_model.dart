// To parse this JSON data, do
//
//     final currencyRefinedModel = currencyRefinedModelFromJson(jsonString);

import 'dart:convert';

CurrencyRefinedModel currencyRefinedModelFromJson(String str) => CurrencyRefinedModel.fromJson(json.decode(str));

String currencyRefinedModelToJson(CurrencyRefinedModel data) => json.encode(data.toJson());

class CurrencyRefinedModel {
    CurrencyRefinedModel({
        this.name,
        this.abr,
        this.warningRate,
        this.currentRate,
    });

    String ? name;
    String ? abr;
    double ? warningRate;
    double ? currentRate;

    factory CurrencyRefinedModel.fromJson(Map<String, dynamic> json) => CurrencyRefinedModel(
        name: json["name"] == null ? null : json["name"],
        abr: json["abr"] == null ? null : json["abr"],
        warningRate: json["warningRate"] == null ? null : json["warningRate"].toDouble(),
        currentRate: json["currentRate"] == null ? null : json["currentRate"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "abr": abr == null ? null : abr,
        "warningRate": warningRate == null ? null : warningRate,
        "currentRate": currentRate == null ? null : currentRate,
    };
}
