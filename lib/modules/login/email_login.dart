import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sup/controller/login_controller.dart';
import 'package:sup/modules/login/email_registration.dart';
import 'package:sup/modules/login/forgot_password.dart';
import 'package:sup/page/home.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/methods.dart';
import 'package:sup/utils/text_style.dart';

class EmailLogin extends StatefulWidget {
  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  var isPasswordVisible = false;
  var email="";
  var password="";

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
                  "Let's sign you in.",
                  style: textStyle18.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  "Welcome back.",
                  style: textStyle16,
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
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: textStyle12,
                          onChanged: (value){
                            setState(() {
                              password=value;
                            });
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isPasswordVisible,
                          decoration: textFieldDecoration.copyWith(
                              hintText: "Password",hintStyle: textStyle14.copyWith(color: Colors.grey)),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        type: MaterialType.circle,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(color: Colors.transparent,),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.to(ForgotPassword());
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Forgot Password?",
                        style: textStyle12.copyWith(color: Colors.white.withOpacity(0.90)),
                      ),
                    ),
                  ),
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
                      } else if (password.isEmpty) {
                        showToast("Please enter password");
                      } else {
                        _loginController.loginWithEmail(email, password);
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
                          _loginController.isLoginProgressVisible.value?loader():Text(
                            "Sign in",
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
                Spacer(),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.offAll(EmailRegistration());
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          "Don't have an account? Sign up",
                          style:
                          textStyle12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      )),
    );
  }
}
