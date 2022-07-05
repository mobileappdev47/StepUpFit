import 'dart:async';
import 'dart:math';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sup/controller/dashboard_controller.dart';
import 'package:sup/controller/login_controller.dart';
import 'package:sup/modules/reward/daily_reward.dart';
import 'package:sup/modules/reward/extend_limit.dart';
import 'package:sup/modules/reward/level_understanding.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/text_style.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTH_NOT_GRANTED
}

class _HomeTabState extends State<HomeTab> {
  var hideShowAppBar = false;

  var progressValue = 40.0;
  DashboardController _dashboardController = Get.find();
  LoginController _loginController = Get.find();

  late ScrollController _scrollController;
  late double _scrollPosition;

  var _currentStep = 1;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
      if (_scrollPosition > 40) {
        setState(() {
          hideShowAppBar = true;
        });
      } else {
        setState(() {
          hideShowAppBar = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setupAdmob();
    if (_dashboardController.modelSetting.value.minutes != null) {
      minutes = int.parse(_dashboardController.modelSetting.value.minutes);
    } else {
      minutes = 0;
    }
    if (_dashboardController.totalDuration <= minutes) {
      startTimerOnReopen();
    }
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  final interval = const Duration(seconds: 1);

  startTimerOnReopen() async {
    final int timerMaxSeconds =
        ((minutes * 60) - _dashboardController.secondTotalDuration.value);
    var duration = interval;
    if (_dashboardController.timer == null) {
      _dashboardController.timer = Timer.periodic(duration, (t) {
        _dashboardController.currentSeconds.value =
            _dashboardController.timer.tick;
        _dashboardController.currentTime.value =
            '${((timerMaxSeconds - _dashboardController.currentSeconds.value) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - _dashboardController.currentSeconds.value) % 60).toString().padLeft(2, '0')}';
        if (_dashboardController.timer.tick >= timerMaxSeconds) {
          _dashboardController.timer.cancel();
        }
      });
    }
  }

  startTimeout() async {
    final int timerMaxSeconds = minutes * 60;
    var duration = interval;
    _dashboardController.timer = Timer.periodic(duration, (t) {
      _dashboardController.currentSeconds.value =
          _dashboardController.timer.tick;
      _dashboardController.currentTime.value =
          '${((timerMaxSeconds - _dashboardController.currentSeconds.value) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - _dashboardController.currentSeconds.value) % 60).toString().padLeft(2, '0')}';
      if (_dashboardController.timer.tick >= timerMaxSeconds) {
        _dashboardController.timer.cancel();
      }
    });
  }

  var isAdmobLoad = true;
  var isDisableAds = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() => Stack(
            children: [
              Image(
                image: AssetImage("assets/images/ic_home_header_bg.png"),
                width: Get.width,
                height: Get.height * 0.33,
                fit: BoxFit.cover,
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: AnimatedOpacity(
                    opacity: !hideShowAppBar ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 200),
                    child: Image(
                      image: AssetImage("assets/images/ic_line.png"),
                      width: Get.width * 0.80,
                      height: Get.height * 0.30,
                      fit: BoxFit.fill,
                    ),
                  )),
              Padding(
                padding: EdgeInsets.all(16),
                child: ListView(
                  shrinkWrap: true,
                  controller: _scrollController,
                  children: [
                    SizedBox(
                      height: Get.height * 0.10,
                    ),
                    Text(
                      "Today's Progress",
                      style: textStyle12.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Steps",
                                  style: textStyle12.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  _dashboardController.steps.value,
                                  style: textStyle12.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  "K.M.",
                                  style: textStyle12.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  _dashboardController.km.value,
                                  style: textStyle12.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Cal  ",
                                      style: textStyle12.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      _dashboardController
                                                  .modelHistory.value.cal ==
                                              null
                                          ? "0"
                                          : _dashboardController
                                              .modelHistory.value.cal,
                                      style: textStyle12.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.08,
                    ),
                    Text(
                      "Coins by walking",
                      style: textStyle12.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: Get.width * 0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: AssetImage(
                                      "assets/images/ic_man_run.png"),
                                  fit: BoxFit.cover,
                                  height: Get.height * 0.08,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Last Sync On " +
                                      _dashboardController.lastUpdated
                                          .toString(),
                                  style: textStyle11.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage("assets/icons/ic_coin.png"),
                              height: iconSize + 5,
                              width: iconSize + 5,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              _dashboardController
                                          .modelHistory.value.walkingCoins ==
                                      null
                                  ? "0"
                                  : _dashboardController
                                      .modelHistory.value.walkingCoins
                                      .toString(),
                              style: textStyle20.copyWith(
                                  color: Color(0xffEF4723),
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        )),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    // _loginController.modelUser.value.level == "1"
                    //     ? SizedBox.shrink()
                    //     :
                    Container(
                      width: Get.width,
                      height: Get.height * 0.08,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      // color: Colors.white,
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i = 0;
                                  i < _dashboardController.coinLimit.value;
                                  i++)
                                Expanded(
                                    child: TimelineTile(
                                  axis: TimelineAxis.horizontal,
                                  alignment: TimelineAlign.center,
                                  isFirst: i == 0 ? true : false,
                                  beforeLineStyle: LineStyle(
                                    color: i <
                                            int.parse(_dashboardController
                                                .modelHistory
                                                .value
                                                .walkingCoins)
                                        ? Color(0xffEF4723)
                                        : Colors.grey,
                                    thickness: 6,
                                  ),
                                  indicatorStyle: IndicatorStyle(
                                    height: iconSize,
                                    indicatorXY: 0.0,
                                    indicator: i == 0
                                        ? Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xffEF4723)),
                                            child: i > 0
                                                ? i >
                                                        int.parse(
                                                            _dashboardController
                                                                .modelHistory
                                                                .value
                                                                .walkingCoins)
                                                    ? SizedBox.shrink()
                                                    : Icon(
                                                        Icons.done,
                                                        size: 15,
                                                        color: Colors.white,
                                                      )
                                                : SizedBox.shrink(),
                                          )
                                        : SizedBox.shrink(),
                                    color: i == 0
                                        ? Color(0xffEF4723)
                                        : i <
                                                int.parse(_dashboardController
                                                    .modelHistory
                                                    .value
                                                    .walkingCoins)
                                            ? Color(0xffEF4723)
                                            : Colors.grey,
                                  ),
                                )),
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffEF4723)),
                                child: Center(
                                  child: Icon(
                                    Icons.star_border,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          _loginController.modelUser.value.level == "1"
                              ? SizedBox.shrink()
                              : Center(
                                  child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _dashboardController.modelHistory
                                                  .value.walkingCoins ==
                                              null
                                          ? Colors.grey
                                          : int.parse(_dashboardController
                                                      .modelHistory
                                                      .value
                                                      .walkingCoins) >=
                                                  int.parse(_dashboardController
                                                          .modelHistory
                                                          .value
                                                          .coinLimit) /
                                                      2
                                              ? Color(0xffEF4723)
                                              : Colors.grey),
                                  child: Center(
                                    child: Icon(
                                      Icons.done,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ))
                          // Center(child: Container(width: 3,height: 50,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(4)),))
                        ],
                      ),
                    ),

                    _loginController.modelUser.value.level == "1"
                        ? SizedBox.shrink()
                        : SizedBox(
                            height: Get.height * 0.03,
                          ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Row(
                              children: [
                                Text(
                                  _loginController.modelUser.value.levelName
                                      .toString(),
                                  style: textStyle12.copyWith(
                                      color: Color(0xffEF4723),
                                      fontWeight: FontWeight.w700),
                                ),
                                Spacer(),
                                Material(
                                  color: Colors.transparent,
                                  type: MaterialType.circle,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(LevelUnderStanding());
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/icons/ic_next.png"),
                                        width: iconSize - 10,
                                        height: iconSize - 10,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: Text(
                              _loginController.modelUser.value.levelDescription
                                  .toString(),
                              style: textStyle12.copyWith(
                                  color: Color(0xffC4C4C4), fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Container(
                      color: Colors.white.withOpacity(0.20),
                      width: Get.width,
                      height: 0.5,
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
                            })),
                    Container(
                      color: Colors.white.withOpacity(0.20),
                      width: Get.width,
                      height: 0.5,
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        minHeight: Get.height * 0.20,
                        maxHeight: Get.height * 0.25,
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: Get.width * 0.80,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    "Daily Rewards",
                                    style: textStyle12.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: _dashboardController.modelSetting
                                                  .value.rewardDescription ==
                                              null
                                          ? "Earn 5 coins extra by claiming them all"
                                          : _dashboardController.modelSetting
                                              .value.rewardDescription
                                              .toString(),
                                      style: textStyle12.copyWith(
                                          color: Color(0xffC4C4C4),
                                          fontSize: 14),
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      height: Get.height * 0.05,
                                      padding: EdgeInsets.only(left: 16),
                                      child: ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _dashboardController
                                                    .modelSetting
                                                    .value
                                                    .dailyReward ==
                                                null
                                            ? 5
                                            : int.parse(_dashboardController
                                                .modelSetting.value.dailyReward
                                                .toString()),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: _dashboardController
                                                                .modelHistory
                                                                .value
                                                                .reward ==
                                                            null
                                                        ? Color(0xff707070)
                                                        : int.parse(_dashboardController
                                                                    .modelHistory
                                                                    .value
                                                                    .reward
                                                                    .toString()) >
                                                                index
                                                            ? Color(0xff55322A)
                                                            : Color(0xff707070)
                                                                .withOpacity(
                                                                    0.50)),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: iconSize - 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            width: 4,
                                          );
                                        },
                                      ),
                                    )),
                                    _dashboardController
                                                .modelHistory.value.reward ==
                                            null
                                        ? SizedBox.shrink()
                                        : int.parse(_dashboardController
                                                    .modelHistory.value.reward
                                                    .toString()) ==
                                                int.parse(_dashboardController
                                                    .modelSetting
                                                    .value
                                                    .dailyReward
                                                    .toString())
                                            ? SizedBox.shrink()
                                            : Material(
                                                color: Color(0xffEF4723),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (_dashboardController
                                                            .timer ==
                                                        null) {
                                                      Map<String, String>
                                                          results =
                                                          await Navigator.of(
                                                                  context)
                                                              .push(
                                                                  new MaterialPageRoute<
                                                                      dynamic>(
                                                        builder: (BuildContext
                                                            context) {
                                                          return new DailyReward();
                                                        },
                                                      ));

                                                      if (results[
                                                              'IsRewarded'] ==
                                                          "Yes") {
                                                        if (int.parse(
                                                                _dashboardController
                                                                    .modelHistory
                                                                    .value
                                                                    .reward
                                                                    .toString()) !=
                                                            int.parse(
                                                                _dashboardController
                                                                    .modelSetting
                                                                    .value
                                                                    .dailyReward
                                                                    .toString())) {
                                                          setState(() {
                                                            startTimeout();
                                                          });
                                                        }
                                                      }
                                                    } else if (_dashboardController
                                                                .timer !=
                                                            null &&
                                                        !_dashboardController
                                                            .timer.isActive) {
                                                      Map<String, String>
                                                          results =
                                                          await Navigator.of(
                                                                  context)
                                                              .push(
                                                                  new MaterialPageRoute<
                                                                      dynamic>(
                                                        builder: (BuildContext
                                                            context) {
                                                          return new DailyReward();
                                                        },
                                                      ));

                                                      if (results[
                                                              'IsRewarded'] ==
                                                          "Yes") {
                                                        if (int.parse(
                                                                _dashboardController
                                                                    .modelHistory
                                                                    .value
                                                                    .reward
                                                                    .toString()) !=
                                                            int.parse(
                                                                _dashboardController
                                                                    .modelSetting
                                                                    .value
                                                                    .dailyReward
                                                                    .toString())) {
                                                          setState(() {
                                                            startTimeout();
                                                          });
                                                        }
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 8),
                                                    child: Text(
                                                      _dashboardController
                                                                  .totalDuration >
                                                              minutes
                                                          ? "Get Reward"
                                                          : _dashboardController
                                                                      .timer ==
                                                                  null
                                                              ? "Get Reward"
                                                                  .toUpperCase()
                                                              : _dashboardController
                                                                      .timer
                                                                      .isActive
                                                                  ? _dashboardController
                                                                      .currentTime
                                                                      .toUpperCase()
                                                                  : "Get Reward"
                                                                      .toUpperCase(),
                                                      style:
                                                          textStyle12.copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                    VerticalDivider(color: Colors.transparent)
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                          VerticalDivider(color: Colors.transparent),
                          Container(
                            width: Get.width * 0.80,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    "Limit Extensions",
                                    style: textStyle12.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 16, right: 16),
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text: _dashboardController
                                                    .modelSetting
                                                    .value
                                                    .extensionDescription ==
                                                null
                                            ? "Your coin limit will be extended for today\r\n\r\nStepupfit  DOES NOT reward you directly, through extension you can earn more by walking"
                                            : _dashboardController.modelSetting
                                                .value.extensionDescription
                                                .toString(),
                                        style: textStyle12.copyWith(
                                            color: Color(0xffC4C4C4),
                                            fontSize: 14),
                                      ),
                                      maxLines: 2,
                                    )),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      height: Get.height * 0.05,
                                      padding: EdgeInsets.only(left: 16),
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _dashboardController
                                                    .modelSetting
                                                    .value
                                                    .dailyExtension ==
                                                null
                                            ? 5
                                            : int.parse(_dashboardController
                                                .modelSetting
                                                .value
                                                .dailyExtension
                                                .toString()),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: _dashboardController
                                                                .modelHistory
                                                                .value
                                                                .extension ==
                                                            null
                                                        ? Color(0xff707070)
                                                        : int.parse(_dashboardController
                                                                    .modelHistory
                                                                    .value
                                                                    .extension
                                                                    .toString()) >
                                                                index
                                                            ? Color(0xff55322A)
                                                            : Color(0xff707070)
                                                                .withOpacity(
                                                                    0.50)),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: iconSize - 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            width: 4,
                                          );
                                        },
                                      ),
                                    )),
                                    _dashboardController.modelSetting.value
                                                .dailyExtension ==
                                            null
                                        ? SizedBox.shrink()
                                        : int.parse(_dashboardController
                                                    .modelSetting
                                                    .value
                                                    .dailyExtension
                                                    .toString()) ==
                                                int.parse(_dashboardController
                                                    .modelHistory
                                                    .value
                                                    .extension
                                                    .toString())
                                            ? SizedBox.shrink()
                                            : Material(
                                                color: Color(0xffEF4723),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.to(ExtendLimit());
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 8),
                                                    child: Text(
                                                      "Extend".toUpperCase(),
                                                      style:
                                                          textStyle11.copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                    VerticalDivider(color: Colors.transparent)
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    // Container(
                    //   color: Colors.white.withOpacity(0.20),
                    //   width: Get.width,
                    //   height: 0.5,
                    // ),
                    // SizedBox(
                    //   height: Get.height * 0.02,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "Your past 7 days",
                    //       style: textStyle12.copyWith(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.w500),
                    //     ),
                    //     Material(
                    //       color: Colors.transparent,
                    //       child: InkWell(
                    //         onTap: () {
                    //           Get.to(StepHistory());
                    //         },
                    //         child: Padding(
                    //           padding: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                    //           child: Text(
                    //             "View History",
                    //             style: textStyle12.copyWith(
                    //                 color: Color(0xffEF4723),
                    //                 fontWeight: FontWeight.w600),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: Get.height * 0.03,
                    // ),
                    // BarChartSample3(),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                color: hideShowAppBar ? Colors.black : Colors.transparent,
                constraints: BoxConstraints(
                    minHeight: Get.height * 0.08, maxHeight: Get.height * 0.16),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        Text(
                          "Welcome,",
                          style:
                              textStyle16.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Hi, " +
                              _loginController.modelUser.value.name.toString(),
                          style:
                              textStyle14.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Spacer(),
                    // Material(
                    //   type: MaterialType.circle,
                    //   clipBehavior: Clip.antiAliasWithSaveLayer,
                    //   color: Colors.transparent,
                    //   child: InkWell(
                    //     onTap: () {
                    //       Get.to(NotificationList());
                    //     },
                    //     child: Padding(
                    //       padding: EdgeInsets.all(16),
                    //       child:Image(
                    //         image:
                    //         AssetImage("assets/icons/ic_notification.png"),
                    //         width: iconSize - 5,
                    //         height: iconSize - 5,
                    //         fit: BoxFit.cover,
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              isDisableAds
                  ? SizedBox.shrink()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: AdmobBanner(
                          adUnitId: _dashboardController
                              .modelSetting.value.bannerId
                              .toString(),
                          adSize: AdmobBannerSize.SMART_BANNER(context),
                          listener:
                              (AdmobAdEvent event, Map<String, dynamic>? args) {
                            print(event.toString());
                            if (event == AdmobAdEvent.failedToLoad) {
                              setState(() {
                                isDisableAds = true;
                              });
                            }
                          })

                      // FacebookBannerAd(
                      //         placementId: _dashboardController
                      //             .modelSetting.value.fbBannerId,
                      //         bannerSize: BannerSize.STANDARD,
                      //         listener: (result, value) {
                      //           switch (result) {
                      //             case BannerAdResult.ERROR:
                      //               print("Error: $value");
                      //               setState(() {
                      //                 isDisableAds = true;
                      //               });
                      //               break;
                      //             case BannerAdResult.LOADED:
                      //               print("Loaded: $value");
                      //               break;
                      //             case BannerAdResult.CLICKED:
                      //               print("Clicked: $value");
                      //               break;
                      //             case BannerAdResult.LOGGING_IMPRESSION:
                      //               print("Logging Impression: $value");
                      //               break;
                      //           }
                      //         },
                      //       )
                      ),
            ],
          )),
    );
  }

  double getRandomNumber() {
    Random random = new Random();
    int min = 1, max = 1000;
    return (min + random.nextInt(max - min)) * random.nextDouble();
  }

  String getName(index) {
    String dayName = "";
    if (index == 0) {
      dayName = "M";
    } else if (index == 1) {
      dayName = "T";
    } else if (index == 2) {
      dayName = "W";
    } else if (index == 3) {
      dayName = "T";
    } else if (index == 4) {
      dayName = "F";
    } else if (index == 5) {
      dayName = "S";
    } else if (index == 6) {
      dayName = "S";
    }
    return dayName;
  }

  Future<void> setupAdmob() async {
    await Admob.requestTrackingAuthorization();
  }
}
