// @dart=2.9

import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sup/controller/dashboard_controller.dart';
import 'package:sup/controller/friend_controller.dart';
import 'package:sup/controller/history_controller.dart';
import 'package:sup/controller/login_controller.dart';
import 'package:sup/controller/product_controller.dart';
import 'package:sup/shimmer/shimmer_dummy_page.dart';
import 'package:sup/tab/friends_tab.dart';
import 'package:sup/tab/home_tab.dart';
import 'package:sup/tab/profile_tab.dart';
import 'package:sup/utils/constant_value.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Home extends StatefulWidget {
  final bool isFirstTime;

  Home(this.isFirstTime);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> listOfTab = [
    HomeTab(),
    FriendsTab(),
    // ShopTab(),
    ProfileTab(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  DashboardController _dashboardController = Get.put(DashboardController());
  ProductController _productController = Get.put(ProductController());
  LoginController _loginController = Get.put(LoginController());
  FriendController _friendController = Get.put(FriendController());
  HistoryController _historyController = Get.put(HistoryController());

  StreamSubscription<int> _subscription;

  @override
  void initState() {
    super.initState();
    init();
    FirebaseMessaging.instance.getToken().then((value) {
      _dashboardController.tokenUpdate(value);
    });
    setupNotification();
    initNotification();
  }

  var isPermissionGranted = false;

  init() async {
    //
    // if (Platform.isAndroid) {
    //   final permissionStatus = Permission.activityRecognition.request();
    //   if (await permissionStatus.isDenied ||
    //       await permissionStatus.isPermanentlyDenied) {
    //     showToast("activityRecognition permission required to fetch your steps count");
    //     if (Platform.isAndroid) {
    //       SystemNavigator.pop();
    //     } else {
    //       exit(0);
    //     }
    //     return;
    //   }else{
    //     // fetchData();
    //     _dashboardController.getDashboard();
    //     initPlatformState();
    //   }
    // }

    if (Platform.isAndroid) {
      if (await Permission.activityRecognition.isGranted) {
        setState(() {
          isPermissionGranted = true;
        });
        fetchData();

        _dashboardController.getDashboard();
        initPlatformState();
      } else {
        if (await Permission.activityRecognition.request().isGranted) {
          setState(() {
            isPermissionGranted = true;
          });
          fetchData();
          _dashboardController.getDashboard();
          initPlatformState();
        } else {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else {
            exit(0);
          }
        }
      }
    }
  }

  List<HealthDataPoint> _healthDataList = [];
  AppState _state = AppState.DATA_NOT_FETCHED;

  Future<void> fetchData() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    String formattedDate = formatter.format(now);
    print(formattedDate);

    /// Get everything from midnight until now
    DateTime startDate = DateTime(int.parse(formattedDate), 10, 11, 0, 0, 0);
    DateTime endDate = DateTime(int.parse(formattedDate), 10, 11, 23, 59, 59);

    HealthFactory health = HealthFactory();

    /// Define the types to get.
    List<HealthDataType> types = [
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ];

    setState(() => _state = AppState.FETCHING_DATA);

    /// You MUST request access to the data types before reading them
    //

    bool accessWasGranted = await health.requestAuthorization(types);
    int steps = 0;
    if (accessWasGranted) {
      try {
        /// Fetch new data
        List<HealthDataPoint> healthData =
        await health.getHealthDataFromTypes(startDate, endDate, types);

        /// Save all the new data points
        _healthDataList.addAll(healthData);
      } catch (e) {
        print("Caught exception in getHealthDataFromTypes: $e");
      }

      /// Filter out duplicates
      _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

      /// Print the results
      _healthDataList.forEach((x) {
        print("Data point: $x");
        steps += (x.value as int);
      });

      print("Steps: $steps");

      /// Update the UI to display the results
      setState(() {});
    } else {
      print("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  bool permissions;
  String result = '';

  Future<void> initPlatformState() async {
    setUpPedometer();
    if (!mounted) return;
  }

  void setUpPedometer() {
    Pedometer pedometer = new Pedometer();
    _subscription = pedometer.stepCountStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void _onData(int value) async {
    print("Total Steps: " + value.toString());
    int savedStepsCountKey = 999999;
    int savedStepsCount = stepsBox.get(savedStepsCountKey, defaultValue: 0);

    int todayDayNo = Jiffy(DateTime.now()).dayOfYear;
    if (value < savedStepsCount) {
      // Upon device reboot, pedometer resets. When this happens, the saved counter must be reset as well.
      savedStepsCount = 0;
      // persist this value using a package of your choice here
      stepsBox.put(savedStepsCountKey, savedStepsCount);
    }
    // load the last day saved using a package of your choice here
    int lastDaySavedKey = 888888;
    int lastDaySaved = stepsBox.get(lastDaySavedKey, defaultValue: 0);
    // When the day changes, reset the daily steps count
    // and Update the last day saved as the day changes.
    if (lastDaySaved < todayDayNo) {
      lastDaySaved = todayDayNo;
      savedStepsCount = value;
      stepsBox
        ..put(lastDaySavedKey, lastDaySaved)
        ..put(savedStepsCountKey, savedStepsCount);
    }
    todaySteps = value - savedStepsCount;
    // todaySteps =  savedStepsCount;
    stepsBox.put(todayDayNo, todaySteps);
    print("Today Step Count = " + todaySteps.toString());
    _dashboardController.updateKiloMeter(todaySteps.toString());
    showNotification(todaySteps.toString());
  }

  void _onDone() {
    print("Finished pedometer tracking");
  }

  void _onError(error) {
    print("Flutter Pedometer Error: $error");
  }

  Box<int> stepsBox = Hive.box('steps');
  int todaySteps;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.black,
          body: !isPermissionGranted
              ? ShimmerDummyPage()
              : _dashboardController.isDashboardLoading.value
                  ? ShimmerDummyPage()
                  : PageStorage(
                      bucket: bucket,
                      child: listOfTab[_dashboardController.selectedTab.value],
                    ),
          bottomNavigationBar: _dashboardController.isDashboardLoading.value
              ? SizedBox.shrink()
              : BottomNavigationBar(
                  showUnselectedLabels: false,
                  showSelectedLabels: false,
                  onTap: (index) {
                    setState(() {
                      // fetchData();
                      _dashboardController.selectedTab.value = index;
                    });
                  },
                  backgroundColor: Colors.black,
                  selectedItemColor: Colors.red,
                  unselectedItemColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  items: [
                      BottomNavigationBarItem(
                        icon: Image(
                          image: AssetImage("assets/icons/ic_home.png"),
                          width: iconSize,
                          height: iconSize,
                          fit: BoxFit.cover,
                          color: _dashboardController.selectedTab.value == 0
                              ? Colors.red
                              : Colors.white,
                        ),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: Image(
                          image: AssetImage("assets/icons/ic_friends.png"),
                          width: iconSize,
                          height: iconSize,
                          fit: BoxFit.cover,
                          color: _dashboardController.selectedTab.value == 1
                              ? Colors.red
                              : Colors.white,
                        ),
                        label: "",
                      ),
                      // BottomNavigationBarItem(
                      //   icon: Image(
                      //     image: AssetImage("assets/icons/ic_cart.png"),
                      //     width: iconSize,
                      //     height: iconSize,
                      //     fit: BoxFit.cover,
                      //     color: _dashboardController.selectedTab.value == 2
                      //         ? Colors.red
                      //         : Colors.white,
                      //   ),
                      //   label: "",
                      // ),
                      BottomNavigationBarItem(
                        icon: Image(
                          image: AssetImage("assets/icons/ic_user.png"),
                          width: iconSize,
                          height: iconSize,
                          fit: BoxFit.cover,
                          color: _dashboardController.selectedTab.value == 2
                              ? Colors.red
                              : Colors.white,
                        ),
                        label: "",
                      ),
                    ]),
        ));
  }

  var isSendOnAppOpen = false;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void initNotification() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("app_icon");
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // await AndroidAlarmManager.periodic(Duration(seconds:  5),1,showDailyNotification,wakeup: true,exact: true,rescheduleOnReboot: true,);
  }

  void showNotification(String todayStep) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      'your other channel description',
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    if (isNotificationOn && !isSendOnAppOpen) {
      await flutterLocalNotificationsPlugin.show(
        0,
        'StepUpFit - Walk and Earn',
        'You walked $todayStep steps today',
        notificationDetails,
      );

      isSendOnAppOpen = true;
    }
  }

  void showDailyNotification() {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      'your other channel description',
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    tz.initializeTimeZones();

    flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        "StepUpFit - Walk and Earn",
        "Get your daily reward now  ",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  void setupNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message received");
      print(event.notification.body);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Notification"),
              content: Text(event.notification.body),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }
}
