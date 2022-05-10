import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sup/controller/login_controller.dart';
import 'package:sup/modules/login/email_login.dart';
import 'package:sup/modules/login/social_login.dart';
import 'package:sup/page/home.dart';
import 'package:sup/page/privacy_policy.dart';
import 'package:sup/page/terms_conditions.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:sup/utils/methods.dart';
import 'package:sup/utils/text_style.dart';

class EmailRegistration extends StatefulWidget {
  @override
  _EmailRegistrationState createState() => _EmailRegistrationState();
}

class _EmailRegistrationState extends State<EmailRegistration> {

  var isPasswordVisible=false;
  var isCPasswordVisible=false;
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
            child: ListView(
              shrinkWrap: true,
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
                  "Create Account",
                  style: textStyle18.copyWith(fontWeight: FontWeight.w700),
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

                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    style: textStyle14,
                    onChanged: (value){
                      _loginController.email.value=value;
                    },
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
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    style: textStyle14,
                    maxLength: 10,

                    onChanged: (value){
                      _loginController.mobileNumber.value=value;
                    },
                    decoration: textFieldDecoration.copyWith(
                       counterText: "",
                        hintText: "Mobile Number",hintStyle: textStyle14.copyWith(color: Colors.grey)),
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
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isPasswordVisible,
                          style: textStyle14,

                          onChanged: (value){
                            _loginController.password.value=value;
                          },
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
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isCPasswordVisible,
                          style:  textStyle14,
                          onChanged: (value){
                            _loginController.confirmPassword.value=value;
                          },
                          decoration: textFieldDecoration.copyWith(
                              hintText: "Confirm Password",hintStyle: textStyle14.copyWith(color: Colors.grey)),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        type: MaterialType.circle,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isCPasswordVisible = !isCPasswordVisible;
                            });
                          },
                          child: Icon(
                            isCPasswordVisible
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
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
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () {
                      if (_loginController.email.isEmpty) {
                        showToast("Please Enter Email Address");
                      } else if (_loginController.email.isNotEmpty && !checkEmailId(_loginController.email)) {
                        showToast("Please enter valid email address");
                      }else if (_loginController.mobileNumber.isEmpty) {
                        showToast("Please enter mobile number");
                      }else if (_loginController.mobileNumber.toString().length<10) {
                        showToast("Please enter valid mobile number");
                      }else if (_loginController.password.isEmpty) {
                        showToast("Please enter password");
                      } else if (_loginController.password.toString().length < 4) {
                        showToast("Password length must be >=4");
                      }else if (_loginController.confirmPassword.isEmpty) {
                        showToast("Please enter confirm password");
                      }else if (_loginController.confirmPassword.toString()!=_loginController.password.toString()) {
                        showToast("Password not match.");
                      } else {
                        _loginController.registerWithEmail();
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
                          _loginController.isRegisterProgressVisible.value?loader():Text(
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
                Divider(color: Colors.transparent,),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.offAll(EmailLogin());
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          "Already have an account? Sign in",
                          style:
                          textStyle12,
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


    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body:Stack(
        children: [
          Image(
            image: AssetImage("assets/images/ic_bg.png"),
            width: Get.width,
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(Get.width * 0.10),
            child: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
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
                    style: textStyle12.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
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
                      style: textStyle10.copyWith(color: Colors.white),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value){
                        _loginController.email.value=value;
                      },
                      decoration: textFieldDecoration.copyWith(
                          hintText: "Email address"),
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
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      style: textStyle10.copyWith(color: Colors.white),
                      onChanged: (value){
                        _loginController.password.value=value;
                      },
                      decoration: textFieldDecoration.copyWith(
                          hintText: "Password"),
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
                    child: TextFormField(
                      obscureText: true,
                      onChanged: (value){
                        _loginController.confirmPassword.value=value;
                      },
                      decoration: textFieldDecoration.copyWith(
                          hintText: "Confirm Password"),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () {
                        Get.offAll(SocialLogin());
                      },
                      child: Container(
                        width: Get.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sign Up",
                              style: textStyle10.copyWith(
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
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Get.offAll(EmailLogin());
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            "Already have an account? Sign in",
                            style:
                            textStyle10.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),





    );
  }
}
