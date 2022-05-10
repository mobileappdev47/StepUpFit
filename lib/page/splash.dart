import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sup/modules/login/social_login.dart';
import 'package:sup/page/home.dart';
import 'package:sup/utils/constant_key.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/shared_preference.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    var _duration = new Duration(seconds: 3);
    new Timer(_duration, moveToNextPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              Image(
                image: AssetImage("assets/images/ic_splash.jpg"),
                width: Get.width,
                height: Get.height,
                fit: BoxFit.cover,
              ),
              // Center(
              //   child: Padding(
              //     padding: EdgeInsets.all(16),
              //     child: Image(
              //       image: AssetImage("assets/images/ic_app_logo.png"),
              //     ),
              //   ),
              // )
            ],
          )),
    );
  }

  moveToNextPage() async {
    isLogin = await getBoolValuesSF(KEY_IS_LOGIN) ?? false;
    isNotificationOn = await getBoolValuesSF(KEY_IS_NOTIFICATION_ON) ?? true;


    if (isLogin) {
      userId = await getStringValuesSF(KEY_IS_USER_ID) ?? "0";
      print("User Id : "+userId.toString());

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(false),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SocialLogin(),
        ),
      );
    }
  }
}
