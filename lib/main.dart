// @dart=2.9

// import 'package:adcolony/adcolony.dart';
import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:device_id/device_id.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sup/page/splash.dart';
import 'package:sup/utils/constant_value.dart';

//SHA1 Debug : 0E:E9:12:A6:87:DA:6B:CE:C3:CF:33:FE:F5:C4:1E:EB:D2:A2:E9:D9
//SHA-256 Debug : 3F:33:E7:8B:9C:86:AA:5A:0E:B3:2C:18:6E:07:50:58:BF:87:95:C0:59:15:A1:06:A1:31:87:C8:8C:00:FF:B4

// flutter run --release

// Facebook Login Issue
// SignUp using email not redirect to edit profile
// Google Native Ads implementation
// Counting stuck on 00:00 daily limit
// Extension Reward Video start only 1 time

//Live Banner Admob : ca-app-pub-3200206683349499/2115943868
//Live Reward Admob : ca-app-pub-3200206683349499/3651838074

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Admob.initialize(testDeviceIds: ['c0bdf25e38951207']);

  final zones = [
    'vzf4076424328545b0ba',
  ];

  // AdColony.init(AdColonyOptions('app0932d91d148b45178d', '0',  zones));
  FacebookAudienceNetwork.init();
  await Hive.initFlutter();
  await Hive.openBox<int>('steps');

  HttpOverrides.global = new MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    getDeviceID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Splash(),
    );
  }

  void getDeviceID() async {
    deviceId = await DeviceId.getID;
    print("Device Id :" + deviceId);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// Get Step
// void main() => runApp(MyApp());
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// enum AppState {
//   DATA_NOT_FETCHED,
//   FETCHING_DATA,
//   DATA_READY,
//   NO_DATA,
//   AUTH_NOT_GRANTED
// }
//
// class _MyAppState extends State<MyApp> {
//   List<HealthDataPoint> _healthDataList = [];
//   AppState _state = AppState.DATA_NOT_FETCHED;
//
//   @override
//   void initState() {
//     super.initState();
//     checkPermission();
//   }
//
//   Future<void> fetchData() async {
//     /// Get everything from midnight until now
//     DateTime startDate = DateTime(2021, 8,   19, 0,  0,  0);
//     DateTime endDate = DateTime(2021,   8,   19, 23, 59, 59);
//
//     HealthFactory health = HealthFactory();
//
//     /// Define the types to get.
//     List<HealthDataType> types = [
//       HealthDataType.STEPS,
//       // HealthDataType.WEIGHT,
//       // HealthDataType.HEIGHT,
//       // HealthDataType.BLOOD_GLUCOSE,
//       // HealthDataType.DISTANCE_WALKING_RUNNING,
//     ];
//
//     setState(() => _state = AppState.FETCHING_DATA);
//
//     /// You MUST request access to the data types before reading them
//     bool accessWasGranted = await health.requestAuthorization(types);
//     // bool accessWasGranted =true;
//
//     int steps = 0;
//
//     if (accessWasGranted) {
//       try {
//         /// Fetch new data
//         List<HealthDataPoint> healthData =
//         await health.getHealthDataFromTypes(startDate, endDate, types);
//
//         /// Save all the new data points
//         _healthDataList.addAll(healthData);
//       } catch (e) {
//         print("Caught exception in getHealthDataFromTypes: $e");
//       }
//
//       /// Filter out duplicates
//       _healthDataList = HealthFactory.removeDuplicates(_healthDataList);
//
//       /// Print the results
//       _healthDataList.forEach((x) {
//         print("Data point: $x");
//         steps += (x.value as int);
//       });
//
//       print("Steps: $steps");
//
//       /// Update the UI to display the results
//       setState(() {
//         _state =
//         _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
//       });
//     } else {
//       print("Authorization not granted");
//       setState(() => _state = AppState.DATA_NOT_FETCHED);
//     }
//   }
//
//   Widget _contentFetchingData() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Container(
//             padding: EdgeInsets.all(20),
//             child: CircularProgressIndicator(
//               strokeWidth: 10,
//             )),
//         Text('Fetching data...')
//       ],
//     );
//   }
//
//   Widget _contentDataReady() {
//     return ListView.builder(
//         itemCount: _healthDataList.length,
//         itemBuilder: (_, index) {
//           HealthDataPoint p = _healthDataList[index];
//           return ListTile(
//             title: Text("${p.typeString}: ${p.value}"),
//             trailing: Text('${p.unitString}'),
//             subtitle: Text('${p.dateFrom} - ${p.dateTo}'),
//           );
//         });
//   }
//
//   Widget _contentNoData() {
//     return Text('No Data to show');
//   }
//
//   Widget _contentNotFetched() {
//     return Text('Press the download button to fetch data');
//   }
//
//   Widget _authorizationNotGranted() {
//     return Text('''Authorization not given.
//         For Android please check your OAUTH2 client ID is correct in Google Developer Console.
//          For iOS check your permissions in Apple Health.''');
//   }
//
//   Widget _content() {
//     if (_state == AppState.DATA_READY)
//       return _contentDataReady();
//     else if (_state == AppState.NO_DATA)
//       return _contentNoData();
//     else if (_state == AppState.FETCHING_DATA)
//       return _contentFetchingData();
//     else if (_state == AppState.AUTH_NOT_GRANTED)
//       return _authorizationNotGranted();
//
//     return _contentNotFetched();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Plugin example app'),
//             actions: <Widget>[
//               IconButton(
//                 icon: Icon(Icons.file_download),
//                 onPressed: () {
//                   fetchData();
//                 },
//               )
//             ],
//           ),
//           body: Center(
//             child: _content(),
//           )),
//     );
//   }
//
//   void checkPermission() async{
//     if (await Permission.activityRecognition.request().isGranted) {
//       fetchData();
//     }
//   }
// }
