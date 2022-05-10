// @dart=2.9

// To parse this JSON data, do
//
//     final modelSearch = modelSearchFromJson(jsonString);

import 'dart:convert';

List<ModelSearch> modelSearchFromJson(String str) => List<ModelSearch>.from(json.decode(str).map((x) => ModelSearch.fromJson(x)));

String modelSearchToJson(List<ModelSearch> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelSearch {
  ModelSearch({
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
  });

  int id;
  String name;
  String email;
  String mobileNumber;
  String password;
  String image;
  dynamic address;
  dynamic city;
  dynamic state;
  dynamic pincode;
  dynamic username;
  String weight;
  String height;
  int status;
  DateTime dob;
  String gender;
  String level;
  dynamic coins;
  dynamic steps;
  DateTime createdOn;
  dynamic lastActive;
  String facebookId;
  String googleId;
  String loginWith;
  String referral;
  String referralCode;
  String code;
  String emailVerified;
  String isFollow="0";

  factory ModelSearch.fromJson(Map<String, dynamic> json) => ModelSearch(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobileNumber: json["mobile_number"] == null ? null : json["mobile_number"],
    password: json["password"] == null ? null : json["password"],
    image: json["image"] == null ? null : json["image"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
    username: json["username"],
    weight: json["weight"] == null ? null : json["weight"],
    height: json["height"] == null ? null : json["height"],
    status: json["status"],
    dob: json["dob"],
    gender: json["gender"] == null ? null : json["gender"],
    level: json["level"],
    coins: json["coins"],
    steps: json["steps"],
    createdOn: DateTime.parse(json["created_on"]),
    lastActive: json["last_active"],
    facebookId: json["facebook_id"] == null ? null : json["facebook_id"],
    googleId: json["google_id"] == null ? null : json["google_id"],
    loginWith: json["login_with"],
    referral: json["referral"] == null ? null : json["referral"],
    referralCode: json["referral_code"] == null ? null : json["referral_code"],
    code: json["code"] == null ? null : json["code"],
    emailVerified: json["email_verified"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile_number": mobileNumber == null ? null : mobileNumber,
    "password": password == null ? null : password,
    "image": image == null ? null : image,
    "address": address,
    "city": city,
    "state": state,
    "pincode": pincode,
    "username": username,
    "weight": weight == null ? null : weight,
    "height": height == null ? null : height,
    "status": status,
    "dob": dob == null ? null : "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "gender": gender == null ? null : gender,
    "level": level,
    "coins": coins,
    "steps": steps,
    "created_on": createdOn.toIso8601String(),
    "last_active": lastActive,
    "facebook_id": facebookId == null ? null : facebookId,
    "google_id": googleId == null ? null : googleId,
    "login_with": loginWith,
    "referral": referral == null ? null : referral,
    "referral_code": referralCode == null ? null : referralCode,
    "code": code == null ? null : code,
    "email_verified": emailVerified,
  };
}
