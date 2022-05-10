// @dart=2.9

// To parse this JSON data, do
//
//     final modelHistory = modelHistoryFromJson(jsonString);

import 'dart:convert';

ModelHistory modelHistoryFromJson(String str) => ModelHistory.fromJson(json.decode(str));

String modelHistoryToJson(ModelHistory data) => json.encode(data.toJson());

class ModelHistory {
  ModelHistory({
    this.id,
    this.userId,
    this.coins,
    this.steps,
    this.km,
    this.cal,
    this.extension,
    this.reward,
    this.coinLimit,
    this.walkingCoins,
    this.date,
    this.levelUpdated,
    this.createdOn,
  });

  int id;
  int userId;
  String coins;
  String steps;
  String km;
  String cal;
  String extension;
  String reward;
  String coinLimit;
  String walkingCoins;
  DateTime date;
  int levelUpdated;
  DateTime createdOn;

  factory ModelHistory.fromJson(Map<String, dynamic> json) => ModelHistory(
        id: json["id"],
        userId: json["user_id"],
        coins: json["coins"],
        steps: json["steps"],
        km: json["km"],
        cal: json["cal"],
        extension: json["extension"],
        reward: json["reward"],
        coinLimit: json["coin_limit"],
        walkingCoins: json["walking_coins"],
        date: DateTime.parse(json["date"]),
        levelUpdated: json["level_updated"],
        createdOn: DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "user_id": userId,
        "coins": coins,
        "steps": steps,
        "km": km,
        "cal": cal,
        "extension": extension,
        "reward": reward,
        "coin_limit": coinLimit,
        "walking_coins": walkingCoins,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "level_updated": levelUpdated,
        "created_on": createdOn.toIso8601String(),
      };
}
