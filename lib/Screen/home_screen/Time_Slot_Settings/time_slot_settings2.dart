import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:miniplayer/miniplayer.dart';

import '../../../Chat/service/database_service.dart';
import '../../../Controllers/stream_controller.dart';
import '../../../Controllers/time_slot_controller.dart';
import '../../../Controllers/user_controller.dart';
import '../../../HttpService/HttpService.dart';
import '../../../HttpService/model/Get_uesr_detali_model.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../../stream/video_screen.dart';

class TimeSlotSettings extends StatefulWidget {
  final String langType;
  const TimeSlotSettings({Key? key, required this.langType}) : super(key: key);

  static const String routeName = '/timeslotRoute';

  @override
  State<TimeSlotSettings> createState() => _TimeSlotSettingsState();
}

class _TimeSlotSettingsState extends State<TimeSlotSettings> {
  final Rx<DateTime> _selectedDate = DateTime.now().obs;
  final TimeSlotController controller = Get.find<TimeSlotController>();
  final UserController userController = Get.find<UserController>();
  final LiveStreamController streamController = Get.find<LiveStreamController>();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTimingsByDate();
    createKey(
      date: DateFormat('y-MM-d').format(_selectedDate.value),
      sessionType: "group",
    );
    // addToSchedule(controller.test, DateFormat('y-MM-d').format(_selectedDate.value), "group", []);
  }

  void getTimingsByDate() {
    List<String> newTimingsGroup = [];
    List<String> newTimingsIndividual = [];

    for(var item in userController.userDetails.first.availability!) {
      String currentDate = DateFormat('y-MM-dd').format(_selectedDate.value);
      createKey(date: currentDate, sessionType: "group");
      createKey(date: currentDate, sessionType: "one_to_one");

      if(item.date == currentDate) {
        if(item.sessionType == "group") {
          newTimingsGroup.add(item.time);
        } else {
          newTimingsIndividual.add(item.time);
        }
      }
    }

    // for(int i = 0; i<newTimingsGroup.length; i++) {
    //   finalTimingsGroup.addAll({
    //     "time": newTimingsGroup[i],
    //     "isBooked": newIsBookedGroup[i],
    //   });
    // }
    //
    // print("final timings Group");
    // print(finalTimingsGroup);
    //
    // for(int i = 0; i<newTimingsIndividual.length; i++) {
    //   finalTimingsIndividual.addAll({
    //     "time": newTimingsIndividual[i],
    //     "isBooked": newIsBookedIndividual[i],
    //   });
    // }
    //
    // print("final timings Individual");
    // print(finalTimingsIndividual);

    controller.formattedMorningTimingsGroup.value = formatTimings(getTimingsList(newTimingsGroup, "morning"));
    controller.formattedAfternoonTimingsGroup.value = formatTimings(getTimingsList(newTimingsGroup, "afternoon"));
    controller.formattedEveningTimingsGroup.value = formatTimings(getTimingsList(newTimingsGroup, "evening"));

    controller.formattedMorningTimingsIndividual.value = formatTimings(getTimingsList(newTimingsIndividual, "morning"));
    controller.formattedAfternoonTimingsIndividual.value = formatTimings(getTimingsList(newTimingsIndividual, "afternoon"));
    controller.formattedEveningTimingsIndividual.value = formatTimings(getTimingsList(newTimingsIndividual, "evening"));
  }

  List<DateTime> getTimingsList(List times, String whichTiming) {
    final List<DateTime> dateTimes = times.map((time) {
      final parts = time.split(" ");
      final hour = int.parse(parts[0]);
      final isAM = parts[1] == "AM";
      return DateTime(2023, 1, 1, isAM ? hour : hour + 12);
    }).toList();

    dateTimes.sort();

    final List<DateTime> morningTimings = [];
    final List<DateTime> afternoonTimings = [];
    final List<DateTime> eveningTimings = [];

    for (final time in dateTimes) {
      if (time.hour >= 5 && time.hour < 12) {
        morningTimings.add(time);
      } else if (time.hour >= 12 && time.hour < 17) {
        afternoonTimings.add(time);
      } else if (time.hour >= 17) {
        eveningTimings.add(time);
      }
    }

    if(whichTiming == "morning") {
      return morningTimings;
    } else if(whichTiming == "afternoon") {
      return afternoonTimings;
    } else {
      return eveningTimings;
    }
  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final List<DateTime> dateTimes = controller.times.map((time) {
      final parts = time.split(" ");
      final hour = int.parse(parts[0]);
      final isAM = parts[1] == "AM";

      return DateTime(2023, 1, 1, isAM ? hour : hour + 12);
    }).toList();

    dateTimes.sort();

    final List<DateTime> morningTimings = [];
    final List<DateTime> afternoonTimings = [];
    final List<DateTime> eveningTimings = [];

    for (final time in dateTimes) {
      if (time.hour >= 5 && time.hour < 12) {
        morningTimings.add(time);
      } else if (time.hour >= 12 && time.hour < 17) {
        afternoonTimings.add(time);
      } else if (time.hour >= 17) {
        eveningTimings.add(time);
      }
    }

    final List<String> formattedMorningTimings = formatTimings(morningTimings);
    final List<String> formattedAfternoonTimings =
    formatTimings(afternoonTimings);
    final List<String> formattedEveningTimings = formatTimings(eveningTimings);

    // print(userDetails.first.availability);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading:IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_sharp,color: ColorResources.BLACK,)),
        title: Text(widget.langType == "English" ? 'Time Slot Settings': 'टाइम स्लॉट सेटिंग्स',
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
          RefreshIndicator(
            onRefresh: () async {
              EasyLoading.show();
              getApi();
              EasyLoading.dismiss();
            },
            child: SizedBox(
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
                    borderRadius: BorderRadius.circular(05),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        Column(
                          children: [
                            Text(widget.langType == "English" ? 'Choose a date & time': 'दिनांक और समय चुनें',
                                style: poppinsMedium.copyWith(
                                    color: ColorResources.BLACK, fontSize: width*0.055)),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 70,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: null,
                                itemBuilder: (context, index) {
                                  // final date = DateTime.now().add(Duration(days: index));
                                  // if (date.year != DateTime.now().year && date.month != DateTime.now().month) {
                                  //   return const SizedBox.shrink();
                                  // }

                                  final currentDate = DateTime.now().add(Duration(days: index));
                                  final date = DateTime(currentDate.year, currentDate.month, currentDate.day);

                                  return Obx(() => CalendarDay(
                                    date: date,
                                    selectedDate: DateFormat('y-MM-d').format(_selectedDate.value),
                                    onDateSelected: (date) {
                                      String dateFormatted = DateFormat('y-MM-d').format(date);
                                      String sessionType = controller.sessionType.value == "Group" ? "group": "one_to_one";
                                      _selectedDate.value = date.obs.value;
                                      // clearData();
                                      getTimingsByDate();
                                      createKey(
                                        date: dateFormatted,
                                        sessionType: "group",
                                      );
                                      createKey(
                                        date: dateFormatted,
                                        sessionType: "one_to_one",
                                      );
                                      // addToSchedule(controller.test, dateFormatted, sessionType, []);
                                    },
                                  ));
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.sessionType.value = "Group";
                                    String dateFormatted = DateFormat('y-MM-d').format(_selectedDate.value);
                                    createKey(
                                      date: dateFormatted,
                                      sessionType: "group",
                                    );
                                    // addToSchedule(controller.test, dateFormatted, "group", []);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: height * 0.055,
                                    width:  width * 0.20,
                                    decoration: BoxDecoration(
                                      color: controller.sessionType.value == "Group" ? ColorResources.ORANGE: ColorResources.GREY,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(widget.langType == "English" ? "Group": "अपडेट करें",
                                      style: poppinsBold.copyWith(fontSize: 15,color: ColorResources.WHITE),
                                    )
                                  ),
                                ),
                                const SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    controller.sessionType.value = "Individual";
                                    String dateFormatted = DateFormat('y-MM-d').format(_selectedDate.value);
                                    createKey(date: dateFormatted, sessionType: "one_to_one");
                                    // addToSchedule(controller.test, dateFormatted, "one_to_one", []);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: height * 0.055,
                                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                                    decoration: BoxDecoration(
                                        color: controller.sessionType.value == "Individual" ? ColorResources.ORANGE: ColorResources.GREY,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(widget.langType == "English" ? "Individual": "अपडेट करें",
                                      style:poppinsBold.copyWith(fontSize: 14,color: ColorResources.WHITE),
                                    )
                                  ),
                                )
                              ],
                            )),
                            const SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                width: width,
                                decoration: BoxDecoration(
                                  color: ColorResources.WHITE,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(05),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0, right: 30, left: 30),
                                      child: Obx(() => Text(
                                        widget.langType == "English" ?
                                        "Select a timeslot for your ${controller.sessionType.value} session":
                                        "अपने ${controller.sessionType.value == "group" ? "समूह": "व्यक्ति"} सत्र के लिए समयावधि चुनें",
                                        style: poppinsRegular.copyWith(
                                          color: ColorResources.BLACK, fontSize: 12,
                                        ),
                                      )),
                                    ),
                                    DataTable(
                                      columns: <DataColumn>[
                                        DataColumn(
                                          label: Container(
                                            alignment: Alignment.center,
                                            child: const Text(
                                              '',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: <DataRow>[
                                        DataRow(
                                          cells: <DataCell>[
                                            DataCell(
                                              FittedBox(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(widget.langType == "English" ?
                                                    'The color grey indicates that the slot time has passed':
                                                    'हरा रंग इंगित करता है कि स्लॉट पहले ही अपडेट हो चुका है'
                                                    ),
                                                    const SizedBox(width: 8), // Add some spacing between the name and color
                                                    Container(
                                                      width: 16,
                                                      height: 16,
                                                      decoration: BoxDecoration(
                                                        color: ColorResources.GREY.withOpacity(0.6), // John's favorite color
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        DataRow(
                                          cells: <DataCell>[
                                            DataCell(
                                              FittedBox(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(widget.langType == "English" ?
                                                    'The color green indicates that the slot is already updated':
                                                    'हरा रंग इंगित करता है कि स्लॉट पहले ही अपडेट हो चुका है'
                                                    ),
                                                    const SizedBox(width: 8), // Add some spacing between the name and color
                                                    Container(
                                                      width: 16,
                                                      height: 16,
                                                      decoration: const BoxDecoration(
                                                        color: ColorResources.GREEN, // John's favorite color
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        DataRow(
                                          cells: <DataCell>[
                                            DataCell(
                                              FittedBox(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(widget.langType == "English" ?
                                                      'The color orange indicates that the slot is selected':
                                                      'नारंगी रंग इंगित करता है कि स्लॉट का चयन किया गया है'
                                                    ),
                                                    const SizedBox(width: 8), // Add some spacing between the name and color
                                                    Container(
                                                      width: 16,
                                                      height: 16,
                                                      decoration: const BoxDecoration(
                                                        color: ColorResources.ORANGE, // John's favorite color
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              const Image(image: AssetImage("assets/image/morning.png"), height: 30,),
                                              Text(widget.langType == "English" ?
                                                'Morning': "सुबह",
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Obx(() {
                                          if(controller.sessionType.value == "Group"){
                                            return Expanded(
                                              child: GridView.count(
                                                shrinkWrap: true,
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 5.0,
                                                childAspectRatio: 3.5,
                                                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
                                                crossAxisSpacing: 5.0,
                                                physics: const NeverScrollableScrollPhysics(),
                                                children: [
                                                  for (final timing in formattedMorningTimings) ...[
                                                    !isTimePassed(timing) ?
                                                    Obx(() => InkWell(
                                                      onTap: () {
                                                        String dateFormatted = DateFormat('y-MM-d').format(_selectedDate.value);
                                                        if(controller.formattedMorningTimingsGroup.contains(timing)) {
                                                          print("already set");
                                                        } else {
                                                          if(controller.selectedGroupTimes.contains(timing)) {
                                                            controller.selectedGroupTimes.remove(timing);
                                                            setState(() => controller.test["$dateFormatted-group"].remove(timing));
                                                          } else {
                                                            controller.selectedGroupTimes.add(timing);
                                                            // setState(() => addToSchedule(controller.test, dateFormatted, "group", [timing]));
                                                            if(controller.formattedMorningTimingsIndividual.contains(timing)) {
                                                              Get.defaultDialog(
                                                                  contentPadding: const EdgeInsets.all(8.0),
                                                                  title: widget.langType == "English" ? "Already Updated": "पहले से ही जोड़ा",
                                                                  content: Text(
                                                                    widget.langType == "English" ?
                                                                    "$timing is already updated in the individual session, please select another one":
                                                                    "$timing पहले से ही व्यक्तिगत सत्र में अपडेट किया गया है, कृपया किसी अन्य को चुनें",
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
                                                                        child: Text(widget.langType == "English"? "OK": "ठीक",
                                                                          style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ]
                                                              );
                                                            } else {
                                                              // setState(() => controller.test["$dateFormatted-group"].add(timing));
                                                              // setState(() => addToSchedule(controller.test, dateFormatted, "group", [timing]));
                                                              // addNewSlot(
                                                              //   sessionType: "group",
                                                              //   date: dateFormatted,
                                                              //   timing: timing,
                                                              //   height: height,
                                                              // );
                                                              createKey(date: dateFormatted, sessionType: "group");
                                                              createKey(date: dateFormatted, sessionType: "one_to_one");

                                                              String key1 = '$dateFormatted-group';
                                                              String key2 = '$dateFormatted-one_to_one';
                                                              for(String key in controller.test.keys) {
                                                                if(key == key1) {
                                                                  log("key matched $key1");
                                                                  List<dynamic> existingTimes = controller.test[key];
                                                                  bool existsInOtherSessionType = false;
                                                                  for (String otherTime in controller.test[key2]) {
                                                                    if (otherTime == timing) {
                                                                      existsInOtherSessionType = true;
                                                                      AppConstants.defaultAlertDialog(
                                                                          title: widget.langType == "English" ? "Already Selected": "पहले से ही जोड़ा",
                                                                          body: widget.langType == "English" ?
                                                                          "$timing is already selected in the individual session, please select another one":
                                                                          "$timing समूह सत्र में पहले से ही अपडेट है, कृपया किसी अन्य को चुनें",
                                                                          height: height,
                                                                          buttonText: widget.langType == "English"? "OK": "ठीक"
                                                                      );
                                                                      break;
                                                                    }
                                                                  }
                                                                  if (!existsInOtherSessionType) {
                                                                    existingTimes.add(timing);
                                                                    controller.test[key1] = existingTimes;
                                                                  }
                                                                }
                                                              }

                                                            }

                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: ColorResources.GREY.withOpacity(0.5)),
                                                          color: controller.formattedMorningTimingsGroup.contains(timing) ? ColorResources.GREEN:
                                                          controller.test["${DateFormat('y-MM-d').format(_selectedDate.value)}-group"].contains(timing) ? ColorResources.ORANGE: null,
                                                          // controller.selectedGroupTimes.contains(timing) ? ColorResources.ORANGE: null,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            timing,
                                                            // style: TextStyle(
                                                            //   color: controller.test["${DateFormat('y-MM-d').format(_selectedDate.value)}-group"].contains(timing) ? ColorResources.WHITE: null,
                                                            // ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    )):
                                                    InkWell(
                                                      onTap: () {
                                                        Get.defaultDialog(
                                                            contentPadding: const EdgeInsets.all(8.0),
                                                            title: widget.langType == "English" ? "Selected time has passed": "चयनित समय बीत चुका है",
                                                            content: Text(
                                                              widget.langType == "English" ?
                                                              "the selected $timing has passed please select another time":
                                                              "चयनित $timing बीत चुका है कृपया कोई अन्य समय चुनें",
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
                                                                  child: Text(widget.langType == "English"? "OK": "ठीक",
                                                                    style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: ColorResources.GREY.withOpacity(0.5)),
                                                          color: ColorResources.GREY.withOpacity(0.6),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            timing,
                                                            style: const TextStyle(
                                                              color: ColorResources.WHITE,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Expanded(
                                              child: GridView.count(
                                                shrinkWrap: true,
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 5.0,
                                                childAspectRatio: 3.5,
                                                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
                                                crossAxisSpacing: 5.0,
                                                physics: const NeverScrollableScrollPhysics(),
                                                children: [
                                                  for (final timing in formattedMorningTimings) ...[
                                                    !isTimePassed(timing) ?
                                                    Obx(() => InkWell(
                                                      onTap: () {
                                                        String dateFormatted = DateFormat('y-MM-d').format(_selectedDate.value);
                                                        if(controller.formattedMorningTimingsIndividual.contains(timing)) {
                                                          print("already set");
                                                        } else {
                                                          if(controller.selectedIndividualTimes.contains(timing)) {
                                                            controller.selectedIndividualTimes.remove(timing);
                                                            setState(() => controller.test["$dateFormatted-one_to_one"].remove(timing));
                                                          } else {
                                                            controller.selectedIndividualTimes.add(timing);
                                                            // setState(() => addToSchedule(controller.test, dateFormatted, "one_to_one", [timing]));
                                                            if(controller.formattedMorningTimingsGroup.contains(timing)) {
                                                              Get.defaultDialog(
                                                                  contentPadding: const EdgeInsets.all(8.0),
                                                                  title: widget.langType == "English" ? "Already Updated": "पहले से ही जोड़ा",
                                                                  content: Text(
                                                                    widget.langType == "English" ?
                                                                    "$timing is already updated in the group session, please select another one":
                                                                    "$timing समूह सत्र में पहले से ही अपडेट है, कृपया किसी अन्य को चुनें",
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
                                                                        child: Text(widget.langType == "English"? "OK": "ठीक",
                                                                          style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ]
                                                              );
                                                            } else {
                                                              createKey(date: dateFormatted, sessionType: "group");
                                                              createKey(date: dateFormatted, sessionType: "one_to_one");
                                                              String key1 = '$dateFormatted-one_to_one';
                                                              String key2 = '$dateFormatted-group';
                                                              for(String key in controller.test.keys) {
                                                                if(key == key1) {
                                                                  log("key matched $key1");
                                                                  List<dynamic> existingTimes = controller.test[key];
                                                                  bool existsInOtherSessionType = false;
                                                                  for (String otherTime in controller.test[key2]) {
                                                                    if (otherTime == timing) {
                                                                      existsInOtherSessionType = true;
                                                                      AppConstants.defaultAlertDialog(
                                                                        title: widget.langType == "English" ? "Already Selected": "पहले से ही जोड़ा",
                                                                        body: widget.langType == "English" ?
                                                                        "$timing is already selected in the group session, please select another one":
                                                                        "$timing समूह सत्र में पहले से ही अपडेट है, कृपया किसी अन्य को चुनें",
                                                                        height: height,
                                                                        buttonText: widget.langType == "English"? "OK": "ठीक",
                                                                      );
                                                                      break;
                                                                    }
                                                                  }
                                                                  if (!existsInOtherSessionType) {
                                                                    existingTimes.add(timing);
                                                                    controller.test[key1] = existingTimes;
                                                                  }
                                                                }
                                                              }
                                                            }

                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: ColorResources.GREY.withOpacity(0.5)),
                                                          color: controller.formattedMorningTimingsIndividual.contains(timing) ? ColorResources.GREEN :
                                                          controller.test["${DateFormat('y-MM-d').format(_selectedDate.value)}-one_to_one"].contains(timing) ? ColorResources.ORANGE: null,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            timing,
                                                            // style: TextStyle(
                                                            //   color: controller.test["${DateFormat('y-MM-d').format(_selectedDate.value)}-one_to_one"].contains(timing) ? ColorResources.WHITE: null,
                                                            // ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    )): InkWell(
                                                      onTap: () {
                                                        Get.defaultDialog(
                                                            contentPadding: const EdgeInsets.all(8.0),
                                                            title: widget.langType == "English" ? "Selected time has passed": "चयनित समय बीत चुका है",
                                                            content: Text(
                                                              widget.langType == "English" ?
                                                              "the selected $timing has passed please select another time":
                                                              "चयनित $timing बीत चुका है कृपया कोई अन्य समय चुनें",
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
                                                                  child: Text(widget.langType == "English"? "OK": "ठीक",
                                                                    style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: ColorResources.GREY.withOpacity(0.5)),
                                                          color: ColorResources.GREY.withOpacity(0.6),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            timing,
                                                            style: const TextStyle(
                                                              color: ColorResources.WHITE,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            );
                                          }
                                        }),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              const Image(image: AssetImage("assets/image/afternoon.png"), height: 30,),
                                              Text(
                                                widget.langType == "English" ? "Afternoon": "दोपहर",
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Obx(() {
                                          if(controller.sessionType.value == "Group"){
                                            return Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 15.0),
                                                child: GridView.count(
                                                  shrinkWrap: true,
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 5.0,
                                                  childAspectRatio: 3.5,
                                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                                                  crossAxisSpacing: 5.0,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  children: [
                                                    for (final timing in formattedAfternoonTimings) ...[
                                                      !isTimePassed(timing) ?
                                                      Obx(() => InkWell(
                                                        onTap: () {
                                                          String dateFormatted = DateFormat('y-MM-d').format(_selectedDate.value);

                                                          if(controller.formattedAfternoonTimingsGroup.contains(timing)) {
                                                           print("already set");
                                                          } else {
                                                            if(controller.selectedGroupTimes.contains(timing)) {
                                                              controller.selectedGroupTimes.remove(timing);
                                                              setState(() => controller.test["$dateFormatted-group"].remove(timing));
                                                            } else {
                                                              controller.selectedGroupTimes.add(timing);
                                                              // setState(() => addToSchedule(controller.test, dateFormatted, "group", [timing]));
                                                              if(controller.formattedAfternoonTimingsIndividual.contains(timing)) {
                                                                Get.defaultDialog(
                                                                    contentPadding: const EdgeInsets.all(8.0),
                                                                    title: widget.langType == "English" ? "Already Updated": "पहले से ही जोड़ा",
                                                                    content: Text(
                                                                      widget.langType == "English" ?
                                                                      "$timing is already updated in the individual session, please select another one":
                                                                      "$timing पहले से ही व्यक्तिगत सत्र में अपडेट किया गया है, कृपया किसी अन्य को चुनें",
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
                                                                          child: Text(widget.langType == "English"? "OK": "ठीक",
                                                                            style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ]
                                                                );
                                                              } else {
                                                                // setState(() => addToSchedule(controller.test, dateFormatted, "group", [timing]));
                                                                // addNewSlot(
                                                                //   sessionType: "group",
                                                                //   date: dateFormatted,
                                                                //   timing: timing,
                                                                //   height: height,
                                                                // );
                                                                createKey(date: dateFormatted, sessionType: "group");
                                                                createKey(date: dateFormatted, sessionType: "one_to_one");

                                                                String key1 = '$dateFormatted-group';
                                                                String key2 = '$dateFormatted-one_to_one';
                                                                for(String key in controller.test.keys) {
                                                                  if(key == key1) {
                                                                    log("key matched $key1");
                                                                    List<dynamic> existingTimes = controller.test[key];
                                                                    bool existsInOtherSessionType = false;
                                                                    for (String otherTime in controller.test[key2]) {
                                                                      if (otherTime == timing) {
                                                                        existsInOtherSessionType = true;
                                                                        AppConstants.defaultAlertDialog(
                                                                            title: widget.langType == "English" ? "Already Selected": "पहले से ही जोड़ा",
                                                                            body: widget.langType == "English" ?
                                                                            "$timing is already selected in the individual session, please select another one":
                                                                            "$timing समूह सत्र में पहले से ही अपडेट है, कृपया किसी अन्य को चुनें",
                                                                            height: height,
                                                                            buttonText: widget.langType == "English"? "OK": "ठीक"
                                                                        );
                                                                        break;
                                                                      }
                                                                    }
                                                                    if (!existsInOtherSessionType) {
                                                                      existingTimes.add(timing);
                                                                      controller.test[key1] = existingTimes;
                                                                    }
                                                                  }
                                                                }
                                                              }

                                                            }
                                                          }
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: ColorResources.GREY.withOpacity(0.5)),
                                                            color: controller.formattedAfternoonTimingsGroup.contains(timing) ? ColorResources.GREEN:
                                                            controller.test["${DateFormat('y-MM-d').format(_selectedDate.value)}-group"].contains(timing) ? ColorResources.ORANGE: null,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              timing,
                                                              // style: TextStyle(
                                                              //   color: controller.test["${DateFormat('y-MM-d').format(_selectedDate.value)}-group"].contains(timing) ? ColorResources.WHITE: null,
                                                              // ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ),
                                                      )):
                                                      InkWell(
                                                        onTap: () {
                                                          Get.defaultDialog(
                                                              contentPadding: const EdgeInsets.all(8.0),
                                                              title: widget.langType == "English" ? "Selected time has passed": "चयनित समय बीत चुका है",
                                                              content: Text(
                                                                widget.langType == "English" ?
                                                                "the selected $timing has passed please select another time":
                                                                "चयनित $timing बीत चुका है कृपया कोई अन्य समय चुनें",
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
                                                                    child: Text(widget.langType == "English"? "OK": "ठीक",
                                                                      style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]
                                                          );
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: ColorResources.GREY.withOpacity(0.5)),
                                                            color: ColorResources.GREY.withOpacity(0.6),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              timing,
                                                              style: const TextStyle(
                                                                color: ColorResources.WHITE,
                                                              ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 15.0),
                                                child: GridView.count(
                                                  shrinkWrap: true,
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 5.0,
                                                  childAspectRatio: 3.5,
                                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                                                  crossAxisSpacing: 5.0,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  children: [
                                                    for (final timing in formattedAfternoonTimings) ...[
                                                      !isTimePassed(timing) ?
                                                      Obx(() => InkWell(
                                                        onTap: () {
                                                          String dateFormatted = DateFormat('y-MM-d').format(_selectedDate.value);

                                                          if(controller.formattedAfternoonTimingsIndividual.contains(timing)) {
                                                            print("already set");
                                                          } else {
                                                            if(controller.selectedIndividualTimes.contains(timing)) {
                                                              controller.selectedIndividualTimes.remove(timing);
                                                              setState(() => controller.test["$dateFormatted-one_to_one"].remove(timing));
                                                            } else {
                                                              controller.selectedIndividualTimes.add(timing);
                                                              // setState(() => addToSchedule(controller.test, dateFormatted, "one_to_one", [timing]));
                                                              if(controller.formattedAfternoonTimingsGroup.contains(timing)) {
                                                                Get.defaultDialog(
                                                                    contentPadding: const EdgeInsets.all(8.0),
                                                                    title: widget.langType == "English" ? "Already Updated": "पहले से ही जोड़ा",
                                                                    content: Text(
                                                                      widget.langType == "English" ?
                                                                      "$timing is already updated in the group session, please select another one":
                                                                      "$timing समूह सत्र में पहले से ही अपडेट है, कृपया किसी अन्य को चुनें",
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
                                                                          child: Text(widget.langType == "English"? "OK": "ठीक",
                                                                            style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ]
                                                                );
                                                              } else {
                                                                // setState(() => addToSchedule(controller.test, dateFormatted, "one_to_one", [timing]));
                                                                // addNewSlot(
                                                                //   sessionType: "one_to_one",
                                                                //   date: dateFormatted,
                                                                //   timing: timing,
                                                                //   height: height,
                                                                // );
                                                                createKey(date: dateFormatted, sessionType: "group");
                                                                createKey(date: dateFormatted, sessionType: "one_to_one");

                                                                String key1 = '$dateFormatted-one_to_one';
                                                                String key2 = '$dateFormatted-group';
                                                                for(String key in controller.test.keys) {
                                                                  if(key == key1) {
                                                                    log("key matched $key1");
                                                                    List<dynamic> existingTimes = controller.test[key];
                                                                    bool existsInOtherSessionType = false;
                                                                    for (String otherTime in controller.test[key2]) {
                                                                      if (otherTime == timing) {
                                                                        existsInOtherSessionType = true;
                                                                        AppConstants.defaultAlertDialog(
                                                                          title: widget.langType == "English" ? "Already Selected": "पहले से ही जोड़ा",
                                                                          body: widget.langType == "English" ?
                                                                          "$timing is already selected in the group session, please select another one":
                                                                          "$timing समूह सत्र में पहले से ही अपडेट है, कृपया किसी अन्य को चुनें",
                                                                          height: height,
                                                                          buttonText: widget.langType == "English"? "OK": "ठीक",
                                                                        );
                                                                        break;
                                                                      }
                                                                    }
                                                                    if (!existsInOtherSessionType) {
                                                                      existingTimes.add(timing);
                                                                      controller.test[key1] = existingTimes;
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          }
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: ColorResources.GREY.withOpacity(0.5)),
                                                            color: controller.formattedAfternoonTimingsIndividual.contains(timing) ? ColorResources.GREEN:
                                                            controller.test["${DateFormat('y-MM-d').format(_selectedDate.value)}-one_to_one"].contains(timing) ? ColorResources.ORANGE: null,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              timing,
                                                              // style: TextStyle(
                                                              //   color: controller.test["${DateFormat('y-MM-d').format(_selectedDate.value)}-one_to_one"].contains(timing) ? ColorResources.WHITE: null,
                                                              // ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ),
                                                      )):
                                                      InkWell(
                                                        onTap: () {
                                                          Get.defaultDialog(
                                                              contentPadding: const EdgeInsets.all(8.0),
                                                              title: widget.langType == "English" ? "Selected time has passed": "चयनित समय बीत चुका है",
                                                              content: Text(
                                                                widget.langType == "English" ?
                                                                "the selected $timing has passed please select another time":
                                                                "चयनित $timing बीत चुका है कृपया कोई अन्य समय चुनें",
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
                                                                    child: Text(widget.langType == "English"? "OK": "ठीक",
                                                                      style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]
                                                          );
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: ColorResources.GREY.withOpacity(0.5)),
                                                            color: ColorResources.GREY.withOpacity(0.6),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              timing,
                                                              style: const TextStyle(
                                                                color: ColorResources.WHITE,
                                                              ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        }),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              const Image(image: AssetImage("assets/image/evening.png"), height: 30,),
                                              Text(
                                                widget.langType == "English" ? "Evening": "शाम",
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Obx(() {
                                          if(controller.sessionType.value == "Group"){
                                            return Expanded(
                                              child: GridView.count(
                                                shrinkWrap: true,
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 5.0,
                                                childAspectRatio: 3.5,
                                                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
                                                crossAxisSpacing: 5.0,
                                                physics: const NeverScrollableScrollPhysics(),
                                                children: [
                                                  for (final timing in formattedEveningTimings) ...[
                                                    !isTimePassed(timing) ?
                                                    Obx(() => InkWell(
                                                      onTap: () {
                                                        String dateFormatted = DateFormat('y-MM-d').format(_selectedDate.value);

                                                        if(controller.formattedEveningTimingsGroup.contains(timing)) {
                                                          print("already set");
                                                        } else {
                                                          if(controller.selectedGroupTimes.contains(timing)) {
                                                            controller.selectedGroupTimes.remove(timing);
                                                            setState(() => controller.test["$dateFormatted-group"].remove(timing));
                                                          } else {
                                                            controller.selectedGroupTimes.add(timing);
                                                            // setState(() => addToSchedule(controller.test, dateFormatted, "group", [timing]));
                                                            if(controller.formattedEveningTimingsIndividual.contains(timing)) {
                                                              Get.defaultDialog(
                                                                contentPadding: const EdgeInsets.all(8.0),
                                                                title: widget.langType == "English" ? "Already Updated": "पहले से ही जोड़ा",
                                                                content: Text(
                                                                  widget.langType == "English" ?
                                                                  "$timing is already updated in the individual session, please select another one":
                                                                  "$timing पहले से ही व्यक्तिगत सत्र में अपडेट किया गया है, कृपया किसी अन्य को चुनें",
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
                                                                      child: Text(widget.langType == "English"? "OK": "ठीक",
                                                                        style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ]
                                                              );
                                                            } else {

                                                              // setState(() => addToSchedule(controller.test, dateFormatted, "group", [timing]));
                                                              // addNewSlot(
                                                              //   sessionType: "group",
                                                              //   date: dateFormatted,
                                                              //   timing: timing,
                                                              //   height: height,
                                                              // );
                                                              createKey(date: dateFormatted, sessionType: "group");
                                                              createKey(date: dateFormatted, sessionType: "one_to_one");

                                                              String key1 = '$dateFormatted-group';
                                                              String key2 = '$dateFormatted-one_to_one';
                                                              for(String key in controller.test.keys) {
                                                                if(key == key1) {
                                                                  log("key matched $key1");
                                                                  List<dynamic> existingTimes = controller.test[key];
                                                                  bool existsInOtherSessionType = false;
                                                                  for (String otherTime in controller.test[key2]) {
                                                                    if (otherTime == timing) {
                                                                      existsInOtherSessionType = true;
                                                                      AppConstants.defaultAlertDialog(
                                                                          title: widget.langType == "English" ? "Already Selected": "पहले से ही जोड़ा",
                                                                          body: widget.langType == "English" ?
                                                                          "$timing is already selected in the individual session, please select another one":
                                                                          "$timing समूह सत्र में पहले से ही अपडेट है, कृपया किसी अन्य को चुनें",
                                                                          height: height,
                                                                          buttonText: widget.langType == "English"? "OK": "ठीक"
                                                                      );
                                                                      break;
                                                                    }
                                                                  }
                                                                  if (!existsInOtherSessionType) {
                                                                    existingTimes.add(timing);
                                                                    controller.test[key1] = existingTimes;
                                                                  }
                                                                }
                                                              }
                                                            }

                                                          }
                                                        }
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: ColorResources.GREY.withOpacity(0.5)),
                                                          color: controller.formattedEveningTimingsGroup.contains(timing) ? ColorResources.GREEN:
                                                          controller.test["${DateFormat('y-MM-d').format(_selectedDate.value)}-group"].contains(timing) ? ColorResources.ORANGE: null,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            timing,
                                                            // style: TextStyle(
                                                              // color: controller.test["${DateFormat('y-MM-d').format(_selectedDate.value)}-group"].contains(timing) ? ColorResources.WHITE: null,
                                                            // ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    )):
                                                    InkWell(
                                                      onTap: () {
                                                        Get.defaultDialog(
                                                            contentPadding: const EdgeInsets.all(8.0),
                                                            title: widget.langType == "English" ? "Selected time has passed": "चयनित समय बीत चुका है",
                                                            content: Text(
                                                              widget.langType == "English" ?
                                                              "the selected $timing has passed please select another time":
                                                              "चयनित $timing बीत चुका है कृपया कोई अन्य समय चुनें",
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
                                                                  child: Text(widget.langType == "English"? "OK": "ठीक",
                                                                    style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: ColorResources.GREY.withOpacity(0.5)),
                                                          color: ColorResources.GREY.withOpacity(0.6),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            timing,
                                                            style: const TextStyle(
                                                              color: ColorResources.WHITE,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 4.0),
                                                child: GridView.count(
                                                  shrinkWrap: true,
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 5.0,
                                                  childAspectRatio: 3.5,
                                                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
                                                  crossAxisSpacing: 5.0,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  children: [
                                                    for (final timing in formattedEveningTimings) ...[
                                                      !isTimePassed(timing) ?
                                                      Obx(() => InkWell(
                                                        onTap: () {
                                                          String dateFormatted = DateFormat('y-MM-d').format(_selectedDate.value);

                                                          if(controller.formattedEveningTimingsIndividual.contains(timing)) {
                                                            print("already set");
                                                          } else {
                                                            if(controller.selectedIndividualTimes.contains(timing)) {
                                                              controller.selectedIndividualTimes.remove(timing);
                                                              setState(() => controller.test["$dateFormatted-one_to_one"].remove(timing));
                                                            } else {
                                                              controller.selectedIndividualTimes.add(timing);
                                                              if(controller.formattedEveningTimingsGroup.contains(timing)) {
                                                                AppConstants.defaultAlertDialog(
                                                                    title: widget.langType == "English" ? "Already Updated": "पहले से ही जोड़ा",
                                                                    body: widget.langType == "English" ?
                                                                    "$timing is already updated in the group session, please select another one":
                                                                    "$timing समूह सत्र में पहले से ही अपडेट है, कृपया किसी अन्य को चुनें",
                                                                    height: height,
                                                                    buttonText: widget.langType == "English"? "OK": "ठीक"
                                                                );
                                                              } else {
                                                                // addTiming(
                                                                //   sessionType: "one_to_one",
                                                                //   date: dateFormatted,
                                                                //   height: height,
                                                                //   timing: timing,
                                                                // );
                                                                createKey(date: dateFormatted, sessionType: "group");
                                                                createKey(date: dateFormatted, sessionType: "one_to_one");

                                                                String key1 = '$dateFormatted-one_to_one';
                                                                String key2 = '$dateFormatted-group';
                                                                for(String key in controller.test.keys) {
                                                                  if(key == key1) {
                                                                    log("key matched $key1");
                                                                    List<dynamic> existingTimes = controller.test[key];
                                                                    bool existsInOtherSessionType = false;
                                                                    for (String otherTime in controller.test[key2]) {
                                                                      if (otherTime == timing) {
                                                                        existsInOtherSessionType = true;
                                                                        AppConstants.defaultAlertDialog(
                                                                            title: widget.langType == "English" ? "Already Selected": "पहले से ही जोड़ा",
                                                                            body: widget.langType == "English" ?
                                                                            "$timing is already selected in the group session, please select another one":
                                                                            "$timing समूह सत्र में पहले से ही अपडेट है, कृपया किसी अन्य को चुनें",
                                                                            height: height,
                                                                            buttonText: widget.langType == "English"? "OK": "ठीक"
                                                                        );
                                                                        break;
                                                                      }
                                                                    }
                                                                    if (!existsInOtherSessionType) {
                                                                      existingTimes.add(timing);
                                                                      controller.test[key1] = existingTimes;
                                                                    }
                                                                  }
                                                                }
                                                                // setState(() => addToSchedule(controller.test, dateFormatted, "one_to_one", [timing]));
                                                                // log("after ${controller.test}");
                                                                // addNewSlot(
                                                                //   sessionType: "one_to_one",
                                                                //   date: dateFormatted,
                                                                //   timing: timing,
                                                                //   height: height,
                                                                // );
                                                              }

                                                            }
                                                          }
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: ColorResources.GREY.withOpacity(0.5)),
                                                            color: controller.formattedEveningTimingsIndividual.contains(timing) ? ColorResources.GREEN:
                                                            controller.test["${DateFormat('y-MM-d').format(_selectedDate.value)}-one_to_one"].contains(timing) ? ColorResources.ORANGE: null,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              timing,
                                                              // style: TextStyle(
                                                              //   color: controller.test["${DateFormat('y-MM-d').format(_selectedDate.value)}-one_to_one"].contains(timing) ? ColorResources.WHITE: null,
                                                              // ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ),
                                                      )):
                                                      InkWell(
                                                        onTap: () {
                                                          Get.defaultDialog(
                                                              contentPadding: const EdgeInsets.all(8.0),
                                                              title: widget.langType == "English" ? "Selected time has passed": "चयनित समय बीत चुका है",
                                                              content: Text(
                                                                widget.langType == "English" ?
                                                                "the selected $timing has passed please select another time":
                                                                "चयनित $timing बीत चुका है कृपया कोई अन्य समय चुनें",
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
                                                                    child: Text(widget.langType == "English"? "OK": "ठीक",
                                                                      style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]
                                                          );
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: ColorResources.GREY.withOpacity(0.5)),
                                                            color: ColorResources.GREY.withOpacity(0.6),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              timing,
                                                              style: const TextStyle(
                                                                color: ColorResources.WHITE,
                                                              ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        }),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if(controller.test.isEmpty) {
                                  EasyLoading.dismiss();
                                  widget.langType == "English" ?
                                  AppConstants.show_toast("Nothing new to be updated\nPlease select at least one time slot"):
                                  AppConstants.show_toast("अपडेट करने के लिए कुछ नया नहीं है\nकृपया कम से कम एक समय स्लॉट चुनें");
                                } else {
                                  EasyLoading.show();
                                  bool isSuccess = false;

                                  // controller.test.forEach((key, value) async {
                                  //   List<String> keyParts = key.split('-');
                                  //   String date = '${keyParts[0]}-${keyParts[1]}-${keyParts[2]}';
                                  //   String sessionType = keyParts[3];
                                  //   List<dynamic> times = value;
                                  //
                                  //   for(String time in times) {
                                  //     await HttpService.editTimeAvailabilityApi(
                                  //       userId: widget.userDetails.first.id,
                                  //       time: time,
                                  //       date: date,
                                  //       sessionType: sessionType,
                                  //     );
                                  //     isSuccess = true;
                                  //   }
                                  // });
                                  await Future.wait(controller.test.entries.map((entry) async {
                                    String key = entry.key;
                                    List<String> keyParts = key.split('-');
                                    String date = '${keyParts[0]}-${keyParts[1]}-${keyParts[2]}';
                                    String sessionType = keyParts[3];
                                    List<dynamic> times = entry.value;

                                    for (String time in times) {
                                      await HttpService.editTimeAvailabilityApi(
                                        userId: userController.userDetails.first.id,
                                        time: time,
                                        date: date,
                                        sessionType: sessionType,
                                      );
                                      isSuccess = true;
                                    }
                                  }));

                                  EasyLoading.dismiss();
                                  if(isSuccess)  {
                                    if(mounted) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            shape:
                                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            child: Stack(clipBehavior: Clip.none, children: [
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width,
                                                height: MediaQuery.of(context).size.height * 0.60,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Flexible(child: Image.asset("assets/image/success.png")),
                                                      const Text("Success", textAlign: TextAlign.center, style: poppinsBold),
                                                      const SizedBox(height: 10),
                                                      const Text("Time slots updated successfully!", textAlign: TextAlign.center, style: poppinsBold),
                                                      const SizedBox(height: 20),
                                                      Row(children: [
                                                        Expanded(child: InkWell(
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                            EasyLoading.show();
                                                            List<Data> userDetails = List.empty(growable: true);
                                                            HttpService.get_uesr_detali_api().then((value) {
                                                              if (mounted) {
                                                                setState(() {
                                                                  if (value['success'] == true || value['success'] == "true") {
                                                                    var values = GetUesrDetaliModel.fromJson(value).data;
                                                                    userController.userDetails.clear();
                                                                    userDetails.add(values);
                                                                    userController.userDetails = userDetails;
                                                                    Future.delayed(const Duration(seconds: 2), () {
                                                                      clearData();
                                                                      getTimingsByDate();
                                                                      EasyLoading.dismiss();
                                                                    });
                                                                  }
                                                                });
                                                              }
                                                            });
                                                          },
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
                                  } else {
                                    AppConstants.showDialogueBox(
                                      context: context,
                                      title: "Failed",
                                      body: "Failed to update some time slots",
                                      isSuccess: isSuccess,
                                    );
                                  }

                                }
                              },
                              // onTap: () async {
                              //   bool proceed = true;
                              //   final formattedDate = DateFormat('yyyy-M-d').format(_selectedDate.value);
                              //   EasyLoading.show();
                              //
                              //   if(controller.selectedGroupTimes.isEmpty && controller.selectedIndividualTimes.isEmpty) {
                              //     EasyLoading.dismiss();
                              //     widget.langType == "English" ?
                              //     AppConstants.show_toast("Nothing new to be updated\nPlease select at least one time slot"):
                              //     AppConstants.show_toast("अपडेट करने के लिए कुछ नया नहीं है\nकृपया कम से कम एक समय स्लॉट चुनें");
                              //   } else {
                              //
                              //     if(controller.selectedIndividualTimes.isNotEmpty) {
                              //       String sessionType = "one_to_one";
                              //
                              //       for(var item in controller.selectedIndividualTimes) {
                              //         await HttpService.editTimeAvailabilityApi(
                              //           userId: widget.userDetails.first.id,
                              //           time: item,
                              //           date: formattedDate,
                              //           sessionType: sessionType,
                              //         );
                              //       }
                              //       print("\n\nselected Individual times ${controller.selectedIndividualTimes}\n\n");
                              //       proceed = true;
                              //     }
                              //
                              //     if(controller.selectedGroupTimes.isNotEmpty) {
                              //       String sessionType = "group";
                              //
                              //       for(var item in controller.selectedGroupTimes) {
                              //         await HttpService.editTimeAvailabilityApi(
                              //           userId: widget.userDetails.first.id,
                              //           time: item,
                              //           date: formattedDate,
                              //           sessionType: sessionType,
                              //         );
                              //       }
                              //       print("\n\nselected Group times ${controller.selectedGroupTimes}\n\n");
                              //       proceed = true;
                              //     }
                              //
                              //     if(proceed) {
                              //       EasyLoading.dismiss();
                              //       if(mounted) {
                              //         showDialog(
                              //           context: context,
                              //           builder: (context) {
                              //             return Dialog(
                              //               shape:
                              //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              //               child: Stack(clipBehavior: Clip.none, children: [
                              //                 SizedBox(
                              //                   width: MediaQuery.of(context).size.width,
                              //                   height: MediaQuery.of(context).size.height * 0.60,
                              //                   child: Padding(
                              //                     padding: const EdgeInsets.symmetric(horizontal: 20),
                              //                     child: Column(
                              //                       mainAxisAlignment: MainAxisAlignment.center,
                              //                       crossAxisAlignment: CrossAxisAlignment.center,
                              //                       children: [
                              //                         Flexible(child: Image.asset("assets/image/success.png")),
                              //                         const Text("Success", textAlign: TextAlign.center, style: poppinsBold),
                              //                         const SizedBox(height: 10),
                              //                         const Text("Time slots updated successfully!", textAlign: TextAlign.center, style: poppinsBold),
                              //                         const SizedBox(height: 20),
                              //                         Row(children: [
                              //                           Expanded(child: InkWell(
                              //                             onTap: () {
                              //                               Navigator.pop(context);
                              //                               EasyLoading.show();
                              //                               List<Data> userDetails = List.empty(growable: true);
                              //                               HttpService.get_uesr_detali_api().then((value) {
                              //                                 if (mounted) {
                              //                                   setState(() {
                              //                                     if (value['success'] == true || value['success'] == "true") {
                              //                                       var values = GetUesrDetaliModel.fromJson(value).data;
                              //                                       userDetails.add(values);
                              //                                       widget.userDetails = userDetails;
                              //                                       Future.delayed(const Duration(seconds: 2), () {
                              //                                         clearData();
                              //                                         getTimingsByDate();
                              //                                         EasyLoading.dismiss();
                              //                                       });
                              //                                     }
                              //                                   });
                              //                                 }
                              //                               });
                              //                             },
                              //                             child: Container(
                              //                               padding: const EdgeInsets.all(15),
                              //                               alignment: Alignment.center,
                              //                               margin: const EdgeInsets.symmetric(horizontal: 15),
                              //                               decoration: BoxDecoration(
                              //                                 color: ColorResources.ORANGE,
                              //                                 borderRadius: BorderRadius.circular(10),
                              //                               ),
                              //                               child: Text('OK', style: poppinsBold.copyWith(color: ColorResources.WHITE,fontWeight: FontWeight.w500)),
                              //                             ),
                              //                           )),
                              //                           const SizedBox(height: 30),
                              //                         ]),
                              //                         const SizedBox(height: 30),
                              //                       ],
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ]),
                              //             );
                              //           },
                              //         );
                              //       }
                              //       clearData();
                              //       // showDialog(
                              //       //   context: context,
                              //       //   builder: (context) {
                              //       //     return Dialog(
                              //       //       shape:
                              //       //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              //       //       child: Stack(clipBehavior: Clip.none, children: [
                              //       //         SizedBox(
                              //       //           width: MediaQuery.of(context).size.width,
                              //       //           height: MediaQuery.of(context).size.height * 0.60,
                              //       //           child: Padding(
                              //       //             padding: const EdgeInsets.symmetric(horizontal: 20),
                              //       //             child: Column(
                              //       //               mainAxisAlignment: MainAxisAlignment.center,
                              //       //               crossAxisAlignment: CrossAxisAlignment.center,
                              //       //               children: [
                              //       //                 Flexible(child: Image.asset("assets/image/success.png")),
                              //       //                 Text("Success", textAlign: TextAlign.center, style: poppinsBold),
                              //       //                 const SizedBox(height: 10),
                              //       //                 Text("Time slots updated successfully!", textAlign: TextAlign.center, style: poppinsBold),
                              //       //                 const SizedBox(height: 20),
                              //       //                 Row(children: [
                              //       //                   Expanded(child: InkWell(
                              //       //                     onTap: ()  => Navigator.pushAndRemoveUntil(
                              //       //                         context,
                              //       //                         MaterialPageRoute(builder: (context)=> TimeSlotSettings(
                              //       //                           langType: widget.langType,
                              //       //                           userDetails: widget.userDetails,
                              //       //                         )), (route) => false),
                              //       //                     child: Container(
                              //       //                       padding: const EdgeInsets.all(15),
                              //       //                       alignment: Alignment.center,
                              //       //                       margin: const EdgeInsets.symmetric(horizontal: 15),
                              //       //                       decoration: BoxDecoration(
                              //       //                         color: ColorResources.ORANGE,
                              //       //                         borderRadius: BorderRadius.circular(10),
                              //       //                       ),
                              //       //                       child: Text('OK', style: poppinsBold.copyWith(color: ColorResources.WHITE,fontWeight: FontWeight.w500)),
                              //       //                     ),
                              //       //                   )),
                              //       //                   const SizedBox(height: 30),
                              //       //                 ]),
                              //       //                 const SizedBox(height: 30),
                              //       //               ],
                              //       //             ),
                              //       //           ),
                              //       //         ),
                              //       //       ]),
                              //       //     );
                              //       //   },
                              //       // );
                              //     } else {
                              //       EasyLoading.dismiss();
                              //       if(mounted) {
                              //         AppConstants.showDialogueBox(
                              //           context: context,
                              //           title: widget.langType == "English" ?
                              //           "Failed": "असफल",
                              //           body: widget.langType == "English" ?
                              //           "Failed to update time slots!": "टाइम स्लॉट अपडेट करने में विफल!",
                              //           isSuccess: false,
                              //         );
                              //       }
                              //     }
                              //
                              //   }
                              // },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: height * 0.055,
                                  decoration: BoxDecoration(
                                    color: ColorResources.ORANGE,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child:
                                    Text(
                                      widget.langType == "English" ? "Update": "अपडेट करें",
                                      style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
                                    ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.10,),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
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
                                  title: widget.langType == "English" ? "Leave live stream": "लाइव स्ट्रीम छोड़ें",
                                  content: Text(
                                    widget.langType == "English" ?
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
                  selectedLanguage: widget.langType,
                );
              },
            ),
          ))
        ],
      ),
    );
  }

  bool isTimePassed(String timing) {
      int hours = int.parse(timing.split(' ')[0]);
      String amPm = timing.split(' ')[1];

      if (amPm == 'PM' && hours != 12) {
        hours += 12;
      } else if (amPm == 'AM' && hours == 12) {
        hours = 0;
      }

      DateTime time = DateTime(
        _selectedDate.value.year,
        _selectedDate.value.month,
        _selectedDate.value.day,
        hours,
        0,
      );

      if (DateTime.now().isAfter(time)) {
        return true;
      } else {
        return false;
      }
  }

  // bool isTimePassed(String timing) {
  //   // Check if each time has passed
  //   for (String timeString in times) {
  //     // Extract hours and AM/PM from the time string
  //     int hours = int.parse(timeString.split(' ')[0]);
  //     String amPm = timeString.split(' ')[1];
  //
  //     // Adjust the hour component
  //     if (amPm == 'PM' && hours != 12) {
  //       hours += 12;
  //     } else if (amPm == 'AM' && hours == 12) {
  //       hours = 0;
  //     }
  //
  //     // Create a DateTime object for the custom date and time
  //     DateTime time = DateTime(
  //       _selectedDate.value.year,
  //       _selectedDate.value.month,
  //       _selectedDate.value.day,
  //       hours,
  //       0,
  //     );
  //
  //     if (DateTime.now().isAfter(time)) {
  //       return true;
  //     } else {
  //       return false;
  //       // print('$timeString has not passed yet on $dateString.');
  //     }
  //   }
  //
  //   return false;
  // }

  void addToSchedule(RxMap schedule, String date, String sessionType, List<String> times) {
    String key = '$date-$sessionType';
    log(key);
    if (schedule.containsKey(key)) {
      List<String> existingTimes = schedule[key]!;
      log("check $existingTimes");
      if(times.isNotEmpty) {
        for (String time in times) {
          bool existsInOtherSessionType = false;
          for (List<String> otherTimes in schedule.values) {
            if (otherTimes != existingTimes && otherTimes.contains(time)) {
              existsInOtherSessionType = true;
              break;
            }
          }
          if (!existsInOtherSessionType) {
            existingTimes.add(time);
          }
        }
      } else {
        schedule[key] = times;
      }
    } else {
      log("key: ${schedule[key]} check time: $times");
      schedule[key] = times;
    }
  }


  List<String> formatTimings(List<DateTime> timings) {
    final List<String> formattedTimings = [];

    if (timings.isEmpty) return formattedTimings;

    DateTime previousTime = timings[0];
    formattedTimings.add(formatTime(previousTime));

    for (int i = 1; i < timings.length; i++) {
      final DateTime currentTime = timings[i];

      if (currentTime.difference(previousTime).inHours > 1) {
        formattedTimings.add('');
      }

      formattedTimings.add(formatTime(currentTime));
      previousTime = currentTime;
    }

    return formattedTimings;
  }

  String formatTime(DateTime time) {
    final String period = time.hour < 12 ? 'AM' : 'PM';
    final int hour = time.hour == 0 ? 12 : time.hour > 12 ? time.hour - 12 : time.hour;

    return '$hour $period';
  }

  void clearData() {
    controller.selectedIndividualTimes.clear();
    controller.selectedGroupTimes.clear();
    controller.formattedMorningTimingsGroup.clear();
    controller.formattedAfternoonTimingsGroup.clear();
    controller.formattedEveningTimingsGroup.clear();
    controller.formattedMorningTimingsIndividual.clear();
    controller.formattedAfternoonTimingsIndividual.clear();
    controller.formattedEveningTimingsIndividual.clear();
    // controller.test.clear();
  }

  void addNewSlot({required String timing, height, required String sessionType, required String date}) {
    for (String times in controller.test["$date-$sessionType"]) {
      log("here 1");
      if (times == timing) {
        log("here 2");
        Get.defaultDialog(
            contentPadding: const EdgeInsets.all(8.0),
            title: widget.langType == "English" ? "Already Added": "पहले से ही जोड़ा",
            content: Text(
              widget.langType == "English" ?
              sessionType == "group" ?
              "$timing already added in the individual session, please select another one":
              "$timing already added in the group session, please select another one":
              sessionType == "group" ? "$timing पहले ही अन्य सत्र में जोड़ा जा चुका है, कृपया कोई दूसरा चुनें":
              "$timing पहले से ही समूह सत्र में जोड़ा गया है, कृपया किसी अन्य को चुनें",
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
                  child: Text(widget.langType == "English"? "OK": "ठीक",
                    style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
                  ),
                ),
              ),
            ]
        );
        break;
      } else {
        log("${controller.test.values}here 3");
        setState(() => addToSchedule(controller.test, date, sessionType, [timing]));
        break;
      }
    }
    log("here 4");
  }

  void createKey({required String date, required sessionType}) {
    String key1 = "$date-$sessionType";
    bool keyExist = false;
    for(String key in controller.test.keys) {
      if(key == key1) {
        log("key found $key1");
        keyExist = true;
        break;
      } else {
        log("key not found");
        log("all keys ${controller.test.keys}");
      }
    }
    if(!keyExist){
      controller.test.addAll({
        key1: []
      });
    }
  }

  void addTiming({
    required String date,
    required String sessionType,
    required String timing,
    required double height,
  }) {
    String key1 = '$date-$sessionType';
    String key2 = sessionType == "group" ? '$date-group': '$date-one_to_one';
    for(String key in controller.test.keys) {
      if(key == key1) {
        log("key matched $key1");
        List<dynamic> existingTimes = controller.test[key];
        bool existsInOtherSessionType = false;
        for (String otherTime in controller.test[key2]) {
          if (otherTime == timing) {
            existsInOtherSessionType = true;
            AppConstants.defaultAlertDialog(
                title: widget.langType == "English" ? "Already Selected": "पहले से ही जोड़ा",
                body: widget.langType == "English" ?
                "$timing is already selected in the ${sessionType == "group" ? "group": "individual"} session, please select another one":
                "$timing समूह सत्र में पहले से ही अपडेट है, कृपया किसी अन्य को चुनें",
                height: height,
                buttonText: widget.langType == "English"? "OK": "ठीक"
            );
            break;
          }
        }
        if (!existsInOtherSessionType) {
          existingTimes.add(timing);
          controller.test[key1] = existingTimes;
        }
      }
    }
  }

  getApi() {
    EasyLoading.show();
    HttpService.get_uesr_detali_api().then((value) {
      if (mounted) {
        setState(() {
          if (value['success'] == true || value['success'] == "true") {
            var values = GetUesrDetaliModel.fromJson(value).data;
            userController.userDetails.clear();
            userController.userDetails.add(values);
            clearData();
            getTimingsByDate();
            EasyLoading.dismiss();
          } else {
            EasyLoading.dismiss();
          }
        });
      }
    });
  }

  void leave() async {
    setState(() {
      streamController.selectedVideoProvider.value = null;
      streamController.hideAppBar.value = false;
      streamController.remoteUids.clear();
      streamController.isJoined.value = false;
      streamController.isLoading.value = false;
      streamController.agoraEngine.leaveChannel();
      streamController.isInitialized.value = false;
      streamController.animationController.dispose();
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
}


class CalendarDay extends StatelessWidget {
  final DateTime date;
  final String selectedDate;
  final void Function(DateTime date) onDateSelected;

  const CalendarDay({
    super.key,
    required this.date,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    // final dayName = DateFormat('EEE').format(date);
    final dayNumber = DateFormat('d').format(date).obs;
    final dayMonth = DateFormat('MMM').format(date).obs;
    final currentDate = DateFormat('y-MM-d').format(date).obs;

    return GestureDetector(
      onTap: () => onDateSelected(date),
      child: Row(
        children: [
            Obx(() => Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: selectedDate == currentDate.value ? ColorResources.ORANGE : Colors.transparent,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   dayName,
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     color: selectedDate == currentDate ? ColorResources.WHITE : ColorResources.BLACK.withOpacity(0.4),
                  //   ),
                  // ),
                  // const SizedBox(height: 5),
                  Obx(() => Text(
                    dayNumber.value,
                    style: TextStyle(
                      fontSize: 18,
                      color: selectedDate == currentDate.value ? ColorResources.WHITE : ColorResources.BLACK,
                    ),
                  )),
                  const SizedBox(width: 5,),
                  Obx(() => Text(
                    dayMonth.value,
                    style: TextStyle(
                      fontSize: 12,
                      color: selectedDate == currentDate.value ? ColorResources.WHITE : ColorResources.BLACK.withOpacity(0.4),
                    ),
                  )),
                ],
              ),
            )),
        ],
      ),
    );
  }
}