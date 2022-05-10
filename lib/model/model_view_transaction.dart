// @dart=2.9
// To parse this JSON data, do
//
//     final modelViewTransaction = modelViewTransactionFromJson(jsonString);

import 'dart:convert';

List<ModelViewTransaction> modelViewTransactionFromJson(String str) => List<ModelViewTransaction>.from(json.decode(str).map((x) => ModelViewTransaction.fromJson(x)));

String modelViewTransactionToJson(List<ModelViewTransaction> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelViewTransaction {
  ModelViewTransaction({
    this.id,
    this.transactionType,
    this.userId,
    this.time,
    this.createdOn,
    this.coin,
    this.displayDate,
  });

  int id;
  String transactionType;
  dynamic userId;
  dynamic time;
  dynamic createdOn;
  String coin;
  String displayDate;

  factory ModelViewTransaction.fromJson(Map<String, dynamic> json) => ModelViewTransaction(
    id: json["id"],
    transactionType: json["transaction_type"],
    userId: json["user_id"],
    time: json["time"],
    createdOn: json["created_on"],
    coin: json["coin"],
    displayDate: json["display_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_type": transactionType,
    "user_id": userId,
    "time": time,
    "created_on": createdOn,
    "coin": coin,
    "display_date": displayDate,
  };
}
