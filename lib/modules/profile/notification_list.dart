import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sup/controller/login_controller.dart';
import 'package:sup/modules/login/social_login.dart';
import 'package:sup/utils/constant_key.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/methods.dart';
import 'package:sup/utils/shared_preference.dart';
import 'package:sup/utils/text_style.dart';
import 'dart:io' as Io;
import 'package:intl/intl.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.95),
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
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      type: MaterialType.circle,
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                              size: Get.width*0.05
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Notification",
                    style: textStyle16.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          )),
      body: Container(
        padding: EdgeInsets.all(16),
        height: Get.height,
        color: Colors.black.withOpacity(0.95),
        child: ListView.separated(
          shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [

                    Expanded(
                        child: Text(
                            "Coin milestone reached: You have now earned a total of 100 coin of Step Up Fit.",style: textStyle12,)),
                    VerticalDivider(color:Colors.transparent),
                    Text("3m",style: textStyle11.copyWith(fontWeight: FontWeight.w600),),
                    VerticalDivider(color:Colors.transparent)
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(color:Colors.transparent);
            },
            itemCount: 3),
      ),
    );
  }
}
