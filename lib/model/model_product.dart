// To parse this JSON data, do
//
//     final modelProduct = modelProductFromJson(jsonString);

import 'dart:convert';

List<ModelProduct> modelProductFromJson(String str) => List<ModelProduct>.from(json.decode(str).map((x) => ModelProduct.fromJson(x)));

String modelProductToJson(List<ModelProduct> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelProduct {
  ModelProduct({
    this.id,
    this.name,
    this.shortDescription,
    this.description,
    this.image,
    this.coins,
    this.rank,
    this.mrp,
    this.website,
    this.video,
    this.brandName,
    this.brandLogo,
    this.aboutBrand,
    this.status,
    this.createdOn,
  });

  int? id;
  String? name;
  String? shortDescription;
  String? description;
  String? image;
  String? coins;
  String? rank;
  String? mrp;
  String? website;
  String? video;
  String? brandName;
  String? brandLogo;
  String? aboutBrand;
  int? status;
  DateTime? createdOn;

  factory ModelProduct.fromJson(Map<String, dynamic> json) => ModelProduct(
    id: json["id"],
    name: json["name"],
    shortDescription: json["short_description"],
    description: json["description"],
    image: json["image"],
    coins: json["coins"],
    rank: json["rank"],
    mrp: json["mrp"],
    website: json["website"],
    video: json["video"],
    brandName: json["brand_name"],
    brandLogo: json["brand_logo"],
    aboutBrand: json["about_brand"],
    status: json["status"],
    createdOn: DateTime.parse(json["created_on"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "short_description": shortDescription,
    "description": description,
    "image": image,
    "coins": coins,
    "rank": rank,
    "mrp": mrp,
    "website": website,
    "video": video,
    "brand_name": brandName,
    "brand_logo": brandLogo,
    "about_brand": aboutBrand,
    "status": status,
    "created_on": createdOn.toString(),
  };
}
