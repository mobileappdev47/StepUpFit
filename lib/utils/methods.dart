import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

void showToast(String msg, [int position=0]) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.black54,
      gravity: position == 0 ? ToastGravity.BOTTOM : ToastGravity.CENTER);
}

bool checkEmailId(email) {
  return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email.toString());
}

Widget loader() {
  return Center(
    child: SizedBox(
      height: Get.width * 0.08,
      width: Get.width * 0.08,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        color: Color(0xffEF4723),
      ),
    ),
  );
}

Widget whiteLoader() {
  return Center(
    child: SizedBox(
      height: Get.width * 0.07,
      width: Get.width * 0.07,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        color: Colors.white,
      ),
    ),
  );
}



Widget smallWhiteLoader() {
  return Center(
    child: SizedBox(
      height: Get.width * 0.04,
      width: Get.width * 0.04,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Colors.white,
      ),
    ),
  );
}

double margin2 = Get.width * 0.01;
double margin4 = Get.width * 0.02;
double margin8 = Get.width * 0.03;
double margin10 = Get.width * 0.04;
double margin12 = Get.width * 0.045;
double margin16 = Get.width * 0.05;
double margin20 = Get.width * 0.06;
double margin24 = Get.width * 0.07;