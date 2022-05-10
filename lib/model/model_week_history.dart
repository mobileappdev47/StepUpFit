// To parse this JSON data, do
//
//     final modelWeekHistory = modelWeekHistoryFromJson(jsonString);

import 'dart:convert';

List<ModelWeekHistory> modelWeekHistoryFromJson(String str) => List<ModelWeekHistory>.from(json.decode(str).map((x) => ModelWeekHistory.fromJson(x)));

String modelWeekHistoryToJson(List<ModelWeekHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelWeekHistory {
  ModelWeekHistory({
    this.id,
    this.userId,
    this.coins,
    this.steps,
    this.km,
    this.cal,
    this.extension,
    this.reward,
    this.coinLimit,
    this.date,
    this.dayName,
    this.levelUpdated,
    this.createdOn,
  });

  int? id;
  dynamic userId;
  String? coins;
  String? steps;
  String? km;
  String? cal;
  String? extension;
  String? reward;
  String? coinLimit;
  DateTime? date;
  String? dayName;
  int? levelUpdated;
  String? createdOn;

  factory ModelWeekHistory.fromJson(Map<String, dynamic> json) => ModelWeekHistory(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"],
    coins: json["coins"],
    steps: json["steps"],
    km: json["km"],
    cal: json["cal"],
    extension: json["extension"],
    reward: json["reward"],
    coinLimit: json["coin_limit"],
    date: DateTime.parse(json["date"]),
    dayName: json["day_name"],
    levelUpdated: json["level_updated"],
    createdOn: json["created_on"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId,
    "coins": coins,
    "steps": steps,
    "km": km,
    "cal": cal,
    "extension": extension,
    "reward": reward,
    "coin_limit": coinLimit,
    "date":date,
    "day_name": dayName,
    "level_updated": levelUpdated,
    "created_on": createdOn == null ? null : createdOn.toString(),
  };
}
