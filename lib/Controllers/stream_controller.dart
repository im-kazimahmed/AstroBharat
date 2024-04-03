import 'dart:io';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniplayer/miniplayer.dart';
import '../HttpService/model/streamModel.dart';

class LiveStreamController extends GetxController{
  TextEditingController messageController = TextEditingController();
  RxString token = "".obs;
  RxString channelName = "test".obs;
  RxInt participantCount = 0.obs;
  RxInt appointmentId = 0.obs;
  RxBool isInitialized = false.obs;
  RxBool isSession = false.obs;
  RxBool isAttended = false.obs;

  RxString chatGroupName = "".obs;
  RxString chatGroupId = "".obs;

  RxBool isLoading = false.obs;
  RxBool isJoined = false.obs; // Indicates if the local user has joined the channel
  late RtcEngine agoraEngine; // Agora engine instance
  // RxInt? remoteUid;
  RxList remoteUids = [].obs;
  RxInt uid = 5.obs; // uid of the local user
  // RxInt? remoteUid.obs; // uid of the remote user

  Rx<StreamModel?> selectedVideoProvider = Rx<StreamModel?>(null);
  Rx<MiniplayerController?> miniPlayerControllerProvider = Rx<MiniplayerController?>(MiniplayerController());
  RxBool hideAppBar = false.obs;
  double playerMinHeight = 60.0;
  late AnimationController animationController;
  RxBool newUserHasJoined = false.obs;
  RxString newUserJoined = "".obs;
}