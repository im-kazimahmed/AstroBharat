import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:developer';
import 'dart:typed_data';
import 'package:astrobharat/Chat/service/auth_service.dart';
import 'package:astrobharat/Controllers/user_controller.dart';
import 'package:astrobharat/Screen/home_screen/Business_Profile/Business_Profile_screen.dart';
import 'package:astrobharat/Screen/home_screen/Change_Language/Change_Language.dart';
import 'package:astrobharat/Screen/home_screen/Notification/Notification.dart';
import 'package:astrobharat/Screen/home_screen/Question_Answer/Question_Answer.dart';
import 'package:astrobharat/Screen/home_screen/Wallet_screen/Wallet_screen.dart';
import 'package:astrobharat/utill/color_resources.dart';
import 'package:astrobharat/utill/images.dart';
import 'package:astrobharat/utill/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../Chat/service/database_service.dart';
import '../../Controllers/stream_controller.dart';
import '../../Controllers/time_slot_controller.dart';
import '../../HttpService/HttpService.dart';
import '../../HttpService/model/Get_uesr_detali_model.dart';
import '../../HttpService/model/streamModel.dart';
import '../../main.dart';
import '../../utill/AdminContactDialogView.dart';
import '../../utill/app_constants.dart';
import '../../utill/share_preferences.dart';
import '../stream/video_screen.dart';
import 'Appointments/Appointments_Screen.dart';
import 'Time_Slot_Settings/time_slot_settings2.dart';
import 'live_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final UserController userController = Get.find<UserController>();
  final LiveStreamController streamController = Get.find<LiveStreamController>();
  FirebaseAuth auth = FirebaseAuth.instance;

  List item = [
    "Live",
    "Appointments",
    "Time Slot Settings",
    "Wallet",
    "Business Profile",
    "Change Language",
    "Question Answer",
    "Notification",
    "Logout",
    "Share"
  ];
  List itemHindi = [
    "रहना",
    "नियुक्ति",
    "संवाद का इतिहास",
    "बटुआ",
    "व्यापार प्रोफ़ाइल",
    "भाषा बदलें",
    "प्रश्न जवाब",
    "अधिसूचना",
    "लॉग आउट",
    "शेयर करना",
  ];

  List itemImages = [
    Images.live_icon,
    Images.appointments,
    Images.settings,
    Images.rs,
    Images.profile,
    Images.language,
    Images.answer,
    Images.notification,
    Images.logout,
    Images.share
  ];
  final String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final math.Random _rnd = math.Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  Uri shareLink = Uri.parse(
      "https://play.google.com/store/apps/details?id=com.astrobharat_vender");
  late FirebaseMessaging messaging;

  String langType = "English";
  // List<Data> user_detali = List.empty(growable: true);
  bool _isLoading = false;

  DateTime now = DateTime.now();
  String localUserID = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("token::::::::::::${PreferenceUtils.getString("token")}");
    debugPrint("mo_no::::::::::::${PreferenceUtils.getString("mo_no")}");
    getApi();
    // scheduleNotifications();
  }

  void scheduleNotifications() async{
    Timer.periodic(Duration.zero, (timer) async {
      if(userController.userDetails.isNotEmpty) {
        TimeSlotController controller = Get.find<TimeSlotController>();
        controller.consultantId.value = userController.userDetails.first.id;
        controller.fetchData();

        timer.cancel();
        final List<Map<String, String>> scheduleRecords = [];
        for(int index = 0; index<=2; index++) {
          Map<String, dynamic> data = await AppConstants.getAppointmentsByUserId(userController.userDetails.first.id);
          final appointments = data['appointments'];
          if(appointments != null) {
            for(int i = 0; i < appointments.length; i++) {
              String newTime = prepareSchedule(
                startTime: appointments[i]["startTime"],
                duration: index == 0 ? const Duration(hours: 1): const Duration(minutes: 30),
              );
              scheduleRecords.add(
                {'day': appointments[i]["day"], 'startTime': newTime},
              );
            }
          }
        }
        scheduleRecords != [] ? AppConstants.scheduleNotifications(scheduleRecords): null;

        // for(int index = 0; index<=2; index++) {
        //   final List<Map<String, String>> scheduleRecords = [];
        //   Map<String, dynamic> data = await AppConstants.getAppointmentsByUserId(user_detali.first.id);
        //   final appointments = data['appointments'];
        //   for(int i = 0; i < appointments.length; i++) {
        //     scheduleRecords.add(
        //       {'day': appointments[i]["day"], 'startTime': appointments[i]["startTime"]},
        //     );
        //   }
        //   print("all records");
        //   print(scheduleRecords);
        //   AppConstants.scheduleNotifications(scheduleRecords);
        //   prepareSchedule
        // }


        timer.cancel();
      }
    });
  }

  String prepareSchedule({required String startTime, required Duration duration}) {
    List<String> timeParts = startTime.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    // Create a DateTime object for the given time
    DateTime currentTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hours, minutes);

    // Subtract half an hour from the current time
    DateTime updatedTime = currentTime.subtract(duration);

    // Format the updated time as a string in the desired format (hh:mm)
    String updatedTimeString = '${updatedTime.hour.toString().padLeft(2, '0')}:${updatedTime.minute.toString().padLeft(2, '0')}';

    return updatedTimeString;
  }

  getApi() {
    HttpService.get_uesr_detali_api().then((value) {
      if (mounted) {
        setState(() {
          if (value['success'] == true || value['success'] == "true") {
            var values = GetUesrDetaliModel.fromJson(value).data;
            userController.userDetails.clear();
            userController.userDetails.add(values);
            localUserID = userController.userDetails[0].uniqueCode;
            langType = userController.userDetails[0].langType;
            checkUserStatus();
            firebaseAuth();
            updateDeviceId();
            // checkAppointments();
          } else {
            EasyLoading.dismiss();
            PreferenceUtils.clear();
            PreferenceUtils.setbool("login", false);
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const SplashScreen();
              },
            ));
          }
        });
      }
    });
  }

  checkUserStatus() {
    HttpService.check_user_status_api().then((value) {
      if (mounted) {
        setState(() {
          if (value['data']['status'] == 1 || value['data']['status'] == "1") {
            EasyLoading.dismiss();
          } else {
            EasyLoading.dismiss();
            _onApprovalAdmin(context);
          }
          _isLoading = true;
        });
      }
    });
  }

  Future<bool> _onApprovalAdmin(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AdminContactDialogView(
              description: langType == "English"
                  ? "Your account is under review, Please wait for approval."
                  : "आपका खाता समीक्षा अधीन है, कृपया स्वीकृति की प्रतीक्षा करें।",
              leftButtonText: langType == "English" ? "Ok" : "ठीक");
        }).then((value) => value ?? false);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () => AppConstants.onWillPop(context, langType),
      child: SafeArea(
        child: Scaffold(
          appBar: streamController.hideAppBar.value == false ? AppBar(
            automaticallyImplyLeading: false,
            title: Center(
              child: Text(
                langType == "English"
                  ? 'Hey consultant welcome to MIFIT'
                  : 'हे सलाहकार एस्ट्रोभारत में आपका स्वागत है',
                style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK,
                  fontSize: width * 0.040,
                ),
              ),
            ),
            backgroundColor: ColorResources.ORANGE_WHITE,
            elevation: 2,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
          ): null,
          body: _isLoading
              ? RefreshIndicator(
                  onRefresh: () async {
                    getApi();
                  },
                  child: Stack(
                    children: [
                      ListView(
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: ColorResources.WHITE,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    _headerImage(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        userController.userDetails[0].fullName,
                                        textAlign: TextAlign.center,
                                        style: poppinsRegular.copyWith(
                                          color: ColorResources.BLACK,
                                          fontSize: MediaQuery.of(context).size.width * 0.05,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                  gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 15,
                                    childAspectRatio: 01.5,
                                    crossAxisSpacing: 10,
                                  ),
                                  itemCount: item.length,
                                  scrollDirection: Axis.vertical,
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(
                                      top: AppConstants.itemHeight * 0.02),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        if (index == 0) {
                                          final session = StreamModel(
                                            sessionType: "",
                                            isSession: false,
                                            selectedLanguage: langType,
                                            userName: userController.userDetails[0].fullName,
                                          );
                                          setState(() {
                                            streamController.selectedVideoProvider.value = session;
                                            streamController.miniPlayerControllerProvider.value?.animateToHeight(state: PanelState.MAX);
                                            streamController.hideAppBar.value = true;
                                            streamController.uid.value = userController.userDetails[0].id;
                                          });
                                          // Navigator.push(
                                          //   context,
                                          //   CustomRoute(
                                          //     builder: (BuildContext context) {
                                          //       return PageTwo(
                                          //         selectedLanguage: langType,
                                          //         isSession: false,
                                          //         sessionType: "",
                                          //       );
                                          //     },
                                          //     color: Colors.red,
                                          //     label: "Live Stream",
                                          //   ),
                                          // );
                                          // Get.to(() =>
                                          //     StreamScreenFixed(
                                          //       selectedLanguage: langType,
                                          //       isSession: false,
                                          //       sessionType: "",
                                          //     ),
                                          // );
                                        }
                                        if (index == 1) {
                                          Get.to(() =>
                                              AppointmentsScreen(
                                                langType: langType,
                                              ),
                                          );
                                        }
                                        if (index == 2) {
                                          Get.to(() =>
                                              TimeSlotSettings(
                                                langType: langType,
                                              ),
                                          );
                                        }
                                        if (index == 3) {
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) {
                                              return Wallet_screen(langType);
                                            },
                                          ));
                                        }
                                        if (index == 4) {
                                          Get.to(() =>
                                              BusinessProfileScreen(
                                                langType,
                                              )
                                          );
                                        }
                                        if (index == 5) {
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) {
                                              return Change_Language(langType);
                                            },
                                          ));
                                        }
                                        if (index == 6) {
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) {
                                              return QuestionAnswer(langType);
                                            },
                                          ));
                                        }
                                        if (index == 7) {
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) {
                                              return Notification_screen(langType);
                                            },
                                          ));
                                        }
                                        if (index == 8) {
                                          PreferenceUtils.clear();
                                          PreferenceUtils.setbool("login", false);
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return const SplashScreen();
                                                },
                                              ));
                                        }
                                        if (index == 9) {
                                          String nameImage = getRandomString(8);
                                          final ByteData bytes = await rootBundle.load(
                                              'assets/image/Astrobharat_logo.png');
                                          final Uint8List list =
                                          bytes.buffer.asUint8List();
                                          final directory =
                                              (await getApplicationDocumentsDirectory())
                                                  .path;
                                          File imgFile = File(
                                              '$directory/$nameImage.png');
                                          imgFile.writeAsBytes(list);
                                          Share.shareFiles([imgFile.path],
                                              text: 'hello\n$shareLink');
                                        }
                                      },
                                      child: Container(
                                        height: AppConstants.itemHeight * 0.05,
                                        width: AppConstants.itemWidth * 0.15,
                                        decoration: BoxDecoration(
                                          color: ColorResources.WHITE,
                                          border: Border.all(color: ColorResources.ORANGE),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                height: height * 0.05,
                                                width: width * 0.12,
                                                margin: const EdgeInsets.all(5),
                                                child: Image(
                                                  image: AssetImage(
                                                      "${itemImages[index]}"),
                                                  height: height * 0.05,
                                                  width: width * 0.13,
                                                )),
                                            Container(
                                              child: langType == "English"
                                                  ? Text('${item[index]}',
                                                  textAlign: TextAlign.center,
                                                  style: poppinsMedium.copyWith(
                                                      color:
                                                      ColorResources.BLACK,
                                                      fontSize: width * 0.035))
                                                  : Text('${itemHindi[index]}',
                                                  textAlign: TextAlign.center,
                                                  style: poppinsMedium.copyWith(
                                                      color:
                                                      ColorResources.BLACK,
                                                      fontSize: width * 0.035)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Obx(() => Offstage(
                        offstage: streamController.selectedVideoProvider.value == null,
                        child: Miniplayer(
                          controller: streamController.miniPlayerControllerProvider.value,
                          minHeight: streamController.playerMinHeight,
                          maxHeight: MediaQuery.of(context).size.height,
                          builder: (height, percentage) {
                            if (streamController.selectedVideoProvider.value == null) {
                              return const SizedBox.shrink();
                            }

                            if (height <= streamController.playerMinHeight + 50.0) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: ColorResources.ORANGE,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    "Live Streaming",
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption!
                                                        .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    streamController.selectedVideoProvider.value!.userName,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: ColorResources.WHITE,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.fullscreen,
                                            color: ColorResources.WHITE,
                                          ),
                                          onPressed: () {
                                            streamController.miniPlayerControllerProvider.value?.animateToHeight(state: PanelState.MAX);
                                            streamController.hideAppBar.value = true;
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.close,
                                            color: ColorResources.WHITE,
                                          ),
                                          onPressed: () {
                                            streamController.isJoined.value ?
                                            Get.defaultDialog(
                                              contentPadding: const EdgeInsets.all(20.0),
                                              title: langType == "English" ? "Leave live stream": "लाइव स्ट्रीम छोड़ें",
                                              content: Text(
                                                langType == "English" ?
                                                "Are you sure you want to leave live stream ?":
                                                "क्या आप वाकई लाइव स्ट्रीम छोड़ना चाहते हैं?",
                                                // textAlign: TextAlign.center,
                                                overflow: TextOverflow.clip,
                                              ),
                                              onConfirm: () async {
                                                leave();
                                                Get.back();
                                              },
                                              onCancel: () {
                                                print("cancel");
                                              },
                                              buttonColor: ColorResources.ORANGE,
                                              confirmTextColor: ColorResources.WHITE,
                                              cancelTextColor: ColorResources.BLACK,
                                            ): leave();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                            return VideoScreen(
                              selectedLanguage: langType,
                            );
                          },
                        ),
                      ))
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  Widget _headerImage() => Stack(
    alignment: Alignment.center,
    children: [
      SizedBox(
        width: double.infinity,
        height: curveHeight,
        child: CustomPaint(painter: MyPainter()),
      ),
      InkWell(
        onTap: () {
          Get.to(() =>
            BusinessProfileScreen(
              langType,
            )
          );
          // Navigator.push(context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return Business_Profile_screen(
          //         user_detali, langType);
          //     },
          //   ));
        },
        child: Hero(
          tag: 'profilePicHero',
          child: Container(
            width: avatarDiameter,
            height: avatarDiameter,
            decoration: BoxDecoration(
              color: ColorResources.WHITE,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 1)),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.15,
              fit: BoxFit.fill,
              imageUrl:
              "${AppConstants.IMAGE_VIEW}${userController.userDetails[0].image}",
              placeholder: (context, url) =>
                  Image.asset(
                      Images.Astrobharat_logo),
              errorWidget: (context, url,
                  error) =>
                  Image.asset(
                      Images.Astrobharat_logo),
            ),
          ),
        ),
      ),
    ],
  );

  // void jumpToLivePage(BuildContext context,
  //     {required String liveID, required bool isHost, required String name}) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) =>
  //           LivePage(liveID: liveID, isHost: isHost, name: name),
  //     ),
  //   );
  // }

  void firebaseAuth() async {
    AuthService _auth = AuthService();
    String pass = PreferenceUtils.getString("pass");
    String fullName = userController.userDetails.first.fullName;
    String email = userController.userDetails.first.email;
    if(_auth.firebaseAuth.currentUser == null) {
      var result = await _auth.loginWithUserNameandPassword(fullName, email, pass);

      try {
        if(result.contains("The user may have been deleted")) {
          _auth.registerUserWithEmailandPassword(fullName, email, pass);
          await _auth.loginWithUserNameandPassword(fullName, email, pass);
        }
      } on FirebaseException catch (_, e) {
        log(_.message.toString());
      }

      try {
        if(!result) {
          _auth.registerUserWithEmailandPassword(fullName, email, pass);
        }
      } catch(e) {
        print(e);
      }
    } else {
      _auth.firebaseAuth.currentUser == null ?
      _auth.loginWithUserNameandPassword(fullName, email, pass): null;
    }
  }

  void updateDeviceId() async {
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value){
      try {
        if(userController.userDetails != []) {
          String currentId = userController.userDetails.first.deviceId.toString();
          String newId = value.toString();
          if(currentId != newId){
            HttpService.updateDeviceToken(
              newId: newId,
              userId: userController.userDetails.first.id,
            );
          }
        }
      } catch (e) {
        //
      }
    });
  }

  bool isDateInPast(String dateString) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    DateTime currentDate = DateTime.now();
    DateTime date = dateFormat.parse(dateString);

    return date.isBefore(currentDate);
  }

  void leave() async {
    setState(() {
      streamController.selectedVideoProvider.value = null;
      streamController.hideAppBar.value = false;
      streamController.remoteUids.clear();
      streamController.isJoined.value = false;
      streamController.isLoading.value = false;
      streamController.agoraEngine.leaveChannel();
    });

    try{
        await DatabaseService(uid: auth.currentUser?.uid).deleteGroup(streamController.chatGroupId.value);
    } catch (e) {
      //
    }

    try {
      HttpService.deleteChatRoomApi(userController.userDetails.first.id);
    } catch(e) {
      //
    }

    try {
      if(streamController.isSession.value) {
        streamController.selectedVideoProvider.value?.sessionType == "group" ? HttpService.update_live_status(0): null;
      } else {
        HttpService.update_live_status(0);
      }
    } catch (e) {
      //
    }
  }

  // void checkAppointments() {
  //   AppConstants.getAppointmentsByUserId(user_detali.first.id).then((value) => {
  //     if(value['success']) {
  //       for(var item in value['appointments']){
  //         if(item['is_attend'] == "0" || item['is_attend'] == 0){
  //           if(isDateInPast(item['day'])) {
  //             HttpService.appointmentNotAttendedApi(int.parse(item['id'].toString()))
  //           }
  //         }
  //       }
  //     } else {
  //       print("no appointments"),
  //     }
  //   });
  // }
}


const avatarRadius = 60.0;
const avatarDiameter = avatarRadius * 2;
const curveHeight = avatarRadius * 2.5;

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = ColorResources.ORANGE;

    const topLeft = Offset(0, 0);
    final bottomLeft = Offset(0, size.height * 1.25);
    final topRight = Offset(size.width, 0);
    final bottomRight = Offset(size.width, size.height * 1.25);

    final leftCurveControlPoint =
    Offset(size.width * 0.2, size.height - avatarRadius * 0.8);
    final rightCurveControlPoint = Offset(size.width - leftCurveControlPoint.dx,
        size.height - avatarRadius * 0.8);

    final avatarLeftPoint =
    Offset(size.width * 0.5 - avatarRadius + 5, size.height * 0.5);
    final avatarRightPoint =
    Offset(size.width * 0.5 + avatarRadius - 5, avatarLeftPoint.dy);

    final avatarTopPoint =
    Offset(size.width / 2, size.height / 2 - avatarRadius);

    final path = Path()
      ..moveTo(topLeft.dx, topLeft.dy)
      ..lineTo(bottomLeft.dx, bottomLeft.dy)
      ..quadraticBezierTo(leftCurveControlPoint.dx, leftCurveControlPoint.dy,
          avatarLeftPoint.dx, avatarLeftPoint.dy)
      ..arcToPoint(avatarTopPoint, radius: const Radius.circular(avatarRadius))
      ..lineTo(size.width / 2, 0)
      ..close();

    final path2 = Path()
      ..moveTo(topRight.dx, topRight.dy)
      ..lineTo(bottomRight.dx, bottomRight.dy)
      ..quadraticBezierTo(rightCurveControlPoint.dx, rightCurveControlPoint.dy,
          avatarRightPoint.dx, avatarRightPoint.dy)
      ..arcToPoint(avatarTopPoint,
          radius: const Radius.circular(avatarRadius), clockwise: false)
      ..lineTo(size.width / 2, 0)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
