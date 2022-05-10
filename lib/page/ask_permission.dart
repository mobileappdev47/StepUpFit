import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sup/utils/text_style.dart';

class AskPermission extends StatefulWidget {
  const AskPermission({Key? key}) : super(key: key);

  @override
  _AskPermissionState createState() => _AskPermissionState();
}

class _AskPermissionState extends State<AskPermission> {
  var physicalActivityPermissionGranted = false;
  var googleFitPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
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
              "StepUpFit need the following permission to count step.",
              style: textStyle14.copyWith(fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                onTap: () async {
                  physicalActivityPermissionGranted =
                      await askPhysicalActivityPermission();
                },
                borderRadius: BorderRadius.circular(50),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Text(
                        "Physical Activity",
                        style: textStyle12.copyWith(color: Colors.black),
                      ),
                      Spacer(),
                      physicalActivityPermissionGranted
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : Icon(
                              Icons.check_circle_outline,
                              color: Colors.grey,
                            ),
                      SizedBox(
                        width: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                onTap: () async {
                  if (!physicalActivityPermissionGranted) {
                    physicalActivityPermissionGranted =
                        await askPhysicalActivityPermission();
                    googleFitPermissionGranted =
                        await askPhysicalActivityPermission();
                  } else {
                    googleFitPermissionGranted =
                        await askPhysicalActivityPermission();
                  }
                },
                borderRadius: BorderRadius.circular(50),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Text(
                        "Google Fit",
                        style: textStyle12.copyWith(color: Colors.black),
                      ),
                      Spacer(),
                      googleFitPermissionGranted
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : Icon(
                              Icons.check_circle_outline,
                              color: Colors.grey,
                            ),
                      SizedBox(
                        width: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Material(
              color: Colors.red,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                onTap: () async {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else {
                    exit(0);
                  }
                },
                borderRadius: BorderRadius.circular(50),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Text(
                        "Cancel",
                        style: textStyle12.copyWith(color: Colors.white),
                      ),
                      Spacer(),
                      Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            )
          ],
        ),
      ),
    );
  }

  Future<bool> askPhysicalActivityPermission() async {
    if (await Permission.activityRecognition.isGranted) {
      return true;
    } else if (await Permission.activityRecognition.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> askGoogleFitPermission() async {
    HealthFactory health = HealthFactory();

    List<HealthDataType> types = [
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.WEIGHT,
      HealthDataType.HEIGHT,
      // HealthDataType.DISTANCE_WALKING_RUNNING,
    ];
    return await health.requestAuthorization(types);
  }

  void checkPermission() async {
    bool value = await Permission.activityRecognition.status.isGranted;
    setState(() {
      physicalActivityPermissionGranted = value;
    });
  }
}
