// To parse this JSON data, do
//
//     final currencyRefinedModel = currencyRefinedModelFromJson(jsonString);

import 'dart:convert';

CurrencyRefinedModel currencyRefinedModelFromJson(String str) => CurrencyRefinedModel.fromJson(json.decode(str));

String currencyRefinedModelToJson(CurrencyRefinedModel data) => json.encode(data.toJson());

class CurrencyRefinedModel {
    CurrencyRefinedModel({
        this.abr,
        this.name,
    });

    String? abr;
    String? name;

    factory CurrencyRefinedModel.fromJson(Map<String, dynamic> json) => CurrencyRefinedModel(
        abr: json["abr"] == null ? null : json["abr"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "abr": abr == null ? null : abr,
        "name": name == null ? null : name,
    };
}
