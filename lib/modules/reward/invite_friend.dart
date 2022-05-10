import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sup/controller/login_controller.dart';
import 'package:sup/modules/login/social_login.dart';
import 'package:sup/modules/profile/edit_profile.dart';
import 'package:sup/modules/profile/notification_list.dart';
import 'package:sup/page/privacy_policy.dart';
import 'package:sup/page/terms_conditions.dart';
import 'package:sup/utils/constant_key.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/shared_preference.dart';
import 'package:sup/utils/text_style.dart';
import 'package:flutter_share/flutter_share.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({Key? key}) : super(key: key);

  @override
  _InviteFriendState createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {

  LoginController _loginController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            size: Get.width * 0.05,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Invite Friend",
                    style: textStyle16.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          )),
      body: Container(
        height: Get.height,
        color: Colors.black.withOpacity(0.95),
        child: ListView(
          shrinkWrap: true,
          children: [
            Divider(
              color: Colors.transparent,
            ),
            Divider(
              color: Colors.transparent,
            ),
            Image(
              width: Get.width * 0.40,
              height: Get.width * 0.40,
              fit: BoxFit.contain,
              image: AssetImage("assets/icons/ic_invite_friends.png"),
            ),
            Divider(
              color: Colors.transparent,
            ),
            Divider(
              color: Colors.transparent,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                "Invite a friend and get 5 Coins!",
                style: textStyle15.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              color: Colors.transparent,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                "Claim your reward in the Friends Page,once your friend takes 5000 step on Step Up Fit.",
                style: textStyle12.copyWith(
                    color: Colors.white.withOpacity(0.80),
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              color: Colors.transparent,
            ),
            Divider(
              color: Colors.transparent,
            ),
            Center(
              child: DottedBorder(
                borderType: BorderType.RRect,
                color: Colors.white,
                radius: Radius.circular(8),
                // padding: EdgeInsets.all(8),
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: Get.width * 0.50, maxHeight: Get.height * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _loginController.modelUser.value.referral.toString(),
                        style: textStyle15.copyWith(
                            color: Color(0xffEF4723).withOpacity(0.70),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2),
                      ),
                      VerticalDivider(
                        color: Colors.transparent,
                      ),
                      Icon(
                        Icons.copy_rounded,
                        color: Color(0xffEF4723).withOpacity(0.70),
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Divider(color:Colors.transparent),
            Padding(
              padding: EdgeInsets.all(16),
              child: Material(
                color: Color(0xffEF4723),
                borderRadius: BorderRadius.circular(4),
                child: InkWell(
                  onTap: () {
                    share();
                  },
                  child: Container(
                    height: Get.height * 0.07,
                    child: Center(
                      child: Text(
                        "Invite Now",
                        style: textStyle14.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(child: Text("Maximum Invites 100",style: textStyle11.copyWith(color: Colors.white.withOpacity(0.50)),),)
          ],
        ),
      ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Ask your friend to download & register using your referral code '+ _loginController.modelUser.value.referral.toString()+' in sup.',
        text: 'Ask your friend to download the app & register with Step Up Fit & enter this referral code '+ _loginController.modelUser.value.referral.toString()+'.',
        linkUrl: 'https://play.google.com/store/apps/details?id=com.step.up.fit',
        chooserTitle: 'Share & Earn');
  }
}
