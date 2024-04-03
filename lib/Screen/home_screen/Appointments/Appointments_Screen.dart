import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:miniplayer/miniplayer.dart';

import '../../../Controllers/stream_controller.dart';
import '../../../Controllers/user_controller.dart';
import '../../../HttpService/HttpService.dart';
import '../../../HttpService/model/streamModel.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../../stream/stream.dart';
import '../../stream/stream_screen.dart';
import '../../stream/video_screen.dart';
import '../home_screen.dart';

class AppointmentsScreen extends StatefulWidget {
  final String langType;
  const AppointmentsScreen({Key? key, required this.langType}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  String _isSelected  = "English";
  final LiveStreamController streamController = Get.find<LiveStreamController>();
  final UserController userController = Get.find<UserController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isSelected = widget.langType;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading:IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_sharp,color: ColorResources.BLACK,)),
        title: _isSelected == "English"? Text('Appointments',
            style: poppinsMedium.copyWith(
                color: ColorResources.BLACK, fontSize: width*0.055)):Text('नियुक्ति',
            style: poppinsMedium.copyWith(
                color: ColorResources.BLACK, fontSize: width*0.055)),
        backgroundColor: ColorResources.ORANGE_WHITE,
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorResources.WHITE,
              image: const DecorationImage(
                  image: AssetImage(Images.Splash_Screen),fit: BoxFit.fill
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 1)),
              ],
              borderRadius: BorderRadius.circular(05)
            ),
            child: DefaultTabController(
              length: 2, // Number of tabs
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: ColorResources.ORANGE,
                    tabs: [
                      Tab(
                        text: _isSelected == "English"
                            ? "Group"
                            : "समूह", // Text for the first tab
                      ),
                      Tab(
                        text: _isSelected == "English"
                            ? "Individual"
                            : "व्यक्ति", // Text for the second tab
                      ),
                    ],
                    labelColor: ColorResources.BLACK, // Color of the selected tab label
                    unselectedLabelColor: Colors.grey, // Color of the unselected tab labels
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Widget for the first tab (Group)
                        FutureBuilder<Map<String, dynamic>>(
                          future: AppConstants.getAppointmentsByUserId(userController.userDetails[0].id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                              final data = snapshot.data!;
                              if(data["success"]) {
                                final appointments = data['appointments'];
                                final users = data['users'];
                                int recordsCount1 = 0;
                                bool isNoAppointmentFoundDisplayed = false;

                                Map<String, List<int>> groupedAppointments = {};

                                for(var item in appointments) {
                                  final sessionType = item['session_type'];
                                  if(int.parse(item['status'].toString()) == 1 && sessionType.first == "group") {
                                    String startTime = item['startTime'];
                                    int userId = int.parse(item['user_id'].toString());

                                    if (!groupedAppointments.containsKey(startTime)) {
                                      groupedAppointments[startTime] = [userId];
                                    } else {
                                      groupedAppointments[startTime]!.add(userId);
                                    }
                                  }
                                }
                                //
                                print(groupedAppointments);

                                return ListView.builder(
                                  itemCount: appointments.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    // DateTime dateTime = DateTime.parse(appointments[index]['updated_at']);
                                    final startTime = appointments[index]['startTime'];
                                    final endTime = appointments[index]['endTime'];
                                    final day = appointments[index]['day'];
                                    final sessionType = appointments[index]['session_type'];
                                    int isAttend = int.parse(appointments[index]['is_attend'].toString());
                                    int status = int.parse(appointments[index]['status'].toString());

                                    if(sessionType.first == "group") {
                                      recordsCount1++;
                                      return Card(
                                        elevation: 4,
                                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                        child: Container(
                                          decoration: const BoxDecoration(color: ColorResources.WHITE),
                                          child: ListTile(
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                            leading: Container(
                                              padding: const EdgeInsets.only(right: 12),
                                              decoration: const BoxDecoration(
                                                  border: Border(right: BorderSide(width: 1, color: Colors.white24))),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(25.0),
                                                child: Image.network(
                                                  "${AppConstants.IMAGE_VIEW}${users[index]['image']}",
                                                  width: 50.0,
                                                  height: 50.0,
                                                  fit: BoxFit.fill,
                                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                    // Show a placeholder icon if image doesn't found
                                                    return const Icon(Icons.account_circle, color: ColorResources.BLACK, size: 50,);
                                                  },
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              "${users[index]['name']}",
                                              style: const TextStyle(
                                                color: ColorResources.BLACK,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            subtitle: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Row(
                                                //   children: [
                                                //     Text(
                                                //       _isSelected == "English" ?
                                                //       "Date : ${DateFormat('d-MMMM-yyyy').format(dateTime).toString()}":
                                                //       "तारीख : ${DateFormat('d-MMMM-yyyy').format(dateTime).toString()}",
                                                //       style: const TextStyle(color: ColorResources.BLACK),
                                                //     ),
                                                //   ],
                                                // ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: _isSelected == "English" ?
                                                        "\nDay : ":
                                                        "\nतारीख : ",
                                                        style: const TextStyle(
                                                          color: ColorResources.BLACK,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: day.toString(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: _isSelected == "English" ?
                                                        "Start Time : ":
                                                        "समय शुरू : ",
                                                        style: const TextStyle(
                                                          color: ColorResources.BLACK,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: startTime,
                                                      ),
                                                      TextSpan(
                                                        text: _isSelected == "English" ?
                                                        "\nEnd Time : ":
                                                        "\nसमय शुरू : ",
                                                        style: const TextStyle(
                                                          color: ColorResources.BLACK,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: endTime,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Column(
                                                //   mainAxisAlignment: MainAxisAlignment.start,
                                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                                //   children: [
                                                //     // Text(
                                                //     //   _isSelected == "English" ?
                                                //     //   "Time : ${DateFormat('hh:mm a').format(dateTime).toString()}":
                                                //     //   "समय : ${DateFormat('hh:mm a').format(dateTime).toString()}",
                                                //     //   style: const TextStyle(color: ColorResources.BLACK),
                                                //     // ),
                                                //     Text(
                                                //       _isSelected == "English" ?
                                                //       "Start Time : ${AppConstants.convertTime(startTime)}":
                                                //       "समय शुरू : ${AppConstants.convertTime(startTime)}",
                                                //       style: const TextStyle(color: ColorResources.BLACK),
                                                //     ),
                                                //     Text(
                                                //       _isSelected == "English" ?
                                                //       "End Time : ${AppConstants.convertTime(endTime)}":
                                                //       "अंत समय : ${AppConstants.convertTime(endTime)}",
                                                //       style: const TextStyle(color: ColorResources.BLACK),
                                                //     ),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                            trailing:
                                            isAttend == 1 && status == 1 ?
                                            FittedBox(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    _isSelected == "English"
                                                        ? "Attended"
                                                        : "प्रति घंटा शुल्क",
                                                    style: const TextStyle(
                                                      color: ColorResources.GREEN,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  const Icon(Icons.thumb_up)
                                                ],
                                              ),
                                            ):
                                            isAttend != 1 && status == 1 ?
                                            FittedBox(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    _isSelected == "English"
                                                        ? "Approved"
                                                        : "अनुमत",
                                                    style: const TextStyle(
                                                      color: ColorResources.GREEN,
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      bool today = checkDate(day);
                                                      int appointmentId = int.parse(appointments[index]['id'].toString());

                                                      if(today) {
                                                        String? time = await checkTime(appointments[index]['startTime']);
                                                        if(time == 'yes') {
                                                          EasyLoading.show();
                                                          HttpService.sendNotificationToUser(
                                                            body: "Consultant has started the session please join the session",
                                                            title: "Session",
                                                            userId: int.parse(appointments[index]['user_id'].toString()),
                                                          ).then((value) => {
                                                            HttpService.allowUserToJoinSessionApi(
                                                              appointmentId
                                                            ).then((value) => {
                                                              EasyLoading.dismiss(),
                                                              setState(() {
                                                                streamController.selectedVideoProvider.value = StreamModel(
                                                                  selectedLanguage: _isSelected,
                                                                  isSession: true,
                                                                  sessionType: "group",
                                                                  userName: userController.userDetails[0].fullName,
                                                                );
                                                                streamController.miniPlayerControllerProvider.value?.animateToHeight(state: PanelState.MAX);
                                                                streamController.hideAppBar.value = true;
                                                              }),
                                                              // Get.to(() =>
                                                              //     StreamScreen(
                                                              //       // userDetails: widget.userDetails.first,
                                                              //       selectedLanguage: _isSelected,
                                                              //       isSession: true,
                                                              //       sessionType: "group",
                                                              //     ),
                                                              // ),
                                                              streamController.appointmentId.value = appointmentId,
                                                            })
                                                          });
                                                        } else {

                                                          EasyLoading.show();
                                                          HttpService.sendNotificationToUser(
                                                            body: "Consultant has started the session please join the session",
                                                            title: "Session",
                                                            userId: int.parse(appointments[index]['user_id'].toString()),
                                                          ).then((value) => {
                                                            HttpService.allowUserToJoinSessionApi(
                                                              int.parse(appointments[index]['id'].toString()),
                                                            ).then((value) => {
                                                              EasyLoading.dismiss(),
                                                              setState(() {
                                                                streamController.selectedVideoProvider.value = StreamModel(
                                                                  selectedLanguage: _isSelected,
                                                                  isSession: true,
                                                                  sessionType: "group",
                                                                  userName: userController.userDetails[0].fullName,
                                                                );
                                                                streamController.miniPlayerControllerProvider.value?.animateToHeight(state: PanelState.MAX);
                                                                streamController.hideAppBar.value = true;
                                                              }),
                                                              // Get.to(() =>
                                                              //   StreamScreen(
                                                              //     // userDetails: widget.userDetails.first,
                                                              //     selectedLanguage: _isSelected,
                                                              //     isSession: true,
                                                              //     sessionType: "group",
                                                              //   ),
                                                              // ),
                                                              streamController.appointmentId.value = appointmentId,
                                                            })
                                                          });
                                                        }
                                                      } else {
                                                        _isSelected == "English"
                                                            ? AppConstants.show_toast("Today is not the scheduled day for the session as it is supposed to start on $day.")
                                                            : AppConstants.show_toast("आज सत्र के लिए निर्धारित दिन नहीं है क्योंकि इसे शुरू होना है $day");
                                                      }
                                                    },
                                                    child: Text(_isSelected == "English" ? "Start Session": "सत्र प्रारंभ करें"),
                                                  )
                                                ],
                                              ),
                                            ):
                                            FittedBox(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    _isSelected == "English" ?
                                                    "Pending": "लंबित",
                                                    style: const TextStyle(
                                                      color: ColorResources.RED,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          int appointmentId = int.parse(appointments[index]['id'].toString());
                                                          int consultantId = int.parse(appointments[index]['astrologer_id'].toString());
                                                          markApproved(appointmentId, consultantId);
                                                        },
                                                        icon: const Icon(Icons.done_all),
                                                        tooltip: _isSelected == "English" ? "Approve": "सत्र प्रारंभ करें",
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          int appointmentId = int.parse(appointments[index]['id'].toString());
                                                          markCancel(appointmentId);
                                                        },
                                                        icon: const Icon(Icons.cancel),
                                                        tooltip: _isSelected == "English" ? "Reject": "अस्वीकार करना",
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // trailing: appointments[index]['is_attend'] == 1 || appointments[index]['is_attend'] == "1" ?
                                            // Text(
                                            //   _isSelected == "English"
                                            //       ? "Attended"
                                            //       : "प्रति घंटा शुल्क",
                                            //   style: const TextStyle(
                                            //     color: ColorResources.GREEN,
                                            //   ),
                                            // ): now.isAfter(dateTime) ? FittedBox(
                                            //   child: Column(
                                            //     children: [
                                            //       Text(
                                            //         _isSelected == "English" ?
                                            //         "Pending": "लंबित",
                                            //         style: const TextStyle(
                                            //           color: ColorResources.RED,
                                            //         ),
                                            //       ),
                                            //       IconButton(
                                            //         onPressed: () {
                                            //           // AppConstants.show_toast("Currently working on this module/live streaming");
                                            //           // print(appointments[index]['id'].toString());
                                            //           markAttended(int.parse(appointments[index]['id'].toString()));
                                            //         },
                                            //         icon: const Icon(Icons.done_all),
                                            //         tooltip: _isSelected == "English" ? "Approve": "सत्र प्रारंभ करें",
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ):
                                            // FittedBox(
                                            //   child: Column(
                                            //     children: [
                                            //       Text(
                                            //         _isSelected == "English" ?
                                            //         "Upcoming":
                                            //         "आगामी",
                                            //         style: const TextStyle(
                                            //           color: ColorResources.GREEN,
                                            //         ),
                                            //       ),
                                            //       IconButton(
                                            //         onPressed: () {
                                            //           AppConstants.show_toast("Currently working on this module/live streaming");
                                            //           // markAttended(int.parse(appointments[index]['id'].toString()));
                                            //         },
                                            //         icon: const Icon(Icons.done_all),
                                            //         tooltip: _isSelected == "English" ? "Mark as Attended": "उपस्थित के रूप में चिह्नित करें",
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      // if (recordsCount1 == 0 && !isNoAppointmentFoundDisplayed) {
                                      //   // Display "No Individual Appointments found" only once
                                      //   isNoAppointmentFoundDisplayed = true;
                                      //   return Padding(
                                      //     padding: const EdgeInsets.symmetric(vertical: 30),
                                      //     child: Center(
                                      //       child: Text(
                                      //         _isSelected == "English"
                                      //             ? "No Group Appointments found"
                                      //             : "कोई समूह नियुक्ति नहीं मिली",
                                      //         style: const TextStyle(
                                      //           color: ColorResources.RED,
                                      //           fontWeight: FontWeight.bold,
                                      //           fontSize: 18,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   );
                                      // } else {
                                        return Container();
                                      // }
                                    }
                                  },
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    _isSelected == "English" ? "No Appointments found": "कोई अपॉइंटमेंट नहीं मिला",
                                    style: const TextStyle(
                                      color: ColorResources.RED,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              }
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                        // Widget for the second tab (Individual)
                        FutureBuilder<Map<String, dynamic>>(
                          future: AppConstants.getAppointmentsByUserId(userController.userDetails[0].id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                              final data = snapshot.data!;
                              if(data["success"]) {
                                final appointments = data['appointments'];
                                final users = data['users'];
                                int recordsCount = 0;
                                bool isNoAppointmentFoundDisplayed = false;

                                return ListView.builder(
                                  itemCount: appointments.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    // DateTime dateTime = DateTime.parse(appointments[index]['updated_at']);
                                    final startTime = appointments[index]['startTime'];
                                    final endTime = appointments[index]['endTime'];
                                    final day = appointments[index]['day'];
                                    final sessionType = appointments[index]['session_type'];
                                    int isAttend = int.parse(appointments[index]['is_attend'].toString());
                                    int status = int.parse(appointments[index]['status'].toString());

                                    if(sessionType.first == "one_to_one") {
                                      recordsCount++;
                                      return Card(
                                        elevation: 4,
                                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                        child: Container(
                                          decoration: const BoxDecoration(color: ColorResources.WHITE),
                                          child: ListTile(
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                            leading: Container(
                                              padding: const EdgeInsets.only(right: 12),
                                              decoration: const BoxDecoration(
                                                  border: Border(right: BorderSide(width: 1, color: Colors.white24))),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(25.0),
                                                child: Image.network(
                                                  "${AppConstants.IMAGE_VIEW}${users[index]['image']}",
                                                  width: 50.0,
                                                  height: 50.0,
                                                  fit: BoxFit.fill,
                                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                    // Show a placeholder icon if image doesn't found
                                                    return const Icon(Icons.account_circle, color: ColorResources.BLACK, size: 50,);
                                                  },
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              "${users[index]['name']}",
                                              style: const TextStyle(
                                                color: ColorResources.BLACK,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            subtitle: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Row(
                                                //   children: [
                                                //     Text(
                                                //       _isSelected == "English" ?
                                                //       "Date : ${DateFormat('d-MMMM-yyyy').format(dateTime).toString()}":
                                                //       "तारीख : ${DateFormat('d-MMMM-yyyy').format(dateTime).toString()}",
                                                //       style: const TextStyle(color: ColorResources.BLACK),
                                                //     ),
                                                //   ],
                                                // ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: _isSelected == "English" ?
                                                        "\nDay : ":
                                                        "\nतारीख : ",
                                                        style: const TextStyle(
                                                          color: ColorResources.BLACK,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: day.toString(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: _isSelected == "English" ?
                                                        "Start Time : ":
                                                        "समय शुरू : ",
                                                        style: const TextStyle(
                                                          color: ColorResources.BLACK,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: startTime,
                                                      ),
                                                      TextSpan(
                                                        text: _isSelected == "English" ?
                                                        "\nEnd Time : ":
                                                        "\nसमय शुरू : ",
                                                        style: const TextStyle(
                                                          color: ColorResources.BLACK,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: endTime,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Column(
                                                //   mainAxisAlignment: MainAxisAlignment.start,
                                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                                //   children: [
                                                //     // Text(
                                                //     //   _isSelected == "English" ?
                                                //     //   "Time : ${DateFormat('hh:mm a').format(dateTime).toString()}":
                                                //     //   "समय : ${DateFormat('hh:mm a').format(dateTime).toString()}",
                                                //     //   style: const TextStyle(color: ColorResources.BLACK),
                                                //     // ),
                                                //     Text(
                                                //       _isSelected == "English" ?
                                                //       "Start Time : ${AppConstants.convertTime(startTime)}":
                                                //       "समय शुरू : ${AppConstants.convertTime(startTime)}",
                                                //       style: const TextStyle(color: ColorResources.BLACK),
                                                //     ),
                                                //     Text(
                                                //       _isSelected == "English" ?
                                                //       "End Time : ${AppConstants.convertTime(endTime)}":
                                                //       "अंत समय : ${AppConstants.convertTime(endTime)}",
                                                //       style: const TextStyle(color: ColorResources.BLACK),
                                                //     ),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                            trailing:
                                            isAttend == 1 && status == 1 ?
                                            FittedBox(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    _isSelected == "English"
                                                        ? "Attended"
                                                        : "प्रति घंटा शुल्क",
                                                    style: const TextStyle(
                                                      color: ColorResources.GREEN,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  const Icon(Icons.thumb_up)
                                                ],
                                              ),
                                            ):
                                            isAttend != 1 && status == 1 ?
                                            FittedBox(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    _isSelected == "English"
                                                        ? "Approved"
                                                        : "अनुमत",
                                                    style: const TextStyle(
                                                      color: ColorResources.GREEN,
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      bool today = checkDate(day);
                                                      int appointmentId = int.parse(appointments[index]['id'].toString());
                                                      if(today) {
                                                        String? time = await checkTime(appointments[index]['startTime']);
                                                        print("time $time");
                                                        if(time == 'yes') {
                                                          EasyLoading.show();
                                                          HttpService.sendNotificationToUser(
                                                            body: "Consultant has started the session please join the session",
                                                            title: "Session",
                                                            userId: int.parse(appointments[index]['user_id'].toString()),
                                                          ).then((value) => {
                                                            HttpService.allowUserToJoinSessionApi(
                                                              appointmentId
                                                            ).then((value) => {
                                                              EasyLoading.dismiss(),
                                                              setState(() {
                                                                streamController.selectedVideoProvider.value = StreamModel(
                                                                  sessionType: "one_to_one",
                                                                  isSession: true,
                                                                  selectedLanguage: _isSelected,
                                                                  userName: userController.userDetails[0].fullName,
                                                                );
                                                                streamController.miniPlayerControllerProvider.value?.animateToHeight(state: PanelState.MAX);
                                                                streamController.hideAppBar.value = true;
                                                              }),
                                                              // Get.to(() =>
                                                              //   StreamScreen(
                                                              //     // userDetails: widget.userDetails.first,
                                                              //     selectedLanguage: _isSelected,
                                                              //     isSession: true,
                                                              //     sessionType: "one_to_one",
                                                              //   ),
                                                              // ),
                                                              streamController.appointmentId.value = appointmentId,
                                                            })
                                                          });
                                                        } else {
                                                          EasyLoading.show();
                                                          HttpService.sendNotificationToUser(
                                                            body: "Consultant has started the session please join the session",
                                                            title: "Session",
                                                            userId: int.parse(appointments[index]['user_id'].toString()),
                                                          ).then((value) => {
                                                            HttpService.allowUserToJoinSessionApi(
                                                                int.parse(appointments[index]['id'].toString())
                                                            ).then((value) => {
                                                              EasyLoading.dismiss(),
                                                              setState(() {
                                                                streamController.selectedVideoProvider.value = StreamModel(
                                                                  selectedLanguage: _isSelected,
                                                                  isSession: true,
                                                                  sessionType: "one_to_one",
                                                                  userName: userController.userDetails[0].fullName,
                                                                );
                                                                streamController.miniPlayerControllerProvider.value?.animateToHeight(state: PanelState.MAX);
                                                                streamController.hideAppBar.value = true;
                                                              }),
                                                              // Get.to(() =>
                                                              //   StreamScreen(
                                                              //     // userDetails: widget.userDetails.first,
                                                              //     selectedLanguage: _isSelected,
                                                              //     isSession: true,
                                                              //     sessionType: "one_to_one",
                                                              //   ),
                                                              // ),
                                                              streamController.appointmentId.value = appointmentId,
                                                            })
                                                          });
                                                        }
                                                      } else {
                                                        _isSelected == "English"
                                                            ? AppConstants.show_toast("Today is not the scheduled day for the session as it is supposed to start on $day.")
                                                            : AppConstants.show_toast("आज सत्र के लिए निर्धारित दिन नहीं है क्योंकि इसे शुरू होना है $day");
                                                      }
                                                    },
                                                    child: Text(_isSelected == "English" ? "Start Session": "सत्र प्रारंभ करें"),
                                                  )
                                                ],
                                              ),
                                            ):
                                            FittedBox(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    _isSelected == "English" ?
                                                    "Pending": "लंबित",
                                                    style: const TextStyle(
                                                      color: ColorResources.RED,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          int appointmentId = int.parse(appointments[index]['id'].toString());
                                                          int consultantId = int.parse(appointments[index]['astrologer_id'].toString());
                                                          markApproved(appointmentId, consultantId);
                                                        },
                                                        icon: const Icon(Icons.done_all),
                                                        tooltip: _isSelected == "English" ? "Approve": "सत्र प्रारंभ करें",
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          int appointmentId = int.parse(appointments[index]['id'].toString());
                                                          markCancel(appointmentId);
                                                        },
                                                        icon: const Icon(Icons.cancel),
                                                        tooltip: _isSelected == "English" ? "Reject": "अस्वीकार करना",
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // trailing: appointments[index]['is_attend'] == 1 || appointments[index]['is_attend'] == "1" ?
                                            // Text(
                                            //   _isSelected == "English"
                                            //       ? "Attended"
                                            //       : "प्रति घंटा शुल्क",
                                            //   style: const TextStyle(
                                            //     color: ColorResources.GREEN,
                                            //   ),
                                            // ): now.isAfter(dateTime) ? FittedBox(
                                            //   child: Column(
                                            //     children: [
                                            //       Text(
                                            //         _isSelected == "English" ?
                                            //         "Pending": "लंबित",
                                            //         style: const TextStyle(
                                            //           color: ColorResources.RED,
                                            //         ),
                                            //       ),
                                            //       IconButton(
                                            //         onPressed: () {
                                            //           // AppConstants.show_toast("Currently working on this module/live streaming");
                                            //           // print(appointments[index]['id'].toString());
                                            //           markAttended(int.parse(appointments[index]['id'].toString()));
                                            //         },
                                            //         icon: const Icon(Icons.done_all),
                                            //         tooltip: _isSelected == "English" ? "Approve": "सत्र प्रारंभ करें",
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ):
                                            // FittedBox(
                                            //   child: Column(
                                            //     children: [
                                            //       Text(
                                            //         _isSelected == "English" ?
                                            //         "Upcoming":
                                            //         "आगामी",
                                            //         style: const TextStyle(
                                            //           color: ColorResources.GREEN,
                                            //         ),
                                            //       ),
                                            //       IconButton(
                                            //         onPressed: () {
                                            //           AppConstants.show_toast("Currently working on this module/live streaming");
                                            //           // markAttended(int.parse(appointments[index]['id'].toString()));
                                            //         },
                                            //         icon: const Icon(Icons.done_all),
                                            //         tooltip: _isSelected == "English" ? "Mark as Attended": "उपस्थित के रूप में चिह्नित करें",
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      // if (recordsCount == 0 && !isNoAppointmentFoundDisplayed) {
                                      //   // Display "No Individual Appointments found" only once
                                      //   isNoAppointmentFoundDisplayed = true;
                                      //   return Padding(
                                      //     padding: const EdgeInsets.symmetric(vertical: 30),
                                      //     child: Center(
                                      //       child: Text(
                                      //         _isSelected == "English"
                                      //             ? "No Individual Appointments found"
                                      //             : "कोई व्यक्तिगत नियुक्ति नहीं मिली",
                                      //         style: const TextStyle(
                                      //           color: ColorResources.RED,
                                      //           fontWeight: FontWeight.bold,
                                      //           fontSize: 18,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   );
                                      // } else {
                                        return Container();
                                      // }
                                    }
                                  },
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    _isSelected == "English" ? "No Appointments found": "कोई नियुक्ति नहीं मिली",
                                    style: const TextStyle(
                                      color: ColorResources.RED,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              }
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                                  title: _isSelected == "English" ? "Leave live stream": "लाइव स्ट्रीम छोड़ें",
                                  content: Text(
                                    _isSelected == "English" ?
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
                  selectedLanguage: _isSelected,
                );
              },
            ),
          ))
        ],
      ),
    );
  }

  void markApproved(int appointmentId, int consultantId) {
    EasyLoading.show();
    HttpService.editAppointmentMarkApprovedApi(appointmentId, consultantId).then((value) {
      if (mounted) {
        setState(() {
          print(value['success']);
          if (value['success'] == "true" || value['success'] == true) {
            EasyLoading.dismiss();
            // showDialogueBox("Success", "Appointment successfully updated!", true);
          } else {
            EasyLoading.dismiss();
            // showDialogueBox("Failed", "Failed to update try again", false);
            print("failed to update");
          }
        });
      }
      EasyLoading.dismiss();
    });
  }

  void markCancel(int appointmentId) {
    EasyLoading.show();
    HttpService.editAppointmentMarkCancelApi(appointmentId).then((value) {
      if (mounted) {
        setState(() {
          print(value['success']);
          if (value['success'] == "true" || value['success'] == true) {
            EasyLoading.dismiss();
            // showDialogueBox("Success", "Appointment successfully updated!", true);
          } else {
            EasyLoading.dismiss();
            // showDialogueBox("Failed", "Failed to update try again", false);
            print("failed to update");
          }
        });
      }
      EasyLoading.dismiss();
    });
  }

  Future<String?> checkTime(String startTime) async {
    // Remove whitespace from the time string
    String trimmedTimeString = startTime.replaceAll(' ', '');

    // Append ":00" to the time string
    String timeString = trimmedTimeString.replaceAllMapped(
      RegExp(r'(\b\d+)([AP]M)$'),
          (Match match) => '${match.group(1)}:00 ${match.group(2)}',
    );

    // Parse the specific time string into a DateTime object
    DateFormat timeFormat = DateFormat('h:mm a');
    DateTime specificDateTime = timeFormat.parse(timeString);

    // Get the current time
    DateTime now = DateTime.now();

    // Compare the specific time with the current time
    if (specificDateTime.isAfter(now)) {
      // There is a gap between the specific time and the current time
      Duration gap = specificDateTime.difference(now);
      String? result = await showYesNoDialog(context, gap);
      return result;
      // return ('You are starting early there is a gap of ${gap.inMinutes} minutes between scheduled time and the current time.');
    } else {
      return ('ok');
    }
  }

  Future<String?> showYesNoDialog(BuildContext context, Duration gap) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_isSelected == "English" ? 'Confirmation': 'पुष्टीकरण'),
          content: _isSelected == "English" ?
            Text('You are starting early there is a gap of ${gap.inMinutes} minutes between scheduled time and the current time. are you sure you want to start session ?'):
            Text('आप जल्दी शुरू कर रहे हैं, शेड्यूल किए गए समय और मौजूदा समय के बीच ${gap.inMinutes} मिनट का अंतर है। क्या आप वाकई सत्र प्रारंभ करना चाहते हैं ?'),
          actions: <Widget>[
            TextButton(
              child: Text(_isSelected == "English" ? 'Yes': "हाँ"),
              onPressed: () {
                Navigator.of(context).pop('yes');
              },
            ),
            TextButton(
              child: Text(_isSelected == "English"? 'No': "नहीं"),
              onPressed: () {
                Navigator.of(context).pop('no');
              },
            ),
          ],
        );
      },
    );
  }

  bool checkDate(String day) {
    // Get the current date
    DateTime currentDate = DateTime.now();
    // Parse the given date string into a DateTime object
    DateTime date = DateFormat('yyyy-MM-dd').parse(day);

    // Compare the given date with the current date
    if (date.year == currentDate.year &&
        date.month == currentDate.month &&
        date.day == currentDate.day) {
      // The given date is today
      return true;
    } else if (date.isBefore(currentDate)) {
      // The given date has passed
      return true;
    } else {
      // The given date is in the future
      return false;
    }
  }

  void leave() {
    setState(() {
      streamController.selectedVideoProvider.value = null;
      streamController.hideAppBar.value = false;
      streamController.remoteUids.clear();
      streamController.isJoined.value = false;
      streamController.isLoading.value = false;
      streamController.agoraEngine.leaveChannel();
      streamController.animationController.dispose();
      // streamController.isInitialized.value = false;
    });
  }

}
