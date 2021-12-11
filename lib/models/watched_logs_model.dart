// To parse this JSON data, do
//
//     final watchedLogsModel = watchedLogsModelFromJson(jsonString);

import 'dart:convert';

WatchedLogsModel watchedLogsModelFromJson(String str) => WatchedLogsModel.fromJson(json.decode(str));

String watchedLogsModelToJson(WatchedLogsModel data) => json.encode(data.toJson());

class WatchedLogsModel {
    WatchedLogsModel({
        this.rate,
        this.minimumRate,
        this.checkedAt,
    });

    double? rate;
    double? minimumRate;
    DateTime? checkedAt;

    factory WatchedLogsModel.fromJson(Map<String, dynamic> json) => WatchedLogsModel(
        rate: json["rate"] == null ? null : json["rate"].toDouble(),
        minimumRate: json["minimum_rate"] == null ? null : json["minimum_rate"].toDouble(),
        checkedAt: json["checked_at"] == null ? null : DateTime.parse(json["checked_at"]),
    );

    Map<String, dynamic> toJson() => {
        "rate": rate == null ? null : rate,
        "minimum_rate": minimumRate == null ? null : minimumRate,
        "checked_at": checkedAt == null ? null : checkedAt!.toIso8601String(),
    };
}
