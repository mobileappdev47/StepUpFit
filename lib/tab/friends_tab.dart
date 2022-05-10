import 'dart:convert';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sup/controller/dashboard_controller.dart';
import 'package:sup/controller/friend_controller.dart';
import 'package:sup/model/model_contact.dart';
import 'package:sup/modules/friends/search_friends.dart';
import 'package:sup/modules/reward/invite_friend.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/methods.dart';
import 'package:sup/utils/text_style.dart';

class FriendsTab extends StatefulWidget {
  @override
  _FriendsTabState createState() => _FriendsTabState();
}

class _FriendsTabState extends State<FriendsTab> {
  var isContactSynced = true;
  var isContactSyncing = false;
  var permissionGranted = false;

  FriendController _friendController = Get.find();
  DashboardController _dashboardController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  var isAdmobLoad = true;
  var isDisableAds = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height +
              MediaQuery.of(context).padding.top),
          child: Container(
            height: AppBar().preferredSize.height +
                MediaQuery.of(context).padding.top,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top, right: 16),
            color: Colors.black,
            // color: Colors.yellow,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Friends",
                    style: textStyle16.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          )),
      body: Obx(() => Stack(
            children: [
              Container(
                height: Get.height,
                padding: EdgeInsets.all(16),
                color: Colors.black.withOpacity(0.95),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(SearchFriends());
                      },
                      child: Container(
                        height: Get.height * 0.07,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage("assets/icons/ic_search.png"),
                              width: iconSize - 7,
                              height: iconSize - 7,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Find Friends",
                              style: textStyle12.copyWith(
                                  color: Colors.white.withOpacity(0.70)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Divider(
                                color: Colors.transparent,
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              Image(
                                image: AssetImage(
                                    "assets/icons/ic_friends_coin.png"),
                                width: iconSize + 15,
                                height: iconSize + 15,
                                fit: BoxFit.cover,
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              Text(
                                "Get 5 SUP Coins",
                                style: textStyle12.copyWith(
                                    color: Color(0xffEF4723).withOpacity(0.80),
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "for inviting a friend",
                                style: textStyle11.copyWith(
                                    color: Colors.white.withOpacity(0.80),
                                    fontWeight: FontWeight.w500),
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              Material(
                                color: Color(0xffEF4723),
                                borderRadius: BorderRadius.circular(4),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(InviteFriend());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                                    child: Text(
                                      "Invite".toUpperCase(),
                                      style: textStyle11.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                            ],
                          ),
                        )),
                        VerticalDivider(color: Colors.transparent),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Divider(
                                color: Colors.transparent,
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              Image(
                                image: AssetImage(
                                    "assets/icons/ic_sync_contact.png"),
                                width: iconSize + 15,
                                height: iconSize + 15,
                                fit: BoxFit.cover,
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              Text(
                                "Find Friends on SUP",
                                style: textStyle12.copyWith(
                                    color: Color(0xffEF4723).withOpacity(0.80),
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "this is a quickest way!",
                                style: textStyle11.copyWith(
                                    color: Colors.white.withOpacity(0.80),
                                    fontWeight: FontWeight.w500),
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              Material(
                                color: isContactSyncing
                                    ? Colors.transparent
                                    : Color(0xffEF4723),
                                borderRadius: BorderRadius.circular(4),
                                child: InkWell(
                                  onTap: () {
                                    if (permissionGranted) {
                                      getContact();
                                    } else {
                                      _getContactPermission();
                                    }
                                  },
                                  child: isContactSyncing
                                      ? whiteLoader()
                                      : Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 8),
                                          child: Text(
                                            "Sync Contact".toUpperCase(),
                                            style: textStyle11.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                ),
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          height: 8,
                        ),
                        Text(
                          "Your Contacts",
                          style: textStyle14.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        Divider(color: Colors.transparent),
                        _friendController.arrOfFriend.isEmpty
                            ? Text(
                                "No friend found in your contact list. sync your contact with SUP & get your friend list.",
                                style: textStyle12.copyWith(
                                    color: Colors.white.withOpacity(0.50)),
                              )
                            : Container(
                                height: Get.height * 0.20,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: Get.width * 0.30,
                                        height: Get.height * 0.20,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.08),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 25,
                                                    backgroundColor:
                                                        Color(0xffEF4723),
                                                    child: CircleAvatar(
                                                      backgroundImage: AssetImage(
                                                          "assets/icons/ic_avatar.png"),
                                                      radius: 23,
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: Colors.transparent,
                                                  ),
                                                  Text(
                                                    _friendController
                                                        .arrOfFriend[index]
                                                        .name,
                                                    style: textStyle11,
                                                  ),
                                                  Divider(
                                                    color: Colors.white
                                                        .withOpacity(0.10),
                                                  ),
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      onTap: () {
                                                        if (_friendController
                                                                .arrOfFriend[
                                                                    index]
                                                                .isFollow ==
                                                            "0") {
                                                          setState(() {
                                                            _friendController
                                                                .arrOfFriend[
                                                                    index]
                                                                .isFollow = "1";
                                                          });
                                                          _friendController
                                                              .setFollowUnFollow(
                                                                  _friendController
                                                                      .arrOfFriend[
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                        } else {
                                                          setState(() {
                                                            _friendController
                                                                .arrOfFriend[
                                                                    index]
                                                                .isFollow = "0";
                                                          });
                                                          _friendController
                                                              .setFollowUnFollow(
                                                                  _friendController
                                                                      .arrOfFriend[
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 4,
                                                                vertical: 2),
                                                        child: Text(
                                                            _friendController
                                                                        .arrOfFriend[
                                                                            index]
                                                                        .isFollow ==
                                                                    "0"
                                                                ? "Follow"
                                                                    .toUpperCase()
                                                                : "Following"
                                                                    .toUpperCase(),
                                                            style: textStyle11.copyWith(
                                                                color: Color(
                                                                        0xffEF4723)
                                                                    .withOpacity(
                                                                        0.70),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Material(
                                                color: Colors.transparent,
                                                type: MaterialType.circle,
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                child: InkWell(
                                                  onTap: () {
                                                    _friendController
                                                        .arrOfFriend
                                                        .removeAt(index);
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.all(8),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return VerticalDivider(
                                          color: Colors.transparent);
                                    },
                                    itemCount:
                                        _friendController.arrOfFriend.length),
                              )
                      ],
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.10),
                    ),
                    _friendController.arrOfFriend.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(
                                color: Colors.transparent,
                              ),
                              Text(
                                "Leaderboard",
                                style: textStyle14.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              Divider(
                                color: Colors.white.withOpacity(0.10),
                              ),
                              Divider(
                                height: 8,
                              ),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.only(left: 16),
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.08),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Divider(
                                                height: 8,
                                              ),
                                              Text(
                                                _friendController
                                                    .arrOfFriend[index].name
                                                    .toString(),
                                                style: textStyle12.copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Divider(
                                                height: 4,
                                              ),
                                              Text(
                                                _friendController
                                                            .arrOfFriend[index]
                                                            .steps
                                                            .toString() ==
                                                        "null"
                                                    ? "Steps :0"
                                                    : "Steps : " +
                                                        _friendController
                                                            .arrOfFriend[index]
                                                            .steps
                                                            .toString(),
                                                style: textStyle11.copyWith(
                                                    color: Colors.white
                                                        .withOpacity(0.50),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Divider(
                                                height: 8,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              minWidth: Get.width * 0.16,
                                              minHeight: Get.height * 0.08,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0xffEF4723),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "RANK".toUpperCase(),
                                                  style: textStyle11.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Divider(
                                                  height: 3,
                                                ),
                                                Text(
                                                  (index + 1)
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: textStyle12.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider(color: Colors.transparent);
                                  },
                                  itemCount:
                                      _friendController.arrOfFriend.length),
                            ],
                          )
                        : SizedBox.shrink(),
                    SizedBox(
                      height: Get.height * 0.10,
                    )
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

  Future _getContactPermission() async {
    if (await Permission.contacts.request().isGranted) {
      setState(() {
        permissionGranted = true;
      });
    }
  }

  List<ModelContact> arrOfProduct = [];

  Future<void> getContact() async {
    arrOfProduct.clear();
    setState(() {
      isContactSyncing = true;
    });
    Iterable<Contact> contacts = await ContactsService.getContacts(
      withThumbnails: true,
    );
    List<Contact> contactsList = contacts.toList();
    print("Contact Length :" + contactsList.length.toString());
    setState(() {
      isContactSyncing = false;
    });
    for (int i = 0; i < contactsList.length; i++) {
      if (contactsList[i].phones!.length > 0) {
        var contactNumber = contactsList[i]
            .phones!
            .first
            .value
            .toString()
            .replaceAll("+91", "")
            .replaceAll("-", "")
            .replaceAll(" ", "")
            .replaceAll("+", "")
            .replaceAll("+44", "");
        if (contactNumber.length >= 10) {
          if (contactNumber.length >= 12) {
            contactNumber = contactNumber.substring(2);
          }
          // print("Index $i Name:"+contactsList[i].displayName.toString()+"  $contactNumber");
          arrOfProduct.add(ModelContact(
              name: contactsList[i].displayName.toString(),
              mobileNumber: contactNumber));
        }
      }
    }
    var jsonString = jsonEncode(arrOfProduct);
    _friendController.syncFriend(jsonString);
  }

  void checkPermission() async {
    permissionGranted = await Permission.contacts.request().isGranted;
    print("Contact Permission Already Granted");
  }
}
