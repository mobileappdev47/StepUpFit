// To parse this JSON data, do
//
//     final modelUser = modelUserFromJson(jsonString);

import 'dart:convert';

List<ModelUser> modelUserFromJson(String str) => List<ModelUser>.from(json.decode(str).map((x) => ModelUser.fromJson(x)));

String modelUserToJson(List<ModelUser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelUser {
  ModelUser({
    this.id,
    this.name,
    this.email,
    this.mobileNumber,
    this.password,
    this.image,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.username,
    this.weight,
    this.height,
    this.status,
    this.dob,
    this.gender,
    this.level,
    this.coins,
    this.steps,
    this.createdOn,
    this.lastActive,
    this.facebookId,
    this.googleId,
    this.loginWith,
    this.referral,
    this.referralCode,
    this.code,
    this.emailVerified,
    this.levelName,
    this.levelDescription,
  });

  int? id;
  String? name;
  String? email;
  String? mobileNumber;
  dynamic password;
  String? image;
  dynamic address;
  dynamic city;
  dynamic state;
  dynamic pincode;
  dynamic username;
  String? weight;
  String? height;
  int? status;
  String? dob;
  String? gender;
  String? level;
  dynamic coins;
  dynamic steps;
  DateTime? createdOn;
  dynamic lastActive;
  dynamic facebookId;
  String? googleId;
  String? loginWith;
  String? referral;
  dynamic referralCode;
  dynamic code;
  String? emailVerified;
  String? levelName;
  String? levelDescription;
  String isFollow="0";


  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobileNumber: json["mobile_number"],
    password: json["password"],
    image: json["image"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
    username: json["username"],
    weight: json["weight"],
    height: json["height"],
    status: json["status"],
    dob: json["dob"],
    gender: json["gender"],
    level: json["level"],
    coins: json["coins"],
    steps: json["steps"],
    createdOn: DateTime.parse(json["created_on"]),
    lastActive: json["last_active"],
    facebookId: json["facebook_id"],
    googleId: json["google_id"],
    loginWith: json["login_with"],
    referral: json["referral"],
    referralCode: json["referral_code"],
    code: json["code"],
    emailVerified: json["email_verified"],
    levelName: json["level_name"],
    levelDescription: json["level_description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile_number": mobileNumber,
    "password": password,
    "image": image,
    "address": address,
    "city": city,
    "state": state,
    "pincode": pincode,
    "username": username,
    "weight": weight,
    "height": height,
    "status": status,
    "dob": dob,
    "gender": gender,
    "level": level,
    "coins": coins,
    "steps": steps,
    "created_on": createdOn.toString(),
    "last_active": lastActive,
    "facebook_id": facebookId,
    "google_id": googleId,
    "login_with": loginWith,
    "referral": referral,
    "referral_code": referralCode,
    "code": code,
    "email_verified": emailVerified,
    "level_name": levelName,
    "level_description": levelDescription,
  };
}
