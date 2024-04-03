import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:intl/intl.dart';

import '../../../HttpService/HttpService.dart';
import '../../../HttpService/model/Consultant_Availability.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../home_screen.dart';

class TimeSlotSettings extends StatefulWidget {
  final List userDetails;
  final String langType;
  const TimeSlotSettings({Key? key, required this.langType, required this.userDetails}) : super(key: key);

  @override
  State<TimeSlotSettings> createState() => _TimeSlotSettingsState();
}

class _TimeSlotSettingsState extends State<TimeSlotSettings> {
  TextEditingController hourlyFeeController = TextEditingController();
  bool isLoading = false;
  String _isSelected  = "English";
  FocusNode hourlyFeesFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isSelected = widget.langType;
    hourlyFeeController.text = widget.userDetails[0].hourlyFees.toString();
  }

  void showDarkTimePicker({
    required ValueNotifier<String?> timeStart,
    required ValueNotifier<String?> timeEnd,
  }) {
    showDialog(
      context: context,
      builder: (_) => FromToTimePicker(
        onTab: (from, to) {
          if (from.hour < to.hour || (from.hour == to.hour && from.minute < to.minute)) {
            final timeDifference = to.hour - from.hour;
            if (timeDifference >= 1 || (timeDifference == 0 && to.minute - from.minute >= 60)) {
              setState(() {
                // timeStart.value = convertTime(startTime);
                timeStart.value = "${from.hour}:${from.minute}0";
                timeEnd.value = "${to.hour}:${to.minute}0";
                print(timeStart.value);
                print(timeEnd.value);
              });
            } else {
              _isSelected == "English"
                  ? AppConstants.show_toast('Minimum gap between "from" and "to" should be 1 hour or more.')
                  : AppConstants.show_toast('"से" और "से" के बीच न्यूनतम अंतर 1 घंटा या अधिक होना चाहिए।');
              // print('Minimum gap between "from" and "to" should be 1 hour or more.');
            }
          } else if (from.hour == to.hour && from.minute == to.minute) {
            _isSelected == "English"
              ? AppConstants.show_toast("The (From) and (to) are same, please select valid timing")
              : AppConstants.show_toast("(से) और (से) समान हैं, कृपया मान्य समय चुनें");
            // print('The "from" and "to" times are the same.');
          } else {
            _isSelected == "English"
                ? AppConstants.show_toast('"from" should be earlier in the day than "to".')
                : AppConstants.show_toast('"से" दिन में "से" की तुलना में पहले होना चाहिए।');
            // print('"from" should be earlier in the day than "to".');
          }

        },
        dialogBackgroundColor: const Color(0xFF121212),
        fromHeadlineColor: Colors.white,
        toHeadlineColor: Colors.white,
        upIconColor: Colors.white,
        downIconColor: Colors.white,
        timeBoxColor: const Color(0xFF1E1E1E),
        timeHintColor: Colors.grey,
        timeTextColor: Colors.white,
        dividerColor: const Color(0xFF121212),
        doneTextColor: Colors.white,
        dismissTextColor: Colors.white,
        defaultDayNightColor: const Color(0xFF1E1E1E),
        defaultDayNightTextColor: Colors.white,
        colonColor: Colors.white,
        showHeaderBullet: true,
        headerText: _isSelected == "English" ?
        'Time available from 01:00 AM to 11:00 PM':
        'समय प्रातः 01:00 बजे से रात्रि 11:00 बजे तक उपलब्ध है',
      ),
    );
  }

  // String convertTime(String time) {
  //   DateTime timeConverted = DateFormat("HH:mm").parse(time);
  //   return DateFormat("h:mm a").format(timeConverted);
  // }

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
        title: _isSelected == "English" ? Text('Time Slot Settings',
            style: poppinsMedium.copyWith(
                color: ColorResources.BLACK, fontSize: width*0.055)):Text('टाइम स्लॉट सेटिंग्स',
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
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(60.0),
      //   child: Container(
      //     decoration: const BoxDecoration(
      //         color: Colors.black,
      //         borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
      //         image: DecorationImage(
      //           image: AssetImage("assets/image/Rectangle 785.png"),
      //           fit: BoxFit.fill,
      //           // opacity: 0.7
      //         )
      //     ),
      //     child: AppBar(
      //       leading:IconButton(onPressed: () {
      //         Navigator.pop(context);
      //       }, icon: const Icon(Icons.arrow_back_sharp,color: ColorResources.WHITE,)),
      //       title: _isSelected == "English" ? Text('Time Slot Settings',
      //           style: poppinsMedium.copyWith(
      //               color: ColorResources.WHITE, fontSize: width*0.055)):Text('टाइम स्लॉट सेटिंग्स',
      //           style: poppinsMedium.copyWith(
      //               color: ColorResources.WHITE, fontSize: width*0.055)),
      //       iconTheme: const IconThemeData(color: ColorResources.WHITE),
      //       backgroundColor: Colors.transparent,
      //       centerTitle: true,
      //       elevation: 2,
      //       shape: const RoundedRectangleBorder(
      //         borderRadius: BorderRadius.vertical(
      //           bottom: Radius.circular(15),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      body: !isLoading ? SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: ColorResources.WHITE,
              image: const DecorationImage(
                image: AssetImage(Images.Splash_Screen),fit: BoxFit.fill,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 1),
                ),
              ],
              borderRadius: BorderRadius.circular(05)),
            child: FutureBuilder<ConsultantAvailability>(
                future: HttpService.fetchConsultantAvailability(widget.userDetails[0].id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                    final data = snapshot.data!;
                    final mondayTimings = AppConstants.dayTimings['Monday'];
                    final tuesdayTimings = AppConstants.dayTimings['Tuesday'];
                    final wednesdayTimings = AppConstants.dayTimings['Wednesday'];
                    final thursdayTimings = AppConstants.dayTimings['Thursday'];
                    final fridayTimings = AppConstants.dayTimings['Friday'];
                    final saturdayTimings = AppConstants.dayTimings['Saturday'];

                    // final daySessionType = AppConstants.daySessionType;

                    if(data.appointments != null) {
                      return Column(
                        children: [
                          if (data.appointments?['one_to_one'] != null && data.appointments?['one_to_one']?["Monday"] != null)
                            buildDayWidget(
                              dayOfWeek: 'Monday',
                              appointments: data.appointments!['one_to_one']!,
                              sessionType: AppConstants.sessionType,
                              dayTimings: mondayTimings!,
                            )
                          else if (data.appointments?['group'] != null && data.appointments?['group']?["Monday"] != null)
                            buildDayWidget(
                              dayOfWeek: 'Monday',
                              appointments: data.appointments!['group']!,
                              sessionType: AppConstants.sessionType,
                              dayTimings: mondayTimings!,
                            )
                          else
                            buildDayWidget(
                              dayOfWeek: 'Monday',
                              appointments: {},
                              sessionType: AppConstants.sessionType,
                              dayTimings: mondayTimings!,
                            ),
                          if (data.appointments?['one_to_one'] != null && data.appointments?['one_to_one']?["Tuesday"] != null)
                            buildDayWidget(
                              dayOfWeek: 'Tuesday',
                              appointments: data.appointments!['one_to_one']!,
                              sessionType: AppConstants.sessionType,
                              dayTimings: tuesdayTimings!,
                            )
                          else if (data.appointments?['group'] != null && data.appointments?['group']?["Tuesday"] != null)
                            buildDayWidget(
                              dayOfWeek: 'Tuesday',
                              appointments: data.appointments!['group']!,
                              sessionType: AppConstants.sessionType,
                              dayTimings: tuesdayTimings!,
                            )
                          else
                            buildDayWidget(
                              dayOfWeek: 'Tuesday',
                              appointments: {},
                              sessionType: AppConstants.sessionType,
                              dayTimings: tuesdayTimings!,
                            ),
                          if (data.appointments?['one_to_one'] != null && data.appointments?['one_to_one']?["Wednesday"] != null)
                            buildDayWidget(
                              dayOfWeek: 'Wednesday',
                              appointments: data.appointments!['one_to_one']!,
                              sessionType: AppConstants.sessionType,
                              dayTimings: wednesdayTimings!,
                            )
                          else if (data.appointments?['group'] != null && data.appointments?['group']?["Wednesday"] != null)
                            buildDayWidget(
                              dayOfWeek: 'Wednesday',
                              appointments: data.appointments!['group']!,
                              sessionType: AppConstants.sessionType,
                              dayTimings: wednesdayTimings!,
                            )
                          else
                            buildDayWidget(
                              dayOfWeek: 'Wednesday',
                              appointments: {},
                              sessionType: AppConstants.sessionType,
                              dayTimings: wednesdayTimings!,
                            ),
                          if (data.appointments?['one_to_one'] != null && data.appointments?['one_to_one']?["Thursday"] != null)
                            buildDayWidget(
                              dayOfWeek: 'Thursday',
                              appointments: data.appointments!['one_to_one']!,
                              sessionType: AppConstants.sessionType,
                              dayTimings: thursdayTimings!,
                            )
                          else if (data.appointments?['group'] != null && data.appointments?['group']?["Thursday"] != null)
                            buildDayWidget(
                              dayOfWeek: 'Thursday',
                              appointments: data.appointments!['group']!,
                              sessionType: AppConstants.sessionType,
                              dayTimings: thursdayTimings!,
                            )
                          else
                            buildDayWidget(
                              dayOfWeek: 'Thursday',
                              appointments: {},
                              sessionType: AppConstants.sessionType,
                              dayTimings: thursdayTimings!,
                            ),
                          if (data.appointments?['one_to_one'] != null && data.appointments?['one_to_one']?["Friday"] != null)
                            buildDayWidget(
                              dayOfWeek: 'Friday',
                              appointments: data.appointments!['one_to_one']!,
                              sessionType: AppConstants.sessionType,
                              dayTimings: fridayTimings!,
                            )
                          else if (data.appointments?['group'] != null && data.appointments?['group']?["Friday"] != null)
                            buildDayWidget(
                              dayOfWeek: 'Friday',
                              appointments: data.appointments!['group']!,
                              sessionType: AppConstants.sessionType,
                              dayTimings: fridayTimings!,
                            )
                          else
                            buildDayWidget(
                              dayOfWeek: 'Friday',
                              appointments: {},
                              sessionType: AppConstants.sessionType,
                              dayTimings: fridayTimings!,
                            ),
                          if (data.appointments?['one_to_one'] != null && data.appointments?['one_to_one']?["Saturday"] != null)
                            buildDayWidget(
                              dayOfWeek: 'Saturday',
                              appointments: data.appointments!['one_to_one']!,
                              sessionType: AppConstants.sessionType,
                              dayTimings: saturdayTimings!,
                            )
                          else if (data.appointments?['group'] != null && data.appointments?['group']?["Saturday"] != null)
                            buildDayWidget(
                              dayOfWeek: 'Saturday',
                              appointments: data.appointments!['group']!,
                              sessionType: AppConstants.sessionType,
                              dayTimings: saturdayTimings!,
                            )
                          else
                            buildDayWidget(
                              dayOfWeek: 'Saturday',
                              appointments: {},
                              sessionType: AppConstants.sessionType,
                              dayTimings: saturdayTimings!,
                            ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  EasyLoading.show();
                                  // final daySessionTypes = AppConstants.daySessionType;
                                  final daySessionTypes = AppConstants.sessionType;
                                  bool isSuccess = true;

                                  if(AppConstants.dayTimings.values.every((element) => element.isEmpty)) {
                                    EasyLoading.dismiss();
                                    _isSelected == "English" ?
                                    AppConstants.show_toast("Nothing new to be updated\nPlease select at least one day time"):
                                    AppConstants.show_toast("अपडेट करने के लिए कुछ नया नहीं है\nकृपया कम से कम एक दिन का समय चुनें");
                                    isSuccess = false;
                                  } else {
                                    final dayTimings = AppConstants.dayTimings;

                                    dayTimings.forEach((dayOfWeek, dayTimings) async {
                                      for (var i = 0; i < dayTimings.length; i += 2) {
                                        if (i + 1 < dayTimings.length) {
                                          ValueNotifier<String?> startTime = dayTimings[i];
                                          ValueNotifier<String?> endTime = dayTimings[i + 1];

                                          if(startTime.value != null && endTime.value != null) {
                                            if(daySessionTypes.value != "Select type") {
                                              // bool result = await updateDayTimeSlot(
                                              //   day: dayOfWeek,
                                              //   startTime: startTime.value!,
                                              //   endTime: endTime.value!,
                                              //   sessionType: daySessionTypes.value,
                                              // );
                                              // if(!result) {
                                              //   isSuccess = false;
                                              //   EasyLoading.dismiss();
                                              //   break;
                                              // } else {
                                              //   print("$dayOfWeek updated $i");
                                              // }
                                            } else {
                                              EasyLoading.dismiss();
                                              _isSelected == "English" ?
                                              AppConstants.show_toast("Please select $dayOfWeek's Session Type"):
                                              AppConstants.show_toast("अपडेट करने के लिए कुछ नया नहीं है\nकृपया कम से कम एक दिन का समय चुनें");
                                              isSuccess = false;
                                              break;
                                            }
                                          } else {
                                            EasyLoading.dismiss();
                                            _isSelected == "English" ?
                                            AppConstants.show_toast("Please select $dayOfWeek's time"):
                                            AppConstants.show_toast("अपडेट करने के लिए कुछ नया नहीं है\nकृपया कम से कम एक दिन का समय चुनें");
                                            isSuccess = false;
                                            break;
                                          }
                                        }
                                      }

                                      print('-------------------');
                                    });


                                  }

                                  Future.delayed(const Duration(seconds: 5), (){
                                    if(isSuccess) {
                                      EasyLoading.dismiss();
                                      AppConstants.showDialogueBox(
                                        title: "Success",
                                        body: "Time availability successfully updated!",
                                        isSuccess: true,
                                        context: context,
                                      );
                                    }
                                  });
                                  // int hourlyFee = int.parse(hourlyFeeController.text);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: height * 0.055,
                                  width:  width * 0.80,
                                  decoration: BoxDecoration(
                                      color: ColorResources.ORANGE,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: _isSelected == "English"
                                      ? Text("UPDATE",
                                      style:
                                      poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE))
                                      : Text("अपडेट करें",
                                      style:
                                      poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          buildDayWidget(
                            dayOfWeek: 'Monday',
                            appointments: {},
                            sessionType: AppConstants.sessionType,
                            dayTimings: mondayTimings!,
                          ),
                          buildDayWidget(
                            dayOfWeek: 'Tuesday',
                            appointments: {},
                            sessionType: AppConstants.sessionType,
                            dayTimings: tuesdayTimings!,
                          ),
                          buildDayWidget(
                            dayOfWeek: 'Wednesday',
                            appointments: {},
                            sessionType: AppConstants.sessionType,
                              dayTimings: wednesdayTimings!,
                          ),
                          buildDayWidget(
                            dayOfWeek: 'Thursday',
                            appointments: {},
                            sessionType: AppConstants.sessionType,
                              dayTimings: thursdayTimings!,
                          ),
                          buildDayWidget(
                            dayOfWeek: 'Friday',
                            appointments: {},
                            sessionType: AppConstants.sessionType,
                              dayTimings: fridayTimings!,
                          ),
                          buildDayWidget(
                            dayOfWeek: 'Saturday',
                            appointments: {},
                            sessionType: AppConstants.sessionType,
                            dayTimings: saturdayTimings!,
                          ),
                        ],
                      );
                    }
                  } else if (snapshot.hasError) {
                    return SizedBox(
                      height: height,
                      child: Center(child: Text('Error: ${snapshot.error}'))
                    );
                  } else {
                    return SizedBox(
                      height: height,
                      child: const Center(
                        child: CircularProgressIndicator(color: ColorResources.ORANGE,)
                      )
                    );
                  }
              }
            ),
          ),
        ),
      ): const Center(child: CircularProgressIndicator(),),
    );
  }


  Widget buildDayWidget({
    required String dayOfWeek,
    required ValueNotifier<String> sessionType,
    required Map<String, dynamic> appointments,
    required List<ValueNotifier<String?>> dayTimings
  }) {
    if (appointments[dayOfWeek] != null) {
      List<TimeOfDay> startTimeList = [];
      List<TimeOfDay> endTimeList = [];

      appointments[dayOfWeek].forEach((startTime, endTime) {
        final startParts = startTime.split(':');
        final endParts = endTime.split(':');

        final start = TimeOfDay(hour: int.parse(startParts[0]), minute: int.parse(startParts[1]));
        final end = TimeOfDay(hour: int.parse(endParts[0]), minute: int.parse(endParts[1]));

        startTimeList.add(start);
        endTimeList.add(end);
      });

      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;

      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Table(
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          dayOfWeek,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TableCell(
                        child: ValueListenableBuilder<String?>(
                          valueListenable: sessionType,
                          builder: (context, value, _) {
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    sessionType.value = "group";
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: height * 0.045,
                                    width:  width * 0.20,
                                    decoration: BoxDecoration(
                                        color: value == "group" ? ColorResources.GREY: ColorResources.ORANGE,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: _isSelected == "English"
                                        ? Text("Group",
                                        style:
                                        poppinsBold.copyWith(fontSize: 15,color: ColorResources.WHITE))
                                        : Text("अपडेट करें",
                                        style:
                                        poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE)),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    sessionType.value = "one_to_one";
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: height * 0.045,
                                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                                    decoration: BoxDecoration(
                                        color: value == "one_to_one" ? ColorResources.GREY: ColorResources.ORANGE,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: _isSelected == "English"
                                        ? Text("Individual",
                                        style:
                                        poppinsBold.copyWith(fontSize: 14,color: ColorResources.WHITE))
                                        : Text("अपडेट करें",
                                        style:
                                        poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE)),
                                  ),
                                )
                              ],
                            );
                            // return DropdownButton<String>(
                            //   value: value,
                            //   items: <String>[
                            //     "Select type",
                            //     "one_to_one",
                            //     "group"
                            //   ].map((String value) {
                            //     return DropdownMenuItem<String>(
                            //       value: value,
                            //       child: Text(value),
                            //     );
                            //   }).toList(),
                            //   onChanged: (String? newValue) {
                            //     sessionType.value = newValue!;
                            //   },
                            // );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_isSelected == "English" ? "Current" : "समय",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Text(_isSelected == "English" ? 'From: ' : 'से: ',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 10),
                        Text(AppConstants.convertTime("${startTimeList.first.hour}:${startTimeList.first.minute}")),
                      ],
                    ),
                    Row(
                      children: [
                        Text(_isSelected == "English" ? 'To: ' : 'को: ',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 28),
                        Text(AppConstants.convertTime("${endTimeList.last.hour}:${endTimeList.last.minute}")),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_isSelected == "English" ? "New Timing" : "समय",
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        InkWell(
                          onTap: () {
                            setState(() {
                              print(AppConstants.dayTimings);
                              AppConstants.addTiming(dayOfWeek);
                            });
                          },
                          child: Row(
                            children: const [
                              Text("Add New Timing"),
                              SizedBox(width: 5,),
                              Icon(Icons.add),
                            ],
                          ),
                        ),
                      ],
                    ),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: (dayTimings.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        final startTimeNotifier = dayTimings[index * 2];
                        final endTimeNotifier = dayTimings[(index * 2) + 1];

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Column(
                                    children: [
                                      ValueListenableBuilder<String?>(
                                        valueListenable: startTimeNotifier,
                                        builder: (context, value, _) {
                                          try {
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(_isSelected == "English" ? 'From: ' : 'से: ',
                                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                                    const SizedBox(width: 10),
                                                    Text(AppConstants.convertTime(value.toString())),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(_isSelected == "English" ? 'To: ' : 'को: ',
                                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                                    const SizedBox(width: 28),
                                                    ValueListenableBuilder<String?>(
                                                      valueListenable: endTimeNotifier,
                                                      builder: (context, value, _) {
                                                        try {
                                                          return Text(AppConstants.convertTime(value.toString()));
                                                        } catch (e) {
                                                          return const Text("");
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          } catch (e) {
                                            return const Text("Needs to be set  ");
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 25, top: 15, right: 25),
                                        child: InkWell(
                                          onTap: () => showDarkTimePicker(timeStart: startTimeNotifier, timeEnd: endTimeNotifier),
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: height * 0.055,
                                            width: width * 0.25,
                                            decoration: BoxDecoration(
                                                color: ColorResources.ORANGE,
                                                borderRadius: BorderRadius.circular(5)),
                                            child: _isSelected == "English"
                                                ? Text("Select Time",
                                                style: poppinsBold.copyWith(fontSize: 14, color: ColorResources.WHITE))
                                                : Text("अपडेट करें",
                                                style: poppinsBold.copyWith(fontSize: 14, color: ColorResources.WHITE)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20,),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              if(AppConstants.dayTimings[dayOfWeek]!.isNotEmpty)
                Table(
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Text(
                            dayOfWeek,
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        TableCell(
                          child: ValueListenableBuilder<String?>(
                            valueListenable: sessionType,
                            builder: (context, value, _) {
                              return Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      sessionType.value = "group";
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: height * 0.045,
                                      width:  width * 0.20,
                                      decoration: BoxDecoration(
                                          color: value == "group" ? ColorResources.GREY: ColorResources.ORANGE,
                                          borderRadius: BorderRadius.circular(5)),
                                      child: _isSelected == "English"
                                          ? Text("Group",
                                          style:
                                          poppinsBold.copyWith(fontSize: 15,color: ColorResources.WHITE))
                                          : Text("अपडेट करें",
                                          style:
                                          poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE)),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  InkWell(
                                    onTap: () {
                                      sessionType.value = "one_to_one";
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: height * 0.045,
                                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                                      decoration: BoxDecoration(
                                          color: value == "one_to_one" ? ColorResources.GREY: ColorResources.ORANGE,
                                          borderRadius: BorderRadius.circular(5)),
                                      child: _isSelected == "English"
                                          ? Text("Individual",
                                          style:
                                          poppinsBold.copyWith(fontSize: 14,color: ColorResources.WHITE))
                                          : Text("अपडेट करें",
                                          style:
                                          poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE)),
                                    ),
                                  )
                                ],
                              );
                              // return DropdownButton<String>(
                              //   value: value,
                              //   items: <String>[
                              //     "Select type",
                              //     "one_to_one",
                              //     "group"
                              //   ].map((String value) {
                              //     return DropdownMenuItem<String>(
                              //       value: value,
                              //       child: Text(value),
                              //     );
                              //   }).toList(),
                              //   onChanged: (String? newValue) {
                              //     sessionType.value = newValue!;
                              //   },
                              // );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              else
                Table(
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Text(
                            dayOfWeek,
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const TableCell(
                          child: SizedBox(width: 5),
                        ),
                      ],
                    ),
                  ],
                ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       dayOfWeek,
              //       style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              //     ),
              //     const SizedBox(width: 30,),
              //     ValueListenableBuilder<String?>(
              //       valueListenable: sessionType,
              //       builder: (context, value, _) {
              //         return Row(
              //           children: [
              //             InkWell(
              //               onTap: () {
              //                 sessionType.value = "group";
              //               },
              //               child: Container(
              //                 alignment: Alignment.center,
              //                 height: height * 0.045,
              //                 width:  width * 0.20,
              //                 decoration: BoxDecoration(
              //                     color: value == "group" ? ColorResources.GREY: ColorResources.ORANGE,
              //                     borderRadius: BorderRadius.circular(5)),
              //                 child: _isSelected == "English"
              //                     ? Text("Group",
              //                     style:
              //                     poppinsBold.copyWith(fontSize: 15,color: ColorResources.WHITE))
              //                     : Text("अपडेट करें",
              //                     style:
              //                     poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE)),
              //               ),
              //             ),
              //             const SizedBox(width: 5),
              //             InkWell(
              //               onTap: () {
              //                 sessionType.value = "one_to_one";
              //               },
              //               child: Container(
              //                 alignment: Alignment.center,
              //                 height: height * 0.045,
              //                 padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              //                 decoration: BoxDecoration(
              //                     color: value == "one_to_one" ? ColorResources.GREY: ColorResources.ORANGE,
              //                     borderRadius: BorderRadius.circular(5)),
              //                 child: _isSelected == "English"
              //                     ? Text("Individual",
              //                     style:
              //                     poppinsBold.copyWith(fontSize: 14,color: ColorResources.WHITE))
              //                     : Text("अपडेट करें",
              //                     style:
              //                     poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE)),
              //               ),
              //             )
              //           ],
              //         );
              //         // return DropdownButton<String>(
              //         //   value: value,
              //         //   items: <String>[
              //         //     "Select type",
              //         //     "one_to_one",
              //         //     "group"
              //         //   ].map((String value) {
              //         //     return DropdownMenuItem<String>(
              //         //       value: value,
              //         //       child: Text(value),
              //         //     );
              //         //   }).toList(),
              //         //   onChanged: (String? newValue) {
              //         //     sessionType.value = newValue!;
              //         //   },
              //         // );
              //       },
              //     )
              //   ],
              // ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_isSelected == "English" ? "New Timing" : "समय",
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        InkWell(
                          onTap: () {
                            setState(() {
                              print(AppConstants.dayTimings);
                              AppConstants.addTiming(dayOfWeek);
                            });
                          },
                          child: Row(
                            children: const [
                              Text("Add New Timing"),
                              SizedBox(width: 5,),
                              Icon(Icons.add),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ValueListenableBuilder<List<ValueNotifier<String?>>>(
                      valueListenable: ValueNotifier<List<ValueNotifier<String?>>>(dayTimings),
                      builder: (context, value, _) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: (value.length / 2).ceil(),
                          itemBuilder: (context, index) {
                            final startTimeNotifier = value[index * 2];
                            final endTimeNotifier = value[(index * 2) + 1];

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Column(
                                        children: [
                                          ValueListenableBuilder<String?>(
                                            valueListenable: startTimeNotifier,
                                            builder: (context, value, _) {
                                              try {
                                                return Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(_isSelected == "English" ? 'From: ' : 'से: ',
                                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                                        const SizedBox(width: 10),
                                                        Text(AppConstants.convertTime(value.toString())),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(_isSelected == "English" ? 'To: ' : 'को: ',
                                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                                        const SizedBox(width: 28),
                                                        ValueListenableBuilder<String?>(
                                                          valueListenable: endTimeNotifier,
                                                          builder: (context, value, _) {
                                                            try {
                                                              return Text(AppConstants.convertTime(value.toString()));
                                                            } catch (e) {
                                                              return const Text("");
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              } catch (e) {
                                                return const Text("Needs to be set    ");
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    FittedBox(
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(left: 25, top: 15, right: 25),
                                            child: InkWell(
                                              onTap: () => showDarkTimePicker(timeStart: startTimeNotifier, timeEnd: endTimeNotifier),
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: height * 0.055,
                                                width: width * 0.25,
                                                decoration: BoxDecoration(
                                                    color: ColorResources.ORANGE,
                                                    borderRadius: BorderRadius.circular(5)),
                                                child: _isSelected == "English"
                                                    ? Text("Select Time",
                                                    style: poppinsBold.copyWith(fontSize: 14, color: ColorResources.WHITE))
                                                    : Text("अपडेट करें",
                                                    style: poppinsBold.copyWith(fontSize: 14, color: ColorResources.WHITE)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20,),
                              ],
                            );
                          },
                        );
                      }
                    )
                    ,
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  // Future<bool> updateDayTimeSlot({
  //   required String day,
  //   required String startTime,
  //   required String endTime,
  //   required String sessionType,
  // }) async {
  //   bool isSuccess = await HttpService.editTimeAvailabilityApi(
  //     userId: widget.userDetails.first.id,
  //     startTime: startTime,
  //     endTime: endTime,
  //     day: day,
  //     sessionType: sessionType,
  //   ).then((value) {
  //
  //     if (value['success'] == "true" || value['success'] == true) {
  //       clearAll();
  //       return true;
  //     } else {
  //       print("Failed to update");
  //       return false;
  //     }
  //   });
  //
  //   return isSuccess;
  // }

  void clearAll() {
    AppConstants.dayTimings = {
      'Monday': [],
      'Tuesday': [],
      'Wednesday': [],
      'Thursday': [],
      'Friday': [],
      'Saturday': [],
    };
    AppConstants.daySessionType = {
      'Monday': ValueNotifier<String>("Select type"),
      'Tuesday': ValueNotifier<String>("Select type"),
      'Wednesday': ValueNotifier<String>("Select type"),
      'Thursday': ValueNotifier<String>("Select type"),
      'Friday': ValueNotifier<String>("Select type"),
      'Saturday': ValueNotifier<String>("Select type"),
    };
  }


  // Use the helper function to update multiple time slots
  // Future<void> updateMultipleTimeSlots() async {
  //
  //   if (AppConstants.mondayStartTime.value != null) {
  //     if (AppConstants.mondaySessionType.value != "Select type") {
  //       bool mondayResult = await updateDayTimeSlot(
  //         day: "Monday",
  //         startTime: AppConstants.mondayStartTime.value!,
  //         endTime: AppConstants.mondayEndTime.value!,
  //         sessionType: AppConstants.mondaySessionType.value,
  //       );
  //       if (mondayResult) {
  //         AppConstants.mondayStartTime.value = null;
  //         AppConstants.mondayEndTime.value = null;
  //         print("Monday updated");
  //       }
  //     } else {
  //       AppConstants.show_toast(_isSelected == "English"
  //           ? "Please select Monday's session type"
  //           : "कृपया सोमवार के सत्र प्रकार का चयन करें");
  //     }
  //   }
  //
  //   if (AppConstants.tuesdayStartTime.value != null) {
  //     if (AppConstants.tuesdaySessionType.value != "Select type") {
  //       bool tuesdayResult = await updateDayTimeSlot(
  //         day: "Tuesday",
  //         startTime: AppConstants.tuesdayStartTime.value!,
  //         endTime: AppConstants.tuesdayEndTime.value!,
  //         sessionType: AppConstants.tuesdaySessionType.value,
  //       );
  //       if (tuesdayResult) {
  //         AppConstants.tuesdayStartTime.value = null;
  //         AppConstants.tuesdayEndTime.value = null;
  //         print("Tuesday updated");
  //       }
  //     } else {
  //       AppConstants.show_toast(_isSelected == "English"
  //           ? "Please select Tuesday's session type"
  //           : "कृपया मंगलवार के सत्र प्रकार का चयन करें");
  //     }
  //   }
  //
  //   if (AppConstants.wednesdayStartTime.value != null) {
  //     if(AppConstants.wednesdaySessionType.value != "Select type") {
  //       bool wednesdayResult = await updateDayTimeSlot(
  //         day: "Wednesday",
  //         startTime: AppConstants.wednesdayStartTime.value!,
  //         endTime: AppConstants.wednesdayEndTime.value!,
  //         sessionType: AppConstants.wednesdaySessionType.value,
  //       );
  //       if (wednesdayResult) {
  //         AppConstants.wednesdayStartTime.value = null;
  //         AppConstants.wednesdayEndTime.value = null;
  //         print("wednesday updated");
  //       }
  //     } else {
  //       _isSelected == "English"?
  //       AppConstants.show_toast("Please select Wednesday's session type"):
  //       AppConstants.show_toast("कृपया शनिवार के सत्र प्रकार का चयन करें");
  //     }
  //
  //   }
  //   if (AppConstants.thursdayStartTime.value != null) {
  //     if(AppConstants.thursdaySessionType.value != "Select type") {
  //       bool thursdayResult = await updateDayTimeSlot(
  //         day: "Thursday",
  //         startTime: AppConstants.thursdayStartTime.value!,
  //         endTime: AppConstants.thursdayEndTime.value!,
  //         sessionType: AppConstants.thursdaySessionType.value,
  //       );
  //       if (thursdayResult) {
  //         AppConstants.thursdayStartTime.value = null;
  //         AppConstants.thursdayEndTime.value = null;
  //         print("thursday updated");
  //       }
  //     } else {
  //       _isSelected == "English"?
  //       AppConstants.show_toast("Please select Thursday's session type"):
  //       AppConstants.show_toast("कृपया शनिवार के सत्र प्रकार का चयन करें");
  //     }
  //   }
  //
  //   if (AppConstants.fridayStartTime.value != null) {
  //     if(AppConstants.fridaySessionType.value != "Select type") {
  //       bool fridayResult = await updateDayTimeSlot(
  //         day: "Friday",
  //         startTime: AppConstants.fridayStartTime.value!,
  //         endTime: AppConstants.fridayEndTime.value!,
  //         sessionType: AppConstants.fridaySessionType.value,
  //       );
  //       if (fridayResult) {
  //         AppConstants.fridayStartTime.value = null;
  //         AppConstants.fridayEndTime.value = null;
  //         print("friday updated");
  //       }
  //     } else {
  //       _isSelected == "English"?
  //       AppConstants.show_toast("Please select Friday's session type"):
  //       AppConstants.show_toast("कृपया शनिवार के सत्र प्रकार का चयन करें");
  //     }
  //   }
  //
  //   if (AppConstants.saturdayStartTime.value != null) {
  //     if(AppConstants.saturdaySessionType.value != "Select type") {
  //       bool saturdayResult = await updateDayTimeSlot(
  //         day: "Saturday",
  //         startTime: AppConstants.saturdayStartTime.value!,
  //         endTime: AppConstants.saturdayEndTime.value!,
  //         sessionType: AppConstants.saturdaySessionType.value,
  //       );
  //       if (saturdayResult) {
  //         AppConstants.saturdayStartTime.value = null;
  //         AppConstants.saturdayEndTime.value = null;
  //         print("saturday updated");
  //       }
  //     } else {
  //       _isSelected == "English"?
  //       AppConstants.show_toast("Please select Saturday's session type"):
  //       AppConstants.show_toast("कृपया शनिवार के सत्र प्रकार का चयन करें");
  //     }
  //   }
  //
  // }

  // bool updateTimings() {
  //   if(isAllNull()) {
  //     _isSelected == "English" ?
  //     AppConstants.show_toast("Nothing new to be updated\nPlease select at least one day time"):
  //     AppConstants.show_toast("अपडेट करने के लिए कुछ नया नहीं है\nकृपया कम से कम एक दिन का समय चुनें");
  //     return false;
  //   } else {
  //     bool isRunning = true;
  //     if (AppConstants.mondayStartTime.value != null ||
  //         AppConstants.tuesdayStartTime.value != null ||
  //         AppConstants.wednesdayStartTime.value != null ||
  //         AppConstants.thursdayStartTime.value != null ||
  //         AppConstants.fridayStartTime.value != null ||
  //         AppConstants.saturdayStartTime.value != null) {
  //
  //       if (AppConstants.mondayStartTime.value != null) {
  //         if(AppConstants.mondaySessionType.value != "Select type") {
  //           updateTime(
  //             day: "Monday",
  //             startTime: AppConstants.mondayStartTime.value!,
  //             endTime: AppConstants.mondayEndTime.value!,
  //             sessionType: AppConstants.mondaySessionType.value,
  //           ).then((value) => {
  //             AppConstants.mondayStartTime.value = null,
  //             AppConstants.mondayEndTime.value = null,
  //           });
  //           isRunning = false;
  //           print("monday updated");
  //         } else {
  //           _isSelected == "English"?
  //             AppConstants.show_toast("Please select Monday's session type"):
  //             AppConstants.show_toast("कृपया शनिवार के सत्र प्रकार का चयन करें");
  //           isRunning = true;
  //         }
  //
  //       }
  //       if (AppConstants.tuesdayStartTime.value != null) {
  //         if(AppConstants.tuesdaySessionType.value != "Select type") {
  //           updateTime(
  //             day: "Tuesday",
  //             startTime: AppConstants.tuesdayStartTime.value!,
  //             endTime: AppConstants.tuesdayEndTime.value!,
  //             sessionType: AppConstants.tuesdaySessionType.value,
  //           ).then((value) => {
  //             AppConstants.tuesdayStartTime.value = null,
  //             AppConstants.tuesdayEndTime.value = null,
  //           });
  //           isRunning = false;
  //           print("tuesday updated");
  //         } else {
  //           _isSelected == "English"?
  //           AppConstants.show_toast("Please select Tuesday's session type"):
  //           AppConstants.show_toast("कृपया शनिवार के सत्र प्रकार का चयन करें");
  //           isRunning = true;
  //         }
  //
  //       }
  //       if (AppConstants.wednesdayStartTime.value != null) {
  //         if(AppConstants.wednesdaySessionType.value != "Select type") {
  //           updateTime(
  //             day: "Wednesday",
  //             startTime: AppConstants.wednesdayStartTime.value!,
  //             endTime: AppConstants.wednesdayEndTime.value!,
  //             sessionType: AppConstants.wednesdaySessionType.value,
  //           ).then((value) => {
  //             AppConstants.wednesdayStartTime.value = null,
  //             AppConstants.wednesdayEndTime.value = null,
  //           });
  //           isRunning = false;
  //           print("wednesday updated");
  //         } else {
  //           _isSelected == "English"?
  //           AppConstants.show_toast("Please select Wednesday's session type"):
  //           AppConstants.show_toast("कृपया शनिवार के सत्र प्रकार का चयन करें");
  //           isRunning = true;
  //         }
  //
  //       }
  //       if (AppConstants.thursdayStartTime.value != null) {
  //         if(AppConstants.thursdaySessionType.value != "Select type") {
  //           updateTime(
  //             day: "Thursday",
  //             startTime: AppConstants.thursdayStartTime.value!,
  //             endTime: AppConstants.thursdayEndTime.value!,
  //             sessionType: AppConstants.thursdaySessionType.value,
  //           ).then((value) => {
  //             AppConstants.thursdayStartTime.value = null,
  //             AppConstants.thursdayEndTime.value = null,
  //           });
  //           isRunning = false;
  //           print("thursday updated");
  //         } else {
  //           _isSelected == "English"?
  //           AppConstants.show_toast("Please select Thursday's session type"):
  //           AppConstants.show_toast("कृपया शनिवार के सत्र प्रकार का चयन करें");
  //           isRunning = true;
  //         }
  //
  //       }
  //       if (AppConstants.fridayStartTime.value != null) {
  //         if(AppConstants.fridaySessionType.value != "Select type") {
  //           updateTime(
  //             day: "Friday",
  //             startTime: AppConstants.fridayStartTime.value!,
  //             endTime: AppConstants.fridayEndTime.value!,
  //             sessionType: AppConstants.fridaySessionType.value,
  //           ).then((value) => {
  //             AppConstants.fridayStartTime.value = null,
  //             AppConstants.fridayEndTime.value = null,
  //           });
  //           isRunning = false;
  //           print("friday updated");
  //         } else {
  //           _isSelected == "English"?
  //           AppConstants.show_toast("Please select Friday's session type"):
  //           AppConstants.show_toast("कृपया शनिवार के सत्र प्रकार का चयन करें");
  //           isRunning = true;
  //         }
  //
  //       }
  //       if (AppConstants.saturdayStartTime.value != null) {
  //         if(AppConstants.saturdaySessionType.value != "Select type") {
  //           updateTime(
  //             day: "Saturday",
  //             startTime: AppConstants.saturdayStartTime.value!,
  //             endTime: AppConstants.saturdayEndTime.value!,
  //             sessionType: AppConstants.saturdaySessionType.value,
  //           ).then((value) => {
  //             AppConstants.saturdayStartTime.value = null,
  //             AppConstants.saturdayEndTime.value = null,
  //           });
  //           print("saturday updated");
  //           isRunning = false;
  //         } else {
  //           _isSelected == "English"?
  //           AppConstants.show_toast("Please select Saturday's session type"):
  //           AppConstants.show_toast("कृपया शनिवार के सत्र प्रकार का चयन करें");
  //           isRunning = true;
  //         }
  //       }
  //
  //       return !isRunning;
  //     }
  //     // Check if all days' timings are null
  //     else if (AppConstants.mondayStartTime.value == null &&
  //         AppConstants.tuesdayStartTime.value == null &&
  //         AppConstants.wednesdayStartTime.value == null &&
  //         AppConstants.thursdayStartTime.value == null &&
  //         AppConstants.fridayStartTime.value == null &&
  //         AppConstants.saturdayStartTime.value == null) {
  //
  //       _isSelected == "English"?
  //       AppConstants.show_toast("Please select a day to update timings."):
  //       AppConstants.show_toast("कृपया शनिवार के सत्र प्रकार का चयन करें");
  //       return false;
  //     }
  //     else {
  //       _isSelected == "English"?
  //       AppConstants.show_toast("Some of timings failed to update"):
  //       AppConstants.show_toast("कृपया शनिवार के सत्र प्रकार का चयन करें");
  //       return false;
  //     }
  //
  //     // if(AppConstants.saturdayStartTime.value != null){
  //     //   if(AppConstants.saturdaySessionType.value != "Select type") {
  //     //
  //     //   } else {
  //     //     _isSelected == "English"?
  //     //     AppConstants.show_toast("Please select Saturday's session type"):
  //     //     AppConstants.show_toast("कृपया शनिवार के सत्र प्रकार का चयन करें");
  //     //   }
  //     //
  //     // }
  //     // EasyLoading.dismiss();
  //     // showDialogueBox("Success", "Time availability successfully updated!", true);
  //   }
  // }

}
