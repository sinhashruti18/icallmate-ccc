// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:ccc_app/pages/home_page.dart';
import 'package:ccc_app/pages/login_pages.dart';
import 'package:ccc_app/service/healthcheck_api.dart';
import 'package:ccc_app/service/login_apiservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:web_socket_channel/io.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.reload();
  LoginService.cccIP = prefs.getString('cccIp');
  LoginService.isenabelwsurl = prefs.getBool('isenabelwsurl');
  LoginService.acpclusterwsurl = prefs.getString('acpclusterwsurl');
  LoginService.agent_login_id = prefs.getString('agent_login_id');
  print("get user row id = ${LoginService.agent_login_id}");

  LoginService.agent_name = prefs.getString('agent_name');

  LoginService.mobile_no = prefs.getString('mobile_no');
  LoginService.service_no = prefs.getString('service_no');
  LoginService.ukey = prefs.getString('ukey');
  LoginService.first_name = prefs.getString('first_name');

  LoginService.last_name = prefs.getString('last_name');

  LoginService.agent_row_id = prefs.getInt('agent_row_id');
  LoginService.userrowid = prefs.getInt('userrowid');
  LoginService.user_type = prefs.getInt('usertype');
  LoginService.enable_location = prefs.getBool('enable_location');
  LoginService.enable_loc_loginlogout = prefs.getBool('enable_loc_loginlogout');

  LoginService.isc2cenabled = prefs.getBool('isc2cenabled');

  LoginService.enable_prefix = prefs.getBool('enable_prefix');
  // String email = prefs.getString("email");
  // SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.reload();
  //   LoginService.cccIP = preferences.getString('cccIp')!;
  //   LoginService.isenabelwsurl = preferences.getBool('isenabelwsurl');
  //   LoginService.acpclusterwsurl = preferences.getString('acpclusterwsurl');
  // LoginService.agent_login_id = prefs.getString('agent_login_id');
  print("main login= ${LoginService.agent_login_id}");

  // if (LoginService.agent_name != null) {
  await initializeService();
  // }

  // FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  // if (!kIsWeb) {
  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   initializeNotifications(flutterLocalNotificationsPlugin);
  // }

  // Workmanager().initialize(
  //   callbackDispatcher,
  //   isInDebugMode: true,
  // );
  // Workmanager().registerPeriodicTask(
  //   "task-identifier",
  //   "simpleTask",
  //   frequency: const Duration(milliseconds: 900000),
  // );
  // WebSocketConnection.createWebSocketClient();

  runApp(
    MyApp(),
  );
}

Timer? locationUpdateTimer;
Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'MY FOREGROUND SERVICE', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,

      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );

  service.startService();
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("hello", "world");

  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

// 68.58 9090
  // bring to foreground
  locationUpdateTimer!.cancel();

  locationUpdateTimer =
      Timer.periodic(const Duration(seconds: 60), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        /// OPTIONAL for use custom notification
        /// the notification id must be equals with AndroidConfiguration when you call configure() method.
        flutterLocalNotificationsPlugin.show(
          888,
          'COOL SERVICE',
          'Awesome ${DateTime.now()}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'my_foreground',
              'MY FOREGROUND SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );

        // if you don't using custom notification, uncomment this
        service.setForegroundNotificationInfo(
          title: "My App Service",
          content: "Updated at ${DateTime.now()}",
        );
      }
    }
    final deviceInfo = DeviceInfoPlugin();
    String? device;
    String androidVersion;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.model;
      androidVersion = androidInfo.version.release;
      print('Android Version: $androidVersion');
    }

    /// you can see this log in logcat
    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

    // test using external plugin

    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      device = iosInfo.model!;
    }

    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
        "device": device,
      },
    );
  });
}

void initializeNotifications(
    FlutterLocalNotificationsPlugin notificationsPlugin) async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await notificationsPlugin.initialize(initializationSettings);
}

class MyApp extends StatefulWidget {
  final FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  const MyApp({Key? key, this.flutterLocalNotificationsPlugin})
      : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> getLoginData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.reload();
    LoginService.cccIP = preferences.getString('cccIp')!;
    LoginService.isenabelwsurl = preferences.getBool('isenabelwsurl');
    LoginService.acpclusterwsurl = preferences.getString('acpclusterwsurl');
    LoginService.agent_login_id = preferences.getString('agent_login_id');
    print("get user row id = ${LoginService.agent_login_id}");

    LoginService.agent_name = preferences.getString('agent_name');

    LoginService.mobile_no = preferences.getString('mobile_no');
    LoginService.service_no = preferences.getString('service_no');
    LoginService.ukey = preferences.getString('ukey');
    LoginService.first_name = preferences.getString('first_name');

    LoginService.last_name = preferences.getString('last_name');

    LoginService.agent_row_id = preferences.getInt('agent_row_id');
    LoginService.userrowid = preferences.getInt('userrowid');
    LoginService.user_type = preferences.getInt('usertype');
    LoginService.enable_location = preferences.getBool('enable_location');
    LoginService.enable_loc_loginlogout =
        preferences.getBool('enable_loc_loginlogout');

    LoginService.isc2cenabled = preferences.getBool('isc2cenabled');

    LoginService.enable_prefix = preferences.getBool('enable_prefix');
  }

  static Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.manageExternalStorage, // Add this permission
    ].request();

    if (statuses[Permission.manageExternalStorage]!.isGranted) {
      // Permission granted, proceed with creating the directory
      // createCustomDirectory();
    } else {
      // Permission denied, handle it accordingly
      print('Permission denied: MANAGE_EXTERNAL_STORAGE');
    }
  }

  Timer? timer;

  void initState() {
    requestPermissions();
    // WidgetsBinding.instance.addObserver(this);
    print("Login user row id = ${LoginService.agent_login_id}");
    // if (mounted) {
    //   Timer timer = Timer.periodic(Duration(seconds: 2), (timer) {
    //     print("progress bar= ${LoginService.showprogress}");
    //     //code to run on every 5 seconds
    //   });
    // }

    // if (LoginService.cccIP.isNotEmpt
    //if(y) {
    if (mounted) {
      timer = Timer.periodic(Duration(seconds: 15), (timer) {
        if (LoginService.agent_login_id != null) {
          HealthCheck.fetchHealthCheck(context);
        }

        //code to run on every 5 seconds
      });
    }

    if (LoginService.isenabelwsurl == true) {
      createWebSocketClient(LoginService.acpclusterwsurl);
    } else {
      print("isenabelwsurl is false");
    }

    // } else {
    //   print("timerrrrr");
    // }

    super.initState();

    // pageChange();
  }

  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getLoginData();
      // App is in the foreground, call your function here
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => LoginPage(),
        //   '/home': (context) => HomePage(),
        // },
        home:
            // CRMPagePrac()
            LoginService.agent_login_id == null ? LoginPage() : HomePage());
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("Native called background task: ${LoginService.agent_login_id}");

    // Show the notification
    NotificationHelper.showNotification();

    return Future.value(true);
  });
}

class NotificationHelper {
  static const channelId = 'my_channel_id';
  static const channelName = 'My Channel';
  static const channelDescription = 'My Channel Description';
  static const notificationId = 1;

  static void showNotification() async {
    if (kIsWeb) return; // Skip notification for web platform

    FlutterLocalNotificationsPlugin? notificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      channelId,
      channelName,
      // channelDescription,
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await notificationsPlugin.show(
      notificationId,
      'App is running',
      'Tap to open the app.',
      platformChannelSpecifics,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class Variables {
  static String? username, password;
  // static bool _showprogress = false;
}

void createWebSocketClient(var url) {
  final channel = IOWebSocketChannel.connect(url);

  channel.stream.listen((message) {
    print('Message received: $message');

    if (message == '%H\$') {
      print('Message sent: %g\$');
      channel.sink.add('%g\$');
    } else {
      final packets = message.split('%');

      for (final pkt in packets) {
        if (pkt.isEmpty) {
          continue;
        }

        final trimmedPkt = pkt.trim().replaceAll('\$', '');
        final packetArray = trimmedPkt.split('|');

        final packetType = packetArray[0].trim();

        if (packetType == 'A_C') {
          if (packetArray[1] == '1') {
            channel.sink.add(
                '%ecp-ag-login|${Variables.username}|${Variables.password}|0|${Variables.username}|Login\$');
            print('Connected Successfully');
          } else {
            print('A_C wrong response');
          }
        } else if (packetType == 'A_LOGIN') {
          if (packetArray[1] != '1') {
            channel.sink.add('%LOGOUT|0|0|\$');
            print('A_Login wrong response: Message sent: %LOGOUT|0|0|\$');
          } else {
            // You can handle the A_LOGIN response here
          }
        } else if (packetType == 'ccc_custinfo') {
          final strCustCRMPkt = packetArray[1].trim();
          print(':strCustCRMPkt: $strCustCRMPkt');

          // Process the ccc_custinfo packet here
        }
      }
    }
  }, onError: (error) {
    print('Error: $error');
  }, onDone: () {
    print('WebSocket connection closed');
  });

  // Send initial message when the connection is established
  channel.sink.add('%C|26|01123571219|2.2.8\$');
}
// class CallHandler {
//   static final List<String> desiredNumbers = ['+1234567890', '+9876543210'];

//   static void initialize() {
//     PhoneStateCallReceiver().phoneCallListener(callBack);
//   }

//   static void callBack(CallState callState, String incomingNumber) {
//     if (callState == CallState.RINGING && desiredNumbers.contains(incomingNumber)) {
//       FlutterPhoneDirectCaller.callNumber(incomingNumber);
//     }
//   }
// }
// class CallReceiver extends BroadcastReceiver {
//   @override
//   void onReceive(Context context, Intent intent) {
//     if (intent?.getExtras()?.containsKey(TelephonyManager.EXTRA_INCOMING_NUMBER) == true) {
//       String incomingNumber = intent?.getExtras()?.getString(TelephonyManager.EXTRA_INCOMING_NUMBER);
      
//       // Check if the incomingNumber matches your desired numbers
//       if (incomingNumber == "YOUR_PHONE_NUMBER_1" || incomingNumber == "YOUR_PHONE_NUMBER_2") {
//         // Start an activity to bring your app to the foreground
//         Intent appIntent = Intent(context, YourAppMainActivity::class.java);
//         appIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//         context.startActivity(appIntent);
//       }
//     }
//   }
// }