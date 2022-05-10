// @dart=2.9

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sup/controller/friend_controller.dart';
import 'package:sup/controller/history_controller.dart';
import 'package:sup/controller/login_controller.dart';
import 'package:sup/model/model_friend.dart';
import 'package:sup/model/model_history.dart';
import 'package:sup/model/model_setting.dart';
import 'package:sup/model/model_user.dart';
import 'package:sup/model/model_view_transaction.dart';
import 'package:sup/model/model_week_history.dart';
import 'package:sup/utils/constant_key.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/request.dart';
import 'package:sup/utils/shared_preference.dart';

class DashboardController extends GetxController{
  var steps="0".obs;
  var km="0".obs;
  var cal="0".obs;
  var coins="0".obs;
  var lastUpdated="".obs;
  var safePoints="0".obs;

  var totalDuration=0.obs;
  var secondTotalDuration=0.obs;
  var currentSeconds = 0.obs;
  var currentTime = "".obs;
  var selectedTab = 0.obs;

  var isDashboardLoading = false.obs;
  var isTransactionLogging = false.obs;
  var isViewTransactionLoading = false.obs;

  var coinLimit = 0.obs;
  var todayCoin = 0.obs;

  Timer timer;
  bool isTimerActive = false;

  LoginController _loginController = Get.put(LoginController());
  FriendController _friendController = Get.put(FriendController());
  HistoryController _historyController = Get.put(HistoryController());

  var modelHistory = ModelHistory().obs;
  var modelSetting=ModelSetting().obs;

  // RxList arrOfTransaction = [].obs;
  var arrOfTransaction = List<ModelViewTransaction>().obs;

  var currentBalance=0.obs;
  var totalBalance=0.obs;
  var spentBalance=0.obs;

  updateKiloMeter(todaySteps) async {
    var data=double.parse(todaySteps)/1312.14;
    km.value=data.toStringAsFixed(1);
    await addStringToSF(KEY_KM, data.toStringAsFixed(1));
    syncStep(todaySteps);
  }

  @override
  void onInit() async{
    steps.value=await getStringValuesSF(KEY_STEP) ?? "0";
    km.value=await getStringValuesSF(KEY_KM) ?? "0";
    super.onInit();
  }

  void getDashboard() async {
    if(_loginController.modelUser.value.email==null){
      isDashboardLoading.value=true;
    }else{
      isDashboardLoading.value=false;
    }

    Request request = Request(url: urlDashboard, body: {
      'type': "API",
      'user_id': userId.toString(),
    });

    request.post().then((value) {
      final responseData = json.decode(value.body);
      isDashboardLoading.value = false;

      _loginController.modelUser.value =
          ModelUser.fromJson(responseData['data']);
      print(jsonEncode(_loginController.modelUser.value));
      modelHistory.value = ModelHistory.fromJson(responseData['history']);
      print(jsonEncode(modelHistory.value));
      modelSetting.value = ModelSetting.fromJson(responseData['setting']);
      print(jsonEncode(modelSetting.value));

      minutes = int.parse(modelSetting.value.minutes);

      _friendController.arrOfFriend.assignAll((responseData['friends'] as List)
          .map((data) => ModelFriend.fromJson(data))
          .toList());

      maxStep = responseData['maxSteps'];
      steps.value = modelHistory.value.steps.toString();
      km.value = modelHistory.value.km.toString();
      cal.value = modelHistory.value.cal.toString();

      if(modelHistory.value.coins!=null){
          coins.value=modelHistory.value.coins.toString();
        }else{
          coins.value="";
        }


        safePoints.value=responseData['safe_points'];
        totalDuration.value=responseData['totalDuration'];
        secondTotalDuration.value=responseData['secondTotalDuration'];





        _historyController.arrOfWeekHistory.value=(responseData['week_history'] as List)
            .map((data) => ModelWeekHistory.fromJson(data))
            .toList();

        _friendController.arrOfFollowing.value=(responseData['following'] as List)
            .map((data) => ModelUser.fromJson(data))
            .toList();

        _friendController.arrOfFollower.value=(responseData['followers'] as List)
            .map((data) => ModelUser.fromJson(data))
            .toList();

        coinLimit.value=int.parse(modelHistory.value.coinLimit.toString());
        todayCoin.value=int.parse(modelHistory.value.coins.toString());

      }
    ).catchError((onError) {
      isDashboardLoading.value=false;
      print("Dashboard Error : Can't reach to server.");
      print(onError);
    });
  }

  void syncStep(todaySteps) async {
    lastUpdated.value = DateFormat.jm().format(DateTime.now());

    Request request = Request(url: urlUpdateStep, body: {
      'type': "API",
      'user_id': userId.toString(),
      'steps': todaySteps.toString(),
      'km': km.value.toString(),
      'cal': cal.value.toString(),
    });

    request.post().then((value) {
      final responseData = json.decode(value.body);
      getDashboard();
      print(responseData['message']);
    }).catchError((onError) {
      print("Can't reach to server.");
      print(onError);
    });
  }

  void logTransaction(transactionType) async {
    String currentTime = DateTime.now().millisecondsSinceEpoch.toString();

    isTransactionLogging.value=true;
    Request request = Request(url: urlLogTransaction, body: {
      'type': "API",
      'user_id': userId.toString(),
      'transaction_type': transactionType.toString(),
      'time': currentTime.toString(),
    });

    request.post().then((value) {
      isTransactionLogging.value=false;
      final responseData = json.decode(value.body);
      print(responseData['message']);
    }).catchError((onError) {
      isTransactionLogging.value=false;
      print("Can't reach to server.");
      print(onError);
    });
  }

  void viewTransaction() async {
    isViewTransactionLoading.value=true;
    Request request = Request(url: urlViewTransaction, body: {
      'type': "API",
      'user_id': userId.toString(),
    });

    request.post().then((value) {
      isViewTransactionLoading.value=false;
      final responseData = json.decode(value.body);
      currentBalance.value=responseData['available_coins'];
      totalBalance.value=responseData['total_coins'];
      spentBalance.value = responseData['redeem_coins'];
      arrOfTransaction.assignAll((responseData['data'] as List)
          .map((data) => ModelViewTransaction.fromJson(data))
          .toList());
    }).catchError((onError) {
      isViewTransactionLoading.value = false;
      print("Can't reach to server.");
      print(onError);
    });
  }

  Future<void> tokenUpdate(String token) async {
    debugPrint("FCM Token : " + token);
    debugPrint("User Id : " + userId);

    Request request = Request(url: fcmTokenUpdate, body: {
      'type': "API",
      'user_id': userId,
      'token': token,
    });
    request.post().then((value) {
      final responseData = json.decode(value.body);

      debugPrint("Token Response : " + responseData['message']);
    }).catchError((onError) {
      debugPrint("Token Error Response : " + onError.toString());
      print(onError);
    });
  }
}