import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniplayer/miniplayer.dart';
import '../../../Chat/service/database_service.dart';
import '../../../Controllers/stream_controller.dart';
import '../../../Controllers/user_controller.dart';
import '../../../HttpService/HttpService.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/styles.dart';
import '../../stream/video_screen.dart';

class Notification_screen extends StatefulWidget {
  String langType;
  Notification_screen(this.langType);

  @override
  State<Notification_screen> createState() => _Notification_screenState();
}

class _Notification_screenState extends State<Notification_screen> {
  final LiveStreamController streamController = Get.find<LiveStreamController>();
  final UserController userController = Get.find<UserController>();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final st = MediaQuery.of(context).padding.top;
    final tbody = height - st;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading:IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_sharp,color: ColorResources.BLACK,)),
          title: widget.langType=="English"?Text('Notification',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)):Text('अधिसूचना',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)),
          backgroundColor: ColorResources.ORANGE_WHITE,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  // color: Colors.red,
                                  width: width - 44,
                                  alignment: Alignment.centerRight,
                                  // margin: EdgeInsets.only(left: 10, bottom: 10),
                                  child: Text('2022-10-17 ,16:30:55',
                                      style: poppinsMedium.copyWith(
                                          color: ColorResources.GREY,
                                          fontSize: width * 0.035)),
                                ),
                                Container(
                                  // color: Colors.red,
                                  width: width - 44,
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 10, bottom: 2,right: 10),
                                  child: Text('MIFIT CHAT',
                                      style: poppinsMedium.copyWith(
                                          color: ColorResources.BLACK,
                                          fontSize: width * 0.05)),
                                ),
                                Container(
                                  // color: Colors.red,
                                  width: width - 44,
                                  alignment: Alignment.centerLeft,
                                  // margin: EdgeInsets.only(left: 10, bottom: 10),
                                  child: Text('Good Morning today offer 50% off question  an free chat',
                                      style: poppinsMedium.copyWith(
                                          color: ColorResources.GREY,
                                          fontSize: width * 0.040)),
                                ),

                              ],
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                )
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
      ),
    );
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