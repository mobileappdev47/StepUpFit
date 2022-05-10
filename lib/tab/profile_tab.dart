import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sup/controller/dashboard_controller.dart';
import 'package:sup/controller/friend_controller.dart';
import 'package:sup/controller/history_controller.dart';
import 'package:sup/controller/login_controller.dart';
import 'package:sup/model/model_week.dart';
import 'package:sup/modules/graph/step_history.dart';
import 'package:sup/modules/graph/weekly_chart_two.dart';
import 'package:sup/modules/profile/follower_following.dart';
import 'package:sup/modules/profile/setting.dart';
import 'package:sup/modules/profile/view_transaction.dart';
import 'package:sup/page/shop_products.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/methods.dart';
import 'package:sup/utils/text_style.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  var hideShowAppBar = false;

  List<ModelWeek> arrOfWeek = [];

  DashboardController _dashboardController = Get.find();
  LoginController _loginController = Get.find();
  HistoryController _historyController = Get.find();
  FriendController _friendController = Get.find();

  var isAdmobLoad = true;
  var isDisableAds = false;

  @override
  void initState() {
    _historyController.viewWeekHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.black,
            /* set Status bar color in Android devices. */
            statusBarIconBrightness: Brightness.light,
            /* set Status bar icons color in Android devices.*/
            statusBarBrightness:
                Brightness.light) /* set Status bar icon color in iOS. */
        );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() => Stack(
            children: [
              Container(
                color: Colors.black,
                height: Get.height,
                width: Get.width,
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.10),
                child: Image(
                  image: AssetImage("assets/images/ic_profile_header_bg.png"),
                  width: Get.width,
                  height: Get.height * 0.33,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: NotificationListener<ScrollUpdateNotification>(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                      Container(
                        color: Colors.transparent,
                        constraints: BoxConstraints(
                            minHeight: Get.height * 0.20,
                            maxHeight: Get.height * 0.30),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: Get.height * 0.05),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.06,
                                  ),
                                  Text(
                                    _loginController.modelUser.value.name
                                        .toString()
                                        .toUpperCase(),
                                    style: textStyle14.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.03,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              Get.to(FollowerFollowing(0));
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  _friendController
                                                      .arrOfFollower.length
                                                      .toString(),
                                                  style: textStyle12.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  "Followers",
                                                  style: textStyle12.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white.withOpacity(0.40),
                                        width: 1,
                                        height: 50,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "LEVEL".toUpperCase(),
                                              style: textStyle12.copyWith(
                                                  color: Color(0xffEF4723),
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              _loginController
                                                  .modelUser.value.levelName
                                                  .toString()
                                                  .replaceAll("Level ", ""),
                                              style: textStyle12.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: Colors.white.withOpacity(0.40),
                                        width: 1,
                                        height: 50,
                                      ),
                                      Expanded(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              Get.to(FollowerFollowing(1));
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  _friendController
                                                      .arrOfFollowing.length
                                                      .toString(),
                                                  style: textStyle12.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  "Following",
                                                  style: textStyle12.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.20,
                                height:
                                    MediaQuery.of(context).size.width * 0.20,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[200],
                                    image: DecorationImage(
                                        image: NetworkImage(_loginController
                                                    .modelUser.value.image !=
                                                null
                                            ? _loginController
                                                    .modelUser.value.image
                                                    .toString()
                                                    .contains("http")
                                                ? _loginController
                                                    .modelUser.value.image
                                                    .toString()
                                                : STORAGE_URL +
                                                    _loginController
                                                        .modelUser.value.image
                                                        .toString()
                                            : PROFILE),
                                        fit: BoxFit.contain)),
                              )

                              // CircleAvatar(
                              //   radius: 35,
                              //   backgroundColor: Color(0xffEF4723),
                              //   child: CircleAvatar(
                              //     backgroundImage: NetworkImage(_loginController.modelUser.value.image!=null?STORAGE_URL+_loginController.modelUser.value.image.toString():PROFILE),
                              //     radius: 32,
                              //
                              //   ),
                              // )
                              /*CircleAvatar(

                             radius: 35.0,
                             backgroundImage:
                             NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80'),
                           )*/
                              ,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Total Steps",
                                  style: textStyle12.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  _loginController.modelUser.value.steps
                                      .toString(),
                                  style: textStyle14.copyWith(
                                      color: Color(0xffEF4723),
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white.withOpacity(0.40),
                            width: 1,
                            height: 50,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Your Coins",
                                      style: textStyle12.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              "assets/icons/ic_coin.png"),
                                          height: iconSize - 5,
                                          width: iconSize - 5,
                                          fit: BoxFit.contain,
                                        ),
                                        VerticalDivider(
                                          width: 4,
                                        ),
                                        Text(
                                          _loginController.modelUser.value.coins
                                              .toString(),
                                          style: textStyle14.copyWith(
                                              color: Color(0xffEF4723),
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              child: InkWell(
                                onTap: () {
                                  Get.to(ViewTransaction());
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Center(
                                    child: Text(
                                      "View Transactions",
                                      style: textStyle11.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.10,
                          ),
                          Expanded(
                            child: Material(
                              color: Color(0xffEF4723),
                              borderRadius: BorderRadius.circular(4),
                              child: InkWell(
                                onTap: () {
                                  // _dashboardController.selectedTab.value = 2;
                                  Get.to(ProductList());
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Center(
                                    child: Text(
                                      "Spend Coins",
                                      style: textStyle11.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                      _historyController.isLoadingHistory.value
                          ? loader()
                          : Column(
                              children: [
                                Container(
                                  color: Colors.white.withOpacity(0.20),
                                  width: Get.width,
                                  height: 0.5,
                                ),
                                Container(
                                  width: Get.width,
                                  height: Get.height * 0.10,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _historyController
                                        .arrOfWeekHistory.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: _historyController
                                                            .arrOfWeekHistory[
                                                                index]
                                                            .levelUpdated ==
                                                        0
                                                    ? Color(0xffE8D426)
                                                    : Color(0xffEF4723)),
                                            child: Center(
                                              child: Icon(
                                                _historyController
                                                            .arrOfWeekHistory[
                                                                index]
                                                            .levelUpdated ==
                                                        0
                                                    ? Icons
                                                        .warning_amber_rounded
                                                    : _historyController
                                                                .arrOfWeekHistory[
                                                                    index]
                                                                .levelUpdated ==
                                                            1
                                                        ? Icons.star_border
                                                        : Icons.check,
                                                color: Colors.white,
                                                size: iconSize - 5,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            _historyController
                                                .arrOfWeekHistory[index]
                                                .dayName!
                                                .substring(0, 1),
                                            style: textStyle10.copyWith(
                                                color: Colors.white,
                                                fontSize: 12),
                                          )
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        width: 20,
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  color: Colors.white.withOpacity(0.20),
                                  width: Get.width,
                                  height: 0.5,
                                ),
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Your past 7 days",
                                      style: textStyle12.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(StepHistory());
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 8),
                                          child: Text(
                                            "View History",
                                            style: textStyle12.copyWith(
                                                color: Color(0xffEF4723),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                BarChartSample3(),
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Weekly Steps",
                                            style: textStyle12.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            _historyController.steps.toString(),
                                            style: textStyle14.copyWith(
                                                color: Color(0xffEF4723),
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white.withOpacity(0.40),
                                      width: 1,
                                      height: 50,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "Your Coins",
                                                style: textStyle12.copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                _historyController.coins
                                                    .toString(),
                                                style: textStyle14.copyWith(
                                                    color: Color(0xffEF4723),
                                                    fontWeight:
                                                        FontWeight.w800),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                      SizedBox(
                        height: Get.height * 0.10,
                      ),
                    ],
                  ),
                  onNotification: (notification) {
                    // print(notification.metrics.pixels);
                    if (notification.metrics.pixels > 40) {
                      setState(() {
                        hideShowAppBar = true;
                      });
                    } else {
                      setState(() {
                        hideShowAppBar = false;
                      });
                    }
                    return false;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                color: hideShowAppBar ? Colors.black : Colors.transparent,
                height: AppBar().preferredSize.height,
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Image(
                    //     image: AssetImage("assets/icons/ic_back.png"),
                    //     width: iconSize - 8,
                    //     height: iconSize - 8,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    Spacer(),
                    Material(
                      type: MaterialType.circle,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Get.to(Setting());
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Image(
                            image: AssetImage("assets/icons/ic_setting.png"),
                            width: iconSize - 5,
                            height: iconSize - 5,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
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
                          }))
            ],
          )),
    );
  }
}
