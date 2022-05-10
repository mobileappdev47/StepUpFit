// @dart=2.9

import 'dart:convert';

import 'package:get/get.dart';
import 'package:sup/model/model_week_history.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/request.dart';

class HistoryController extends GetxController {
  var isLoadingHistory = false.obs;
  var isLoadingMonthHistory = false.obs;

  var steps = "0".obs;
  var coins = "0".obs;
  var km = "0".obs;
  var calories = "0".obs;

  var arrOfWeekHistory = List<ModelWeekHistory>().obs;
  var arrOfMonthHistory = List<ModelWeekHistory>().obs;

  void viewWeekHistory() async {
    if (arrOfWeekHistory.isEmpty) {
      isLoadingHistory.value = true;
    } else {
      isLoadingHistory.value = false;
    }

    Request request = Request(url: urlWeekHistory, body: {
      'type': "API",
      'user_id': userId.toString(),
    });

    request.post().then((value) {
      isLoadingHistory.value = false;
      final responseData = json.decode(value.body);
      steps.value = responseData['steps'];
      coins.value = responseData['coins'];
        km.value = responseData['km'];
        calories.value = responseData['cal'];

        arrOfWeekHistory.assignAll((responseData['weekDate'] as List)
            .map((data) => ModelWeekHistory.fromJson(data))
            .toList());
    }).catchError((onError) {
        isLoadingHistory.value = false;
        print("Can't reach to server.");
        print(onError);
      });
  }

  void viewMonthHistory(month, year) async {
    isLoadingMonthHistory.value = true;
    Request request = Request(url: urlMonthHistory, body: {
      'type': "API",
      'month': month.toString(),
      'year': year.toString(),
      'user_id': userId.toString(),
    });

    request.post().then((value) {
      isLoadingMonthHistory.value = false;
      final responseData = json.decode(value.body);
      steps.value = responseData['steps'];
      coins.value = responseData['coins'];
      km.value = responseData['km'];
      calories.value = responseData['cal'];

      arrOfMonthHistory.assignAll((responseData['monthDate'] as List)
          .map((data) => ModelWeekHistory.fromJson(data))
          .toList());
    }).catchError((onError) {
      isLoadingMonthHistory.value = false;
      print("Can't reach to server.");
      print(onError);
    });
  }
}
