import 'dart:io';
import 'dart:typed_data';
// import 'package:astrobharat/Screen/home_screen/Time_Slot_Settings/time_slot_settings.dart';
// import 'package:astrobharat/Screen/home_screen/Wallet_screen/Wallet_screen.dart';
// import 'package:astrobharat/Screen/register_screen/category_screen.dart';
import 'package:astrobharat/utill/app_constants.dart';
import 'package:astrobharat/utill/color_resources.dart';
import 'package:astrobharat/utill/share_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:astrobharat/Screen/login/login_screen.dart';
import 'package:astrobharat/utill/images.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:zego_zimkit/services/services.dart';
import 'Chat/shared/constants.dart';
import 'Controllers/stream_controller.dart';
import 'Controllers/time_slot_controller.dart';
import 'Controllers/user_controller.dart';
import 'Screen/home_screen/home_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

//key msg=AAAAZ68DH1M:APA91bGAfSfFqm144ZaX9DtnB75n53bgGMgpMHhy5d7xw3PF7Q-zPIOU4Enc5wajAnJ9yQdHeVPe8q00sfBZh5WoNNGPfPtSb5PKVjRjfcZvYamVcECgsUXsRAuo5Sv5d0IpBaURzTCc

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description: 'This channel is used for important notifications.',
//     // description
//     importance: Importance.high,
//     playSound: true);

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A Background message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  // debugRepaintRainbowEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  // ZIMKit().init(
  //   appID: 450010645, // your appid
  //   appSign:'7da7b175a6690020dfd6640d4509521f03806a262f468bbb9d92de2379241dce', // your appSign
  // );

  tz.initializeTimeZones();
  // await Firebase.initializeApp();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: Constants.apiKey,
        appId: Constants.appId,
        messagingSenderId: Constants.messagingSenderId,
        projectId: Constants.projectId,
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  //Firebase messaging
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    configLoading();
    runApp(
      GetMaterialApp(
        title: "MIFIT",
        debugShowCheckedModeBanner: false,
        // home: Wallet_screen("English"
        // ),
        home: const SplashScreen(),
        builder: EasyLoading.init(),
      ),
    );
    configLoading();
  });
}

void configLoading() {
  EasyLoading.instance.userInteractions = false;
  EasyLoading.instance.backgroundColor = ColorResources.ORANGE;
  EasyLoading.instance.textColor = Colors.white;
  EasyLoading.instance.indicatorColor = ColorResources.WHITE;
  EasyLoading.instance.indicatorSize = 40;
  EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
  EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.dualRing;
  EasyLoading.instance.animationDuration = const Duration(seconds: 1);
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final TimeSlotController timeSlotController = Get.put(TimeSlotController());
  final LiveStreamController streamController = Get.put(LiveStreamController());
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PreferenceUtils.init();
    firebaseCloudMessaging_Listeners();
    AppConstants.closeKeyboard();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      get_login();
    });
  }

  Future<void> firebaseCloudMessaging_Listeners() async {
    if (Platform.isIOS) iOS_Permission();
    await _firebaseMessaging.getToken().then((String? token) {
      AppConstants.firebase_token = '$token';
      print('token::::::::::$token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        print('object1:::::object1');
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                importance: Importance.high,
                priority: Priority.high,
                channel.id,
                channel.name,
                channelDescription: channel.description,
                playSound: true,
                enableVibration: true,
                colorized: true,
                vibrationPattern: Int64List(10),
                icon: '@drawable/ic_stat_name',
              ),
            ));
        print('object2:::::object2');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new message-open app event was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("${notification.title}"),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${notification.body}",
                        maxLines: 3,
                      )
                    ],
                  ),
                ),
              );
            });
      }
    });
  }

  // void showNotification() {
  //   setState(() {
  //     _counter++;
  //   });
  //   print('object:::::object');
  //   flutterLocalNotificationsPlugin.show(
  //       0,
  //       "Testing $_counter",
  //       "This is an Flutter Push Notification",
  //       NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             importance: Importance.high,
  //             priority: Priority.high,
  //             channel.id,
  //             "Soul Planet",
  //             channelDescription: channel.description,
  //             playSound: true,
  //             enableVibration: true,
  //             colorized: true,
  //             vibrationPattern: Int64List(10),
  //             icon: '@drawable/ic_stat_name',
  //           )));
  // }

  void iOS_Permission() async {
    NotificationSettings settings =
        await _firebaseMessaging.getNotificationSettings();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  get_login() async {
    final prefs = await SharedPreferences.getInstance();
    bool iElogin = PreferenceUtils.getbool("login") ?? false;
    print("????????????$iElogin");
    if (iElogin) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const home();
        },
      ));
    } else {
      // Navigator.pushReplacement(context, MaterialPageRoute(
      //   builder: (context) {
      //     return const category_screen();
      //   },
      // ));
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const login_screen();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.Splash_Screen), fit: BoxFit.fill)),
          ),
          Container(
            margin: const EdgeInsets.only(left: 29, right: 28),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.Astrobharat_logo))),
          ),
        ],
      ),
    );
  }
}
