// @dart=2.9

// import 'package:adcolony/adcolony.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sup/controller/dashboard_controller.dart';
import 'package:sup/controller/login_controller.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/methods.dart';
import 'package:sup/utils/text_style.dart';

class ExtendLimit extends StatefulWidget {
  @override
  _ExtendLimitState createState() => _ExtendLimitState();
}

class _ExtendLimitState extends State<ExtendLimit> {
  var hideShowAppBar = false;

  DashboardController _dashboardController = Get.find();
  LoginController _loginController = Get.find();

  @override
  void initState() {
    // AdColony.init(AdColonyOptions('app0932d91d148b45178d', '0', this.zones));
    // AdColony.request(this.zones[0], handleAdcolonyEvent);
    loadRewardVideoAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));

    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    brightness: Brightness.dark,
                    title: Text(
                      "",
                      style: textStyle12.copyWith(color: Colors.white),
                    ),
                    expandedHeight: 250,
                    elevation: 0,
                    pinned: true,
                    floating: true,
                    backgroundColor: Colors.black,
                    leading: Container(),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Container(
                          height: 240,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      width: Get.width * 0.20,
                                      height: Get.width * 0.20,
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                          "assets/icons/ic_friends_coin.png"),
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 32),
                                      child: Text(
                                        "Extend your coin Limit today by 1 more SUP Coin",
                                        style: textStyle14,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "Current Limit",
                                        style: textStyle12,
                                      ),
                                      Divider(
                                        color: Colors.transparent,
                                      ),
                                      Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                "assets/icons/ic_coin.png"),
                                            height: iconSize,
                                            width: iconSize,
                                            fit: BoxFit.contain,
                                          ),
                                          VerticalDivider(
                                            width: 4,
                                          ),
                                          Text(
                                            _dashboardController.modelHistory
                                                    .value.extension
                                                    .toString() +
                                                ".00",
                                            style: textStyle14.copyWith(
                                                color: Color(0xffEF4723)),
                                          )
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.transparent,
                                        height: 10,
                                      ),
                                      Container(
                                        height: 2,
                                        width: Get.width * 0.20,
                                        color:
                                            Color(0xffEF4723).withOpacity(0.30),
                                      )
                                    ],
                                  )),
                                  Expanded(
                                      child: Center(
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
                                    ),
                                  )),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Extend Limit",
                                        style: textStyle12,
                                      ),
                                      Divider(
                                        color: Colors.transparent,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                "assets/icons/ic_coin.png"),
                                            height: iconSize,
                                            width: iconSize,
                                            fit: BoxFit.contain,
                                          ),
                                          VerticalDivider(
                                            width: 4,
                                          ),
                                          Text(
                                            (int.parse(_dashboardController
                                                            .modelHistory
                                                            .value
                                                            .extension
                                                            .toString()) +
                                                        1)
                                                    .toString() +
                                                ".00",
                                            style: textStyle14.copyWith(
                                                color: Color(0xffEF4723)),
                                          )
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.transparent,
                                        height: 10,
                                      ),
                                      Container(
                                        height: 2,
                                        width: Get.width * 0.20,
                                        color:
                                            Color(0xffEF4723).withOpacity(0.30),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                              Divider(color: Colors.transparent),
                              Divider(color: Colors.transparent),
                              Container(
                                height: 1,
                                color: Colors.white.withOpacity(0.08),
                              ),
                              Divider(color: Colors.transparent),
                              Text(
                                "Important Note:",
                                style: textStyle14.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              Divider(color: Colors.transparent),
                              Text(
                                _dashboardController
                                    .modelSetting.value.extensionDescription
                                    .toString(),
                                style: textStyle12.copyWith(
                                    color: Colors.white.withOpacity(0.60),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              ),
              Container(
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                color: hideShowAppBar ? Colors.black : Colors.transparent,
                height: AppBar().preferredSize.height,
                child: Row(
                  children: [
                    Material(
                      type: MaterialType.circle,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: Get.width * 0.05),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: Get.height * 0.15,
                      padding: EdgeInsets.only(right: 16, bottom: 16, left: 16),
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                if (isGoogleAdLoaded) {
                                  rewardAd.show();
                                } else {
                                  loadRewardVideoAd();
                                }
                                // if (isAdColonyAdLoaded){
                                //   AdColony.show();
                                // }else if (isGoogleAdLoaded) {
                                //   rewardAd.show();
                                // } else if (isAdColonyAdLoaded) {
                                //   AdColony.show();
                                // }
                              },
                              child: Container(
                                height: Get.height * 0.07,
                                decoration: BoxDecoration(
                                  color: Color(0xffEF4723),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: isLoadingAd
                                      ? smallWhiteLoader()
                                      : Text(
                                          "Extend Limit",
                                          style: textStyle12.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 4,
                          ),
                          Text(
                            "You will show an ad",
                            style: textStyle10.copyWith(
                                color: Colors.white.withOpacity(0.50)),
                          ),
                        ],
                      )))
            ],
          ),
        ));
  }

  AdmobReward rewardAd;
  var isLoadingAd = true;
  var isGoogleAdLoaded = false;

  Future<void> loadRewardVideoAd() async {
    await Admob.requestTrackingAuthorization();

    setState(() {
      isLoadingAd = true;
    });
    rewardAd = AdmobReward(
      adUnitId:
          _dashboardController.modelSetting.value.rewardId.replaceAll(" ", ""),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        setState(() {
          isLoadingAd = false;
        });
        handleAdmobEvent(event, args, "Reward");
      },
    );
    rewardAd.load();
  }

  var isRewarded = false;

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
    int extendValue =
        int.parse(_dashboardController.modelHistory.value.extension.toString());
    extendValue = extendValue + 1;
    setState(() {
      _dashboardController.modelHistory.value.extension =
          extendValue.toString();
    });
    _dashboardController.logTransaction("Extension");
    Future.delayed(Duration(seconds: 1), () {
      _dashboardController.getDashboard();
    });

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
                    "Extension Has been Added",
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
                    "1 coin has been added to your coin limit",
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
                            Get.back();
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
}
