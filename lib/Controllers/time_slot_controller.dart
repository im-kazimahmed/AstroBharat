import 'dart:io';

import 'package:get/get.dart';

import '../HttpService/HttpService.dart';
import '../HttpService/model/Consultant_Availability.dart';

class TimeSlotController extends GetxController{
  RxInt consultantId = 0.obs;
  var isLoading = false.obs;
  ConsultantAvailability? appointments;
  RxList selectedIndividualTimes = [].obs;
  RxList selectedGroupTimes = [].obs;
  final Rx<String> sessionType = "Group".obs;

  RxList formattedMorningTimingsGroup = [].obs;
  RxList formattedAfternoonTimingsGroup = [].obs;
  RxList formattedEveningTimingsGroup = [].obs;

  RxList formattedMorningTimingsIndividual = [].obs;
  RxList formattedAfternoonTimingsIndividual = [].obs;
  RxList formattedEveningTimingsIndividual = [].obs;

  RxMap test = {}.obs;
  // @override
  // Future<void> onInit() async {
  //   super.onInit();
  //   fetchData();
  // }
  fetchData() async {
    try {
      isLoading(true);
      HttpService.fetchConsultantAvailability(consultantId.value);
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  final List<String> times = [
    "1 AM",
    "2 AM",
    "3 AM",
    "4 AM",
    "5 AM",
    "6 AM",
    "7 AM",
    "8 AM",
    "9 AM",
    "10 AM",
    "11 AM",
    "12 AM",
    "1 PM",
    "2 PM",
    "3 PM",
    "4 PM",
    "5 PM",
    "6 PM",
    "7 PM",
    "8 PM",
    "9 PM",
    "10 PM",
    "11 PM",
    "12 PM",
  ];

}