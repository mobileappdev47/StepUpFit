
// To parse this JSON data, do
//
//     final modelFriend = modelFriendFromJson(jsonString);

import 'dart:convert';

List<ModelFriend> modelFriendFromJson(String str) => List<ModelFriend>.from(json.decode(str).map((x) => ModelFriend.fromJson(x)));

String modelFriendToJson(List<ModelFriend> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelFriend {
  ModelFriend({
    this.id,
    this.name,
    this.mobileNumber,
    this.userId,
    this.createdOn,
    this.steps,
    this.isFollow,
  });

  int? id;
  String? name;
  String? mobileNumber;
  String? userId;
  DateTime? createdOn;
  int? steps;
  String? isFollow;

  factory ModelFriend.fromJson(Map<String, dynamic> json) => ModelFriend(
    id: json["id"],
    name: json["name"],
    mobileNumber: json["mobile_number"],
    userId: json["user_id"],
    createdOn: DateTime.parse(json["created_on"]),
    steps: json["steps"] == null ? null : json["steps"],
    isFollow: json["is_follow"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile_number": mobileNumber,
    "user_id": userId,
    "created_on": createdOn.toString(),
    "steps": steps == null ? null : steps,
    "is_follow": isFollow,
  };
}
