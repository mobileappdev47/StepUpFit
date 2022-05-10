import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sup/controller/login_controller.dart';
import 'package:sup/modules/login/email_login.dart';
import 'package:sup/modules/login/email_registration.dart';
import 'package:sup/page/privacy_policy.dart';
import 'package:sup/page/terms_conditions.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/google_sign_in.dart';
import 'package:sup/utils/methods.dart';
import 'package:sup/utils/text_style.dart';

class SocialLogin extends StatefulWidget {
  @override
  _SocialLoginState createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  LoginController _loginController = Get.put(LoginController());

  var facebookLogin = FacebookLogin();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: blackBG,
        statusBarColor: blackBG));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(() => SingleChildScrollView(
        child: Container(
            height: Get.height,
            width: Get.width,
            padding: EdgeInsets.all(Get.width * 0.10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image:  AssetImage("assets/images/ic_bg.png")
              )
            ),
            child:  ListView(
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Image(
                  image: AssetImage("assets/images/ic_app_logo.png"),
                  width: Get.width * 0.25,
                  height: Get.height * 0.25,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  "Create Account",
                  style: textStyle18.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () {
                      signInWithGoogle().then((result) {
                        if (result != null) {
                          print(result.uid);
                          print(result.displayName);
                          print(result.email);
                          print(result.photoURL);
                          USER_NAME = result.displayName!;
                          EMAIL = result.email!;
                          PROFILE = result.photoURL!;

                          _loginController.registerWithGoogle(
                              result.uid,
                              result.displayName,
                              result.email,
                              result.photoURL);
                        }
                      });
                    },
                    child: Container(
                      width: Get.width,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                  visible: !_loginController
                                      .isGoogleProgressVisible.value,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    color: Colors.white,
                                    child: Image(
                                      image: AssetImage(
                                          "assets/icons/ic_google.png"),
                                      width: iconWidth,
                                      height: iconHeight,
                                      fit: BoxFit.contain,
                                    ),
                                  )),
                          SizedBox(
                            width: 16,
                          ),
                          _loginController.isGoogleProgressVisible.value
                              ? loader()
                              : Text(
                            "Sign in with Google",
                            style: textStyle14.copyWith(
                                color: Colors.white,
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
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () {
                      initiateFacebookLogin();
                    },
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image:
                            AssetImage("assets/icons/ic_facebook.png"),
                            width: iconWidth,
                            height: iconHeight,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Sign in with Facebook",
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
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () {
                      Get.to(EmailLogin());
                    },
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage("assets/icons/ic_email.png"),
                            width: iconWidth,
                            height: iconHeight,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Continue with Email",
                            style: textStyle14.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                Divider(),
                Wrap(
                  children: [
                    Text(
                      "By continuing you agree to the ",
                      style: textStyle11,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsCondition()));
                      },
                      child: Text(
                        "Terms Of Services ",
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 11),
                      ),
                    ),
                    Text("and ", style: textStyle11),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivacyPolicy()));
                      },
                      child: Text(
                        "Privacy policy",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.transparent,),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.to(EmailRegistration());
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          "Don't have an account? Sign up",
                          style: textStyle12,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(color: Colors.transparent,),
              ],
            )),
      )),
    );
  }

  initiateFacebookLogin() async {
    var facebookLoginResult = await facebookLogin.logIn(['email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print(facebookLoginResult.errorMessage);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print(facebookLoginResult.errorMessage);
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}'));

        var profile = json.decode(graphResponse.body);
        print(profile.toString());

        print(profile['id']);
        print(profile['first_name'] + " " + profile['last_name']);
        print(profile['email']);
        print(profile['picture']['data']['url']);

        USER_NAME = profile['first_name'] + " " + profile['last_name'];
        EMAIL = profile['email'];
        PROFILE = profile['picture']['data']['url'];


        _loginController.registerWithFacebook(
            profile['id'],
            profile['first_name'] + " " + profile['last_name'],
            profile['email'],
            profile['picture']['data']['url']);

        break;
    }
  }
}
