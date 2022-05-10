//@dart=2.9

// To parse this JSON data, do
//
//     final modelSetting = modelSettingFromJson(jsonString);

import 'dart:convert';

ModelSetting modelSettingFromJson(String str) =>
    ModelSetting.fromJson(json.decode(str));

String modelSettingToJson(ModelSetting data) => json.encode(data.toJson());

class ModelSetting {
  ModelSetting({
    this.id,
    this.bannerId,
    this.rewardId,
    this.intId,
    this.nativeId,
    this.fbBannerId,
    this.fbRewardId,
    this.fbIntId,
    this.fbNativeId,
    this.steps,
    this.dailyExtension,
    this.dailyReward,
    this.referral,
    this.referralNote,
    this.rewardDescription,
    this.extensionDescription,
    this.rewardNote,
    this.extensionNote,
    this.minutes,
    this.createdOn,
  });

  int id;
  String bannerId;
  String rewardId;
  dynamic intId;
  String nativeId;
  String fbBannerId;
  String fbRewardId;
  String fbIntId;
  String fbNativeId;
  String steps;
  String dailyExtension;
  String dailyReward;
  int referral;
  String referralNote;
  String rewardDescription;
  String extensionDescription;
  String rewardNote;
  String extensionNote;
  String minutes;
  DateTime createdOn;

  factory ModelSetting.fromJson(Map<String, dynamic> json) => ModelSetting(
        id: json["id"],
        bannerId: json["banner_id"],
        rewardId: json["reward_id"],
        intId: json["int_id"],
        nativeId: json["native_id"],
        fbBannerId: json["fb_banner_id"],
        fbRewardId: json["fb_reward_id"],
        fbIntId: json["fb_int_id"],
        fbNativeId: json["fb_native_id"],
        steps: json["steps"],
        dailyExtension: json["daily_extension"],
        dailyReward: json["daily_reward"],
        referral: json["referral"],
        referralNote: json["referral_note"],
        rewardDescription: json["reward_description"],
        extensionDescription: json["extension_description"],
        rewardNote: json["reward_note"],
        extensionNote: json["extension_note"],
        minutes: json["minutes"],
        createdOn: DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "banner_id": bannerId,
        "reward_id": rewardId,
        "int_id": intId,
        "native_id": nativeId,
        "fb_banner_id": fbBannerId,
        "fb_reward_id": fbRewardId,
        "fb_int_id": fbIntId,
        "fb_native_id": fbNativeId,
        "steps": steps,
        "daily_extension": dailyExtension,
        "daily_reward": dailyReward,
        "referral": referral,
        "referral_note": referralNote,
        "reward_description": rewardDescription,
        "extension_description": extensionDescription,
        "reward_note": rewardNote,
        "extension_note": extensionNote,
        "minutes": minutes,
        "created_on": createdOn.toIso8601String(),
      };
}
