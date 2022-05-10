// To parse this JSON data, do
//
//     final modelContact = modelContactFromJson(jsonString);

import 'dart:convert';

List<ModelContact> modelContactFromJson(String str) => List<ModelContact>.from(json.decode(str).map((x) => ModelContact.fromJson(x)));

String modelContactToJson(List<ModelContact> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelContact {
  ModelContact({
    required this.name,
    required this.mobileNumber,
  });

  String name;
  String mobileNumber;

  factory ModelContact.fromJson(Map<String, dynamic> json) => ModelContact(
    name: json["name"],
    mobileNumber: json["mobile_number"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile_number": mobileNumber,
  };
}
