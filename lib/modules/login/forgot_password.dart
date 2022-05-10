import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sup/controller/login_controller.dart';
import 'package:sup/modules/login/email_registration.dart';
import 'package:sup/page/home.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/methods.dart';
import 'package:sup/utils/text_style.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  var email="";

  LoginController _loginController=Get.find();

  InputDecoration textFieldDecoration = InputDecoration(
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      hintStyle: textStyle10.copyWith(color: Colors.white));

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: blackBG,
        statusBarColor: blackBG));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(()=>SingleChildScrollView(
        child: Container(
            height: Get.height,
            width: Get.width,
            padding: EdgeInsets.all(Get.width * 0.10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/ic_bg.png")
                )
            ),

            child:ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image(
                    image: AssetImage("assets/images/ic_app_logo.png"),
                    width: Get.width * 0.20,
                    height: Get.height * 0.20,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  "Let's us know your email address",
                  style: textStyle12.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8)),
                  child: TextFormField(
                    style: textStyle12,
                    onChanged: (value){
                      setState(() {
                        email=value;
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: textFieldDecoration.copyWith(
                        hintText: "Email address",hintStyle: textStyle14.copyWith(color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Divider(color: Colors.transparent,),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () {
                      if (email.isEmpty) {
                        showToast("Please enter email address");
                      } else if (!checkEmailId(email)) {
                        showToast("Please enter valid email address");
                      } else {
                        _loginController.resetPassword(email);
                      }
                    },
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _loginController.isForgotPasswordProgressVisible.value?loader():Text(
                            "Send Request",
                            style: textStyle14.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
              ],
            )),
      )),
    );
  }
}
