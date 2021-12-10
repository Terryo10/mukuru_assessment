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
    });

    String ? name;
    String ? abr;
    int ? warningRate;

    factory CurrencyRefinedModel.fromJson(Map<String, dynamic> json) => CurrencyRefinedModel(
        name: json["name"] == null ? null : json["name"],
        abr: json["abr"] == null ? null : json["abr"],
        warningRate: json["warning_rate"] == null ? null : json["warning_rate"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "abr": abr == null ? null : abr,
        "warning_rate": warningRate == null ? null : warningRate,
    };
}
