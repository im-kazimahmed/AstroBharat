import 'dart:convert';

import 'package:astrobharat/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../Screen/home_screen/home_screen.dart';
import '../main.dart';
import '../main.dart';
import 'confirm_dialog_view.dart';
import 'color_resources.dart';

class AppConstants {
  static const String agoraAppId = "20e6a6edf82141528ac82dc329f1cac7";
  static const String agoraAppCertificate = "29b76b4d2f4b43d69760e18a0cf8ef81";
  // Utils
  static const double inchToDP = 160;
  // Delay times - miliseconds
  static const int delay100ms = 100;
  static const int delay200ms = 200;
  static const int durationDefaultAnimation = 300;
  static const int delay500ms = 500;
  static const int delayASecond = 1000;
  static const int connectTimeOut = 5000;
  static const int receiveTimeOut = 5000;

  var colorBlack = const Color(0xFF121212);
  var colorPrimaryBlack = const Color(0xFF121212);
  var colorDarkGrey = const Color(0xFF657786);
  var colorPrimary = const Color(0xFF1DA1F2);
  var colorTitle = const Color(0xFF2C3D50);
  var colorReds400 = Colors.red.shade400;
  var colorBorderAvatar = const Color(0xff3e455b);

  var colorBlack1 = const Color(0xFF191414);
  var colorPink = const Color(0xFFcd32d7);
  var colorPurple2 = const Color(0xFFa9ade6);
  var colorBlack2 = const Color(0xFF303234);
  var colorRed = const Color(0xFFf11a42);
  var colorBlue = const Color(0xFF1d51fe);
  var colorPurple = const Color(0xFF7d60e5);
  var colorHintText = const Color(0xFFa0a0a0);

  static const colorHigh = Colors.redAccent;
  static var colorMedium = Colors.amber.shade700;
  static const colorCompleted = Colors.green;
  static const colorActive = Color(0xFF00D72F);
  static const colorGreenLight = Color(0xFF009E60);
  static const colorAttendance = Color(0xFF0CCF4C);
  static const colorBlueGrey = Color(0xFF455A64);
  static const colorBlueGreyIos = Color(0xFF1C1F2E);
  static const colorGreyWhite = Color(0x4dE3E3E3);
  static const colorGreyWhite2 = Color(0xFFE3E3E3);
  static const colorCaptionSearch = Color(0xFFA3A3A3);
  static const Color colorDividerTimeline = Color(0xFFC5D0CF);

  static const String BASE_URL ="https://mifit.fit/api_astrologer/";
  static const String IMAGE_VIEW  ="https://mifit.fit/public/image/";
  // static const String BASE_URL ="https://consultant.meesamconstructioncompany.com/project/api_astrologer/";
  // static const String IMAGE_VIEW  ="https://consultant.meesamconstructioncompany.com/project/public/image/";
  static const String CHAK_NUMBER ="${AppConstants.BASE_URL}get-astrologer-mo-no-verification";
  static const String CATEGORY ="${AppConstants.BASE_URL}get-category";
  static const String addParticipantIntoSession ="${AppConstants.BASE_URL}add-participant-into-session";
  static const String removeParticipantFromSession ="${AppConstants.BASE_URL}remove-participant-from-session";
  static const String SKILL ="${AppConstants.BASE_URL}get-skill";
  static const String LANGUGE ="${AppConstants.BASE_URL}get-language";
  static const String COUNTRY ="${AppConstants.BASE_URL}get-country";
  static const String STATE  ="${AppConstants.BASE_URL}get-state";
  static const String createChatRoom  ="${AppConstants.BASE_URL}create-chat-room";
  static const String deleteChatRoom  ="${AppConstants.BASE_URL}delete-chat-room";
  static const String CITY  ="${AppConstants.BASE_URL}get-city";
  static const String SEND_OTP ="${AppConstants.BASE_URL}send_otp";
  static const String GET_UESR_DETAIL ="${AppConstants.BASE_URL}get-astrologer-detail";
  static const String IMAGE  ="${AppConstants.BASE_URL}file-upload";
  static const String REGISTER ="${AppConstants.BASE_URL}astrologer-reg";
  static const String LOGIN ="${AppConstants.BASE_URL}astrologer-login";
  static const String CHECK_USER_STATUS ="${AppConstants.BASE_URL}check-astrologer-profile";
  static const String EDIT_PROFILE ="${AppConstants.BASE_URL}edit-personalInfo";
  static const String EDIT_SKILL ="${AppConstants.BASE_URL}edit-skill";
  static const String EDIT_FEES ="${AppConstants.BASE_URL}change-update-fees-astrologer";
  static const String EDIT_TIME_AVAILABILITY ="${AppConstants.BASE_URL}set-consultant-availibility";
  static const String editAppointmentMarkAttended ="${AppConstants.BASE_URL}get-consultant-appointment-update";
  static const String editAppointmentNotAttended ="${AppConstants.BASE_URL}consultant-appointment-not-attended";
  static const String editAppointmentMarkApproved ="${AppConstants.BASE_URL}consultant-appointment-approve";
  static const String allowUserToJoinSession ="${AppConstants.BASE_URL}change-session-status-to-join";
  static const String editAppointmentMarkCancel ="${AppConstants.BASE_URL}consultant-appointment-cancel";
  static const String EDIT_CATEGORY ="${AppConstants.BASE_URL}edit-category";
  static const String EDIT_LANGYAGE ="${AppConstants.BASE_URL}edit-language";
  static const String EDIT_ADDRESS ="${AppConstants.BASE_URL}edit-location";
  static const String EDIT_BANK ="${AppConstants.BASE_URL}edit-bank-details";
  static const String UPDATA_CHAT_STATUS ="${AppConstants.BASE_URL}update-chat-status";
  static const String UPDATA_CALL_STATUS ="${AppConstants.BASE_URL}update-call-status";
  static const String WATITNG_LIST ="${AppConstants.BASE_URL}get-user-waiting-chat-call";
  static const String QUESTION_HISTORY ="${AppConstants.BASE_URL}get-user-free-que";
  static const String REPORT_HISTORY ="${AppConstants.BASE_URL}get-user-request";
  static const String USER_REPORT_VIEW ="${AppConstants.BASE_URL}get-user-request-data";
  static const String WALLET ="${AppConstants.BASE_URL}get-astrologer-wallet-history";
  static const String updateDeviceToken  ="${AppConstants.BASE_URL}update-user-device-token";
  static const String GET_REDEEM_WITHDRAEAL ="${AppConstants.BASE_URL}astrolger-get-withdrawal";
  static const String GET_BANK_DETAIL ="${AppConstants.BASE_URL}astologer-get-bankdetail";
  static const String WITHRAWAK_DATEIL ="${AppConstants.BASE_URL}astrologer-add-withdrawaldetail";
  static const String ADD_BANK_DETAIL ="${AppConstants.BASE_URL}astologer-add-bankdetail";
  static const String CHANGE_LANGUAGE ="${AppConstants.BASE_URL}edit-language-type";
  static const String VIEW_HISTORY ="${AppConstants.BASE_URL}get-astrologer-review-rate";
  static const String GET_TIME ="${AppConstants.BASE_URL}get-astrologer-total-time";
  static const String MY_ANSWER ="${AppConstants.BASE_URL}add-astrologer-answer";
  static const String MY_ANSWER_DELETE ="${AppConstants.BASE_URL}delete-astrologer-answer";
  static const String COUNTRY_CODE ="${AppConstants.BASE_URL}get-country-code";
  static const String TERMS_USE ="${AppConstants.BASE_URL}astrologer-terms-use";
  static const String PRIVACY_POLICY  ="${AppConstants.BASE_URL}astrologer-privacy-policy";
  static const String UPDATE_LIVE_STATUS  ="${AppConstants.BASE_URL}update-live-status";
  static const String consultantGetAvailableTimings  ="${AppConstants.BASE_URL}get-consultant-available-timings";

  static final walletBalance = ValueNotifier<int>(0);

  // static final groupName = ValueNotifier<String?>(null);
  // static final groupId = ValueNotifier<String?>(null);

  static Map<String, List<ValueNotifier<String?>>> dayTimings = {
    'Monday': [],
    'Tuesday': [],
    'Wednesday': [],
    'Thursday': [],
    'Friday': [],
    'Saturday': [],
  };

  static Map<String, ValueNotifier<String>> daySessionType = {
    'Monday': ValueNotifier<String>("Select type"),
    'Tuesday': ValueNotifier<String>("Select type"),
    'Wednesday': ValueNotifier<String>("Select type"),
    'Thursday': ValueNotifier<String>("Select type"),
    'Friday': ValueNotifier<String>("Select type"),
    'Saturday': ValueNotifier<String>("Select type"),
  };

  static final sessionType = ValueNotifier<String>("Select type");

  static void addTiming(String dayOfWeek) {
    final startTime = ValueNotifier<String?>(null);
    final endTime = ValueNotifier<String?>(null);

    dayTimings[dayOfWeek]?.add(startTime);
    dayTimings[dayOfWeek]?.add(endTime);
  }

  static String convertTime(String time) {
    DateTime timeConverted = DateFormat("HH:mm").parse(time);
    return DateFormat("h:mm a").format(timeConverted);
  }


  static Future<Map<String, dynamic>> getAppointmentsByUserId(int userId) async {
    final jsonEndpoint = "${AppConstants.BASE_URL}get-consultant-appointment/$userId";
    final response = await get(Uri.parse(jsonEndpoint));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if(jsonResponse['success']) {
        final appointments = jsonResponse['data']['appointments'];
        appointments.sort((a, b) => DateTime.parse(b['updated_at']).compareTo(DateTime.parse(a['updated_at'])));
        final users = jsonResponse['data']['user'];
        final astrologers = jsonResponse['data']['astrologer'];

        return {'success': true, 'appointments': appointments, 'users': users, 'astrologer': astrologers};
      } else {
        return {'success': false};
      }
    } else {
      throw Exception('We were not able to successfully download the json data.');
    }
  }


  Future<void> onSelectNotification(String? payload) async {
    // Handle notification tap
  }

  static Future<void> scheduleNotifications(List<Map<String, String>> scheduleRecords) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'high_importance_channel', 'High Importance Notifications',
      icon: "ic_stat_name",
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    // Get the current day of the week
    int currentWeekday = DateTime.now().weekday;

    // Schedule notifications based on the records
    for (final record in scheduleRecords) {
      String specifiedDay = record['day']!;
      String startTimeStr = record['startTime']!;

      // Calculate the next occurrence of the specified day
      DateTime nextOccurrence = _calculateNextOccurrence(currentWeekday, specifiedDay);

      // Convert the start time string to DateTime
      DateTime startTime = DateTime.parse('1970-01-01 $startTimeStr');

      // await flutterLocalNotificationsPlugin.schedule(
      //   specifiedDay.hashCode, // Notification ID (using hashCode of the day string)
      //   'Appointment', // Notification title
      //   'You have an appointment to join at ${AppConstants.convertTime(startTimeStr)}', // Notification body
      //   nextOccurrence = DateTime(
      //     nextOccurrence.year,
      //     nextOccurrence.month,
      //     nextOccurrence.day,
      //     startTime.hour,
      //     startTime.minute,
      //     startTime.second,
      //   ),
      //   platformChannelSpecifics,
      // );
    }
  }

  static DateTime _calculateNextOccurrence(int currentWeekday, String specifiedDay) {
    int specifiedDayIndex = _getDayIndex(specifiedDay);

    if (specifiedDayIndex > currentWeekday) {
      // If the specified day is in the future this week, return the next occurrence
      return DateTime.now().add(Duration(days: specifiedDayIndex - currentWeekday));
    } else {
      // If the specified day has passed this week, return the next occurrence in the following week
      return DateTime.now().add(Duration(days: (7 - currentWeekday) + specifiedDayIndex));
    }
  }

  static int _getDayIndex(String day) {
    switch (day.toLowerCase()) {
      case 'monday':
        return DateTime.monday;
      case 'tuesday':
        return DateTime.tuesday;
      case 'wednesday':
        return DateTime.wednesday;
      case 'thursday':
        return DateTime.thursday;
      case 'friday':
        return DateTime.friday;
      case 'saturday':
        return DateTime.saturday;
      case 'sunday':
        return DateTime.sunday;
      default:
        throw ArgumentError('Invalid day: $day');
    }
  }

  // static Future<void> scheduleNotifications(List<String> scheduledTimes) async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //   AndroidNotificationDetails(
  //     'high_importance_channel', 'High Importance Notifications',
  //     icon: "ic_stat_name",
  //     importance: Importance.high,
  //     priority: Priority.high,
  //   );
  //   const NotificationDetails platformChannelSpecifics =
  //   NotificationDetails(android: androidPlatformChannelSpecifics);
  //
  //   // Schedule notifications for each time
  //   for (int i = 0; i < scheduledTimes.length; i++) {
  //     final String scheduledTimeStr = scheduledTimes[i];
  //
  //     // Parse the string to DateTime
  //     final DateTime scheduledTime = DateTime.parse(scheduledTimeStr);
  //
  //     await flutterLocalNotificationsPlugin.schedule(
  //       i, // Notification ID
  //       'Scheduled Notification ${i + 1}', // Notification title
  //       'This is scheduled notification ${i + 1}', // Notification body
  //       scheduledTime, // Scheduled date and time
  //       platformChannelSpecifics,
  //     );
  //   }
  // }

  static Future<void> showGroupedNotifications({
    required DateTime scheduledDate,
    required String userName,
    required int id,
  }) async {
    const String groupKey = 'com.android.example.WORK_EMAIL';
    const String groupChannelId = 'grouped channel id';
    const String groupChannelName = 'grouped channel name';
    const String groupChannelDescription = 'grouped channel description';
    // example based on https://developer.android.com/training/notify-user/group.html
    const AndroidNotificationDetails firstNotificationAndroidSpecifics =
    AndroidNotificationDetails(groupChannelId, groupChannelName,
        channelDescription: groupChannelDescription,
        icon: "ic_stat_name",
        importance: Importance.max,
        priority: Priority.high,
        groupKey: groupKey);
    const NotificationDetails firstNotificationPlatformSpecifics =
    NotificationDetails(android: firstNotificationAndroidSpecifics);
    await flutterLocalNotificationsPlugin.show(id++, 'Alex Faarborg',
        'You will not believe...', firstNotificationPlatformSpecifics);
    const AndroidNotificationDetails secondNotificationAndroidSpecifics =
    AndroidNotificationDetails(groupChannelId, groupChannelName,
        channelDescription: groupChannelDescription,
        importance: Importance.max,
        priority: Priority.high,
        groupKey: groupKey);
    const NotificationDetails secondNotificationPlatformSpecifics =
    NotificationDetails(android: secondNotificationAndroidSpecifics);
    await flutterLocalNotificationsPlugin.show(
        id++,
        'Jeff Chang',
        'Please join us to celebrate the...',
        secondNotificationPlatformSpecifics);

    // Create the summary notification to support older devices that pre-date
    /// Android 7.0 (API level 24).
    ///
    /// Recommended to create this regardless as the behaviour may vary as
    /// mentioned in https://developer.android.com/training/notify-user/group
    const List<String> lines = <String>[
      'Alex Faarborg  Check this out',
      'Jeff Chang    Launch Party'
    ];
    const InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
        lines,
        contentTitle: '2 messages',
        summaryText: 'janedoe@example.com');
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(groupChannelId, groupChannelName,
        channelDescription: groupChannelDescription,
        styleInformation: inboxStyleInformation,
        groupKey: groupKey,
        setAsGroupSummary: true);
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id++, 'Attention', 'Two messages', notificationDetails);
  }



  static Future<void> scheduleNotification({
    required DateTime scheduledDate,
    required String userName,
    required String time,
    required id,
    required String consultantName,
  }) async {
    int count = 3;
    const List<String> lines = <String>[
      'Alex Faarborg  Check this out',
      'Jeff Chang    Launch Party'
    ];
    InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
        lines,
        contentTitle: '$count messages',
        summaryText: consultantName);


    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'high_importance_channel', 'High Importance Notifications',
        icon: "ic_stat_name",
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: inboxStyleInformation,
        ticker: 'ticker');
    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    // Schedule the notification
    // await flutterLocalNotificationsPlugin.schedule(
    //   id,
    //   'You have an appointment to join',
    //   'User: $userName\nTime: $time',
    //   scheduledDate,
    //   platformChannelSpecifics,
    // );
  }


  static void defaultAlertDialog({
    required String title,
    required String body,
    required double height,
    required String buttonText,
  }){
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(8.0),
        title: title,
        content: Text(body,
          textAlign: TextAlign.center,
        ),
        actions: [
          InkWell(
            onTap: () => Get.back(),
            child: Container(
              alignment: Alignment.center,
              height: height * 0.055,
              width: 100,
              decoration: BoxDecoration(
                color: ColorResources.ORANGE,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(buttonText,
                style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
              ),
            ),
          ),
        ]
    );
  }

  static void showDialogueBox({
    required BuildContext context,
    required String title,
    required String body,
    required bool isSuccess,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Stack(clipBehavior: Clip.none, children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: isSuccess ? MediaQuery.of(context).size.height * 0.60:
              MediaQuery.of(context).size.height * 0.35,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if(isSuccess)
                      Flexible(child: Image.asset("assets/image/success.png"))
                    else
                      const Flexible(child: Icon(Icons.clear, size: 50,)),
                    Text(title, textAlign: TextAlign.center, style: poppinsBold),
                    const SizedBox(height: 10),
                    Text(body, textAlign: TextAlign.center, style: poppinsBold),
                    const SizedBox(height: 20),
                    Row(children: [
                      Expanded(child: InkWell(
                        onTap: ()  => isSuccess ? Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const home()), (route) => false): Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: ColorResources.ORANGE,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('OK', style: poppinsBold.copyWith(color: ColorResources.WHITE,fontWeight: FontWeight.w500)),
                        ),
                      )),
                      const SizedBox(height: 30),
                    ]),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ]),
        );
      },
    );
  }

  // static final mondayStartTime = ValueNotifier<String?>(null);
  // static final mondayEndTime = ValueNotifier<String?>(null);
  // static final tuesdayStartTime = ValueNotifier<String?>(null);
  // static final tuesdayEndTime = ValueNotifier<String?>(null);
  // static final wednesdayStartTime = ValueNotifier<String?>(null);
  // static final wednesdayEndTime = ValueNotifier<String?>(null);
  // static final thursdayStartTime = ValueNotifier<String?>(null);
  // static final thursdayEndTime = ValueNotifier<String?>(null);
  // static final fridayStartTime = ValueNotifier<String?>(null);
  // static final fridayEndTime = ValueNotifier<String?>(null);
  // static final saturdayStartTime = ValueNotifier<String?>(null);
  // static final saturdayEndTime = ValueNotifier<String?>(null);

  // static final mondaySessionType = ValueNotifier<String>("Select type");
  // static final tuesdaySessionType = ValueNotifier<String>("Select type");
  // static final wednesdaySessionType = ValueNotifier<String>("Select type");
  // static final thursdaySessionType = ValueNotifier<String>("Select type");
  // static final fridaySessionType = ValueNotifier<String>("Select type");
  // static final saturdaySessionType = ValueNotifier<String>("Select type");


  static var screenSize;
  static double itemHeight=0.0;
  static double itemWidth=0.0;
  static String firebase_token = 'token';
  static Future closeKeyboard() {
    return SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static Future<bool> onWillPop(BuildContext context, String langType) {
    return showDialog<bool>(
        builder: (BuildContext context) {
          return ConfirmDialogView(
              description: langType=="English"? "Do you really want to quit?":"क्या आप वास्तव में छोड़ना चाहते हैं?",
              leftButtonText: langType=="English"? "No":"नहीं",
              rightButtonText:  langType=="English"?"Yes":"हां",
              onAgreeTap: () {
                SystemNavigator.pop();
              });
        }, context: context).then((value) => value ?? false);
  }

  static parseDateToddMMyyyy(String time) {
    DateTime parseDate =new DateFormat("dd-MM-yyyy").parse(time);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('d MMM yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  static time_formate(String time_formate) {
    DateTime delivery_parseDate =new DateFormat("HH:mm:ss").parse(time_formate);
    var delivery_inputDate = DateTime.parse(delivery_parseDate.toString());
    var delivery_outputFormat = DateFormat('hh:mm a');
    var delivery_outputDate = delivery_outputFormat.format(delivery_inputDate);
    return delivery_outputDate;
  }

  static show_toast(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black.withOpacity(0.7),
        textColor: Colors.white,
        fontSize: 14.0
    );
  }

  static bool isNotValid(String email) {
    return !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}

class LabeledRadio extends StatelessWidget {
    const LabeledRadio({
      Key? key,
      required this.label,
      required this.padding,
      required this.groupValue,
      required this.value,
      required this.onChanged,
    }) : super(key: key);

    final String label;
    final EdgeInsets padding;
    final String groupValue;
    final String value;
    final ValueChanged<String> onChanged;

    @override
    Widget build(BuildContext context) {
      return InkWell(
        onTap: () {
          if (value != groupValue) {
            onChanged(value);
          }
        },
        child: Row(
          children: <Widget>[
            Radio<String>(
              groupValue: groupValue,
              value: value,
              activeColor: ColorResources.COLOR_PRIMERY,
              onChanged: (String? newValue) {onChanged(newValue!);},
            ),
            Text(label,style: poppinsMedium.copyWith(fontSize: AppConstants.itemWidth*0.035,color: ColorResources.BLACK),),
          ],
        ),
      );
    }
  }

class TextFieldCustom extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final int? closekeybord;
  final IconData? Icons;
  bool isPhoneNumber = false;

  // TextCapitalization capitalization=TextCapitalization.none;
  TextFieldCustom(
      this.controller,
      this.hintText,
      this.textInputType,
      this.maxLine,
      this.focusNode,
      this.nextNode,
      this.textInputAction,
      this.isPhoneNumber,
      this.closekeybord,
      this.Icons,
      // this.capitalization,
          {Key? key})
      : super(key: key);

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          // boxShadow: [
          //   BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 3)
          // ],
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(left: 25, top: 15, right: 25),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        keyboardType: isPhoneNumber ? TextInputType.number : textInputType,
        inputFormatters: <TextInputFormatter>[
          isPhoneNumber
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.singleLineFormatter
        ],
        maxLines: maxLine,
        maxLength: isPhoneNumber ? 10 : 1111,
        style: poppinsMedium.copyWith(fontSize: 16),
        controller: controller,
        // textCapitalization: capitalization,
        focusNode: focusNode,
        textInputAction: textInputAction,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(nextNode);
        },
        onChanged: (value) {
          if (value.length == closekeybord) {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            FocusScope.of(context).requestFocus(nextNode);
          }
        },
        decoration: InputDecoration(
          // prefixIcon: Icon(
          //   Icons,
          //   color: Colors.black,
          // ),
          counterText: "",
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
          hintStyle: poppinsMedium.copyWith(fontSize: 14),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black)),
        ),
      ),
    );
  }
}