import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:miniplayer/miniplayer.dart';
import '../../../Chat/service/database_service.dart';
import '../../../Controllers/stream_controller.dart';
import '../../../Controllers/user_controller.dart';
import '../../../HttpService/HttpService.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../../stream/video_screen.dart';
import '../home_screen.dart';
class Change_Language extends StatefulWidget {
  String langType;
  Change_Language(this.langType);

  @override
  State<Change_Language> createState() => _Change_LanguageState();
}

class _Change_LanguageState extends State<Change_Language> {
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
          title:widget.langType=="English"? Text('Change Language',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)):Text('भाषा बदलें',
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
                Container(
                  height: height * 0.13,
                  width: width,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(Images.Astrobharat_logo),
                          fit: BoxFit.fitWidth)),
                ),
                InkWell(
                  onTap: () {
                    EasyLoading.show();
                    HttpService.change_language("English").then((value) {
                      if (mounted) {
                        setState(() {
                          print(value['success']);
                          if (value['success'] == "true"||value['success']==true) {
                            EasyLoading.dismiss();
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return home();
                            },));
                          }
                          else{
                            EasyLoading.dismiss();
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return home();
                            },));
                          }
                        });
                      }
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                    decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)), // changes position of shadow
                        ],
                        borderRadius: BorderRadius.circular(05)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          child:   Text('Engilsh',
                              style: poppinsMedium.copyWith(
                                  color: ColorResources.BLACK, fontSize: width*0.04)),
                        ),

                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    EasyLoading.show();
                    HttpService.change_language("Hindi").then((value) {
                      if (mounted) {
                        setState(() {
                          print(value['success']);
                          if (value['success'] == "true"||value['success']==true) {
                            EasyLoading.dismiss();
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return home();
                            },));
                          }
                          else{
                            EasyLoading.dismiss();
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return home();
                            },));
                          }
                        });
                      }
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                    decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)), // changes position of shadow
                        ],
                        borderRadius: BorderRadius.circular(05)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          child:   Text('Hindi',
                              style: poppinsMedium.copyWith(
                                  color: ColorResources.BLACK, fontSize: width*0.04)),
                        ),

                      ],
                    ),
                  ),
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
