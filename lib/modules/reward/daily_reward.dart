// @dart=2.9

import 'dart:async';

// import 'package:adcolony/adcolony.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:get/get.dart';
import 'package:sup/controller/dashboard_controller.dart';
import 'package:sup/controller/login_controller.dart';
import 'package:sup/controller/product_controller.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/methods.dart';
import 'package:sup/utils/text_style.dart';

class DailyReward extends StatefulWidget {
  @override
  _DailyRewardState createState() => _DailyRewardState();
}

class _DailyRewardState extends State<DailyReward> {
  DashboardController _dashboardController = Get.find();
  ProductController _productController = Get.find();
  LoginController _loginController = Get.find();

  var isDisableAds = false;

  final zones = [
    'vzf4076424328545b0ba',
  ];

  final _controller = NativeAdmobController();

  AdmobReward rewardAd;
  var isLoadingAd = false;
  var isRewarded = false;
  var isGoogleAdLoaded = false;
  var isAdColonyAdLoaded = false;
  var isBottomSheetOpen = false;

  @override
  void initState() {
    super.initState();
    minutes = int.parse(_dashboardController.modelSetting.value.minutes);
    _controller.setNonPersonalizedAds(true);
    // AdColony.init(AdColonyOptions('app0932d91d148b45178d', '0', this.zones));
    // AdColony.request(zones[0], handleAdcolonyEvent);
    // FlutterApplovinMax.initRewardAd(appLovinReward);
    // setAppLovinAdd();
    loadRewardVideoAd();
  }

  // void setAppLovinAdd() async {
  //   isRewardedVideoAvailable =
  //       await FlutterApplovinMax.isRewardLoaded(listener);
  // }

  // void listener(AppLovinAdListener event) {
  //   print(event);
  //   if (event == AppLovinAdListener.onUserRewarded) {
  //     print('👍get reward');
  //   } else if (event == AppLovinAdListener.adLoaded) {
  //     print("AppLovin : Rewarded Loaded");
  //   } else if (event == AppLovinAdListener.adLoadFailed) {
  //     print("AppLovin : Rewarded Loading Failed");
  //   }
  // }

  // void handleAdcolonyEvent(AdColonyAdListener event) {
  //   print("AdColony: "+event.toString());
  //   if(event == AdColonyAdListener.onRequestFilled){
  //     setState(() {
  //       isLoadingAd = false;
  //       isAdColonyAdLoaded = true;
  //     });
  //   }else if(event == AdColonyAdListener.onRequestNotFilled){
  //     setState(() {
  //       isLoadingAd = false;
  //       isAdColonyAdLoaded = false;
  //     });
  //     loadRewardVideoAd();
  //   }else if(event == AdColonyAdListener.onReward){
  //     _showReward();
  //   }
  // }

  Future<void> loadRewardVideoAd() async {
    await Admob.requestTrackingAuthorization();
    setState(() {
      isLoadingAd = true;
    });
    rewardAd = AdmobReward(
      adUnitId: _dashboardController.modelSetting.value.rewardId.toString(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        setState(() {
          isLoadingAd = false;
        });
        handleAdmobEvent(event, args, "Reward");
      },
    );
    rewardAd.load();
  }

  void handleAdmobEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        setState(() {
          isLoadingAd = false;
          isGoogleAdLoaded = true;
        });
        break;
      case AdmobAdEvent.closed:
        if (isRewarded) {
          _showReward();
        }
        break;
      case AdmobAdEvent.failedToLoad:
        setState(() {
          isLoadingAd = false;
          isGoogleAdLoaded = false;
        });
        break;
      case AdmobAdEvent.rewarded:
        isRewarded = true;
        break;
      default:
    }
  }

  void _showReward() {
    int rewardValue =
        int.parse(_dashboardController.modelHistory.value.reward.toString());
    rewardValue = rewardValue + 1;
    setState(() {
      _dashboardController.modelHistory.value.reward = rewardValue.toString();
    });
    _dashboardController.logTransaction("Reward");
    Future.delayed(Duration(seconds: 1), () {
      _dashboardController.getDashboard();
    });

    isBottomSheetOpen = true;

    showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(color: Colors.black),
              child: new Column(
                children: <Widget>[
                  SizedBox(
                    height: Get.height * 0.10,
                  ),
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 50,
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Text(
                    "Daily Reward Claimed",
                    style: textStyle13.copyWith(
                        color: Colors.white.withOpacity(0.70)),
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/icons/ic_coin.png"),
                        height: iconSize - 5,
                        width: iconSize - 5,
                        fit: BoxFit.contain,
                      ),
                      VerticalDivider(
                        width: 4,
                      ),
                      Text(
                        _loginController.modelUser.value.coins.toString(),
                        style: textStyle14.copyWith(
                            color: Color(0xffEF4723),
                            fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Text(
                    "1 coin has been added to your account",
                    style: textStyle12.copyWith(
                        color: Colors.white.withOpacity(0.70)),
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.20,
                      ),
                      Expanded(
                          child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                            Navigator.of(context).pop({'IsRewarded': "Yes"});
                          },
                          child: Container(
                            height: Get.height * 0.07,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: Color(0xffEF4723).withOpacity(0.60)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                "Yah!",
                                style: textStyle12.copyWith(
                                    color: Color(0xffEF4723).withOpacity(0.60),
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      )),
                      SizedBox(
                        width: Get.width * 0.20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    if (rewardAd != null) {
      rewardAd.dispose();
    }
    super.dispose();
  }

  bool isRewardedVideoAvailable = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(AppBar().preferredSize.height +
                MediaQuery.of(context).padding.top),
            child: Container(
              height: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              color: Colors.black,
              // color: Colors.yellow,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Reward",
                      style: textStyle16.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Material(
                      type: MaterialType.circle,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                          // _showReward();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: Get.width * 0.05),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
        body: Obx(() => Stack(
              children: [
                ListView(
                  children: [
                    Container(
                      height: Get.height,
                      color: Colors.black.withOpacity(0.95),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            child: ListTile(
                              leading: Image(
                                image: AssetImage("assets/icons/ic_reward.png"),
                                width: iconSize + 25,
                                height: iconSize + 25,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                "Daily Rewards",
                                style: textStyle16.copyWith(
                                    fontWeight: FontWeight.w700),
                              ),
                              subtitle: Text(
                                "Notify me about my daily limit,Level and step Rewards progress.",
                                style: textStyle11.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.50)),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Container(
                            height: Get.height * 0.075,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: int.parse(_dashboardController
                                  .modelSetting.value.dailyReward
                                  .toString()),
                              itemBuilder: (context, index) {
                                var arraySize = int.parse(_dashboardController
                                    .modelSetting.value.dailyReward
                                    .toString());
                                return Row(
                                  children: [
                                    VerticalDivider(
                                      width: 16,
                                    ),
                                    Container(
                                      width: Get.width * 0.15,
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 4, right: 4),
                                            decoration: BoxDecoration(
                                                color: int.parse(
                                                            _dashboardController
                                                                .modelHistory
                                                                .value
                                                                .reward
                                                                .toString()) >
                                                        index
                                                    ? Color(0xffEF4723)
                                                    : Colors.white
                                                        .withOpacity(0.10),
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Center(
                                              child: Container(
                                                width: Get.width * 0.11,
                                                height: Get.height * 0.06,
                                                child: Stack(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        (index + 1).toString(),
                                                        style: textStyle15
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                    Image(
                                                      image: AssetImage(
                                                          "assets/icons/ic_coin.png"),
                                                      height: 10,
                                                      width: 8,
                                                      color: int.parse(_dashboardController
                                                                  .modelHistory
                                                                  .value
                                                                  .reward
                                                                  .toString()) >
                                                              index
                                                          ? Colors.white
                                                          : Color(0xffEF4723),
                                                      fit: BoxFit.fill,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Visibility(
                                              visible: int.parse(
                                                          _dashboardController
                                                              .modelHistory
                                                              .value
                                                              .reward
                                                              .toString()) >
                                                      index
                                                  ? true
                                                  : false,
                                              child: Icon(
                                                Icons.check_circle,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    index >= arraySize - 1
                                        ? VerticalDivider(
                                            width: 16,
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return VerticalDivider(
                                  width: 0,
                                );
                              },
                            ),
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          _dashboardController.isTimerActive
                              ? Container(
                                  margin: EdgeInsets.symmetric(horizontal: 32),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                      color: Color(0xffEF4723),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                        child: Text(
                                            _dashboardController
                                                .currentTime.value
                                                .toString(),
                                            style: textStyle12.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600))),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 32),
                                  child: Material(
                                    color: Color(0xffEF4723),
                                    borderRadius: BorderRadius.circular(4),
                                    child: InkWell(
                                      onTap: () async {
                                        if (isGoogleAdLoaded) {
                                          rewardAd.show();
                                        } else {
                                          loadRewardVideoAd();
                                        }
                                        // if(isAdColonyAdLoaded){
                                        //   AdColony.show();
                                        // } else if (isGoogleAdLoaded) {
                                        //   rewardAd.show();
                                        // } else {
                                        //   AdColony.request(zones[0], handleAdcolonyEvent);
                                        // }
                                        // if (isRewardedVideoAvailable) {
                                        //   FlutterApplovinMax.showRewardVideo(
                                        //       (AppLovinAdListener event) =>
                                        //           listener(event));
                                        // }
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        child: Center(
                                          child: isLoadingAd
                                              ? smallWhiteLoader()
                                              : Text(
                                                  "Get Reward".toUpperCase(),
                                                  style: textStyle12.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          isDisableAds
                              ? SizedBox.shrink()
                              : Align(
                                  alignment: Alignment.bottomCenter,
                                  child: AdmobBanner(
                                      adUnitId: _dashboardController
                                          .modelSetting.value.bannerId
                                          .toString(),
                                      adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
                                      listener: (AdmobAdEvent event,
                                          Map<String, dynamic> args) {
                                        print(event.toString());
                                        if (event ==
                                            AdmobAdEvent.failedToLoad) {
                                          setState(() {
                                            isDisableAds = true;
                                          });
                                        }
                                      }))
                          // FacebookNativeAd(
                          //   placementId: _dashboardController
                          //       .modelSetting.value.fbNativeId,
                          //   adType: NativeAdType.NATIVE_AD,
                          //   width: double.infinity,
                          //   backgroundColor: Colors.blue,
                          //   titleColor: Colors.white,
                          //   descriptionColor: Colors.white,
                          //   buttonColor: Colors.deepPurple,
                          //   buttonTitleColor: Colors.white,
                          //   buttonBorderColor: Colors.white,
                          //   listener: (result, value) {
                          //     print("Native Banner Ad: $result --> $value");
                          //   },
                          // ),
                          // NativeAdmob(
                          //     adUnitID: "ca-app-pub-3940256099942544/2247696110"
                          // )

                          // NativeAdmob(
                          //   adUnitID: "ca-app-pub-3940256099942544/2247696110",
                          //   controller: _controller,
                          //   type: NativeAdmobType.full,
                          //   options: NativeAdmobOptions(
                          //     ratingColor: Colors.red,
                          //     // Others ...
                          //   ),
                          // )

                          // Container(
                          //   height: 250,
                          //   child: NativeAdmob(
                          //     adUnitID: "ca-app-pub-3940256099942544/2247696110",  //your ad unit id
                          //     loading: Center(child: CircularProgressIndicator()),
                          //     error: Text("Failed to load the ad",style: TextStyle(color: Colors.white),),
                          //     controller: _controller,
                          //     type: NativeAdmobType.full,
                          //     options: NativeAdmobOptions(
                          //       ratingColor: Colors.red,
                          //       showMediaContent: true,
                          //       callToActionStyle: NativeTextStyle(
                          //           color: Colors.red,
                          //           backgroundColor: Colors.black
                          //       ),
                          //       headlineTextStyle: NativeTextStyle(
                          //         color: Colors.blue,
                          //
                          //       ),
                          //
                          //       // Others ...
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Future<bool> onWillPop() async {
    if (!isBottomSheetOpen) {
      Navigator.of(context).pop({'IsRewarded': "No"});
    } else {
      Navigator.of(context).pop({'IsRewarded': "Yes"});
    }
    return true;
  }
}
