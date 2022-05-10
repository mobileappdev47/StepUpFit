import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sup/modules/login/social_login.dart';
import 'package:sup/modules/profile/edit_profile.dart';
import 'package:sup/page/privacy_policy.dart';
import 'package:sup/page/terms_conditions.dart';
import 'package:sup/utils/constant_key.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/shared_preference.dart';
import 'package:sup/utils/text_style.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height+MediaQuery.of(context).padding.top),
          child: Container(
            height: AppBar().preferredSize.height+MediaQuery.of(context).padding.top,
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
                        onTap: (){
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.arrow_back_ios,color: Colors.white,size: Get.width*0.05,),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Settings",
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
        child: Column(
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                child: ListTile(
                  onTap: () {
                    Get.to(EditProfile(false));
                  },
                  leading: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Image(
                      image: AssetImage("assets/icons/ic_user.png"),
                      width: iconSize - 5,
                      height: iconSize - 5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Padding(
                    child: Text(
                      "Edit Profile",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    padding: EdgeInsets.only(bottom: 4),
                  ),
                  trailing: const Icon(Icons.navigate_next,
                      size: 24, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 0.7,
              width: Get.width,
              color: Colors.grey.withOpacity(0.50),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                child: ListTile(
                  onTap: () {
                    // Get.to(NotificationList());
                  },
                  leading: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Image(
                      image: AssetImage("assets/icons/ic_notification.png"),
                      width: iconSize - 5,
                      height: iconSize - 5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Padding(
                    child: Text(
                      "Notification",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    padding: EdgeInsets.only(bottom: 4),
                  ),
                  trailing: Switch(
                    value: isNotificationOn,

                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                    activeColor: Colors.red,
                    onChanged: (value) {
                      setState(() {
                        isNotificationOn = !isNotificationOn;
                      });
                      addBoolToSF(KEY_IS_NOTIFICATION_ON, isNotificationOn);
                    },
                  ),
                ),
              ),
            ),
            Container(
              height: 0.7,
              width: Get.width,
              color: Colors.grey.withOpacity(0.50),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                child: ListTile(
                  onTap: () {
                    Get.to(PrivacyPolicy());
                  },
                  leading: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Image(
                      image: AssetImage("assets/icons/ic_terms.png"),
                      width: iconSize - 5,
                      height: iconSize - 5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Padding(
                    child: Text(
                      "Privacy Policy",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    padding: EdgeInsets.only(bottom: 4),
                  ),
                  trailing: const Icon(Icons.navigate_next,
                      size: 24, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 0.7,
              width: Get.width,
              color: Colors.grey.withOpacity(0.50),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                child: ListTile(
                  onTap: () {
                    Get.to(TermsCondition());
                  },
                  leading: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Image(
                      image: AssetImage("assets/icons/ic_terms.png"),
                      width: iconSize - 5,
                      height: iconSize - 5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Padding(
                    child: Text(
                      "Terms & Conditions",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    padding: EdgeInsets.only(bottom: 4),
                  ),
                  trailing: const Icon(Icons.navigate_next,
                      size: 24, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 0.7,
              width: Get.width,
              color: Colors.grey.withOpacity(0.50),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                child: ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            _confirmLogout(context));
                  },
                  leading: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Image(
                      image: AssetImage("assets/icons/ic_logout.png"),
                      width: iconSize - 5,
                      height: iconSize - 5,
                      fit: BoxFit.cover,
                      color: Colors.red,
                    ),
                  ),
                  title: Padding(
                    child: Text(
                      "Logout",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.w500),
                    ),
                    padding: EdgeInsets.only(bottom: 4),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }


  _confirmLogout(BuildContext context) {
    return AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            children: <Widget>[
              Text(
                "Confirm Logout ?",
                style: TextStyle(fontSize: 18),
              )
            ],
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop('dialog');
            await addBoolToSF(KEY_IS_LOGIN, false);
            Get.offAll(SocialLogin());
          },
          textColor: Colors.black,
          child: const Text('YES'),
        ),
        new FlatButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          },
          textColor: Colors.red,
          child: const Text('CANCEL'),
        ),
      ],
    );
  }
}
