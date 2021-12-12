// To parse this JSON data, do
//
//     final currencyListModel = currencyListModelFromJson(jsonString);

import 'dart:convert';

Map<String, String> currencyListModelFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, String>(k, v));

String currencyListModelToJson(Map<String, String> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)));
