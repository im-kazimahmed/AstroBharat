import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniplayer/miniplayer.dart';

import '../../../Chat/service/database_service.dart';
import '../../../Controllers/stream_controller.dart';
import '../../../Controllers/user_controller.dart';
import '../../../HttpService/HttpService.dart';
import '../../../HttpService/model/Question_History_Model.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../../stream/video_screen.dart';
import 'All_Answer_List.dart';

class QuestionAnswer extends StatefulWidget {
  String langType;
  QuestionAnswer(this.langType, {super.key});

  @override
  State<QuestionAnswer> createState() => _QuestionAnswerState();
}

class _QuestionAnswerState extends State<QuestionAnswer>{
  final LiveStreamController streamController = Get.find<LiveStreamController>();
  final UserController userController = Get.find<UserController>();
  FirebaseAuth auth = FirebaseAuth.instance;

  List<Data> questionHistory  = List.empty(growable: true);
  bool _isloaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HttpService.question_history_api().then((value) {
      if (mounted) {
        setState(() {
          if (value['success'] == true) {
            var values = QuestionHistoryModel.fromJson(value).data;
            questionHistory.addAll(values);
          }
          _isloaded = true;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading:IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_sharp,color: ColorResources.BLACK,)),
          title: Text(widget.langType == "English" ? 'Question': 'प्रश्न',
            style: poppinsMedium.copyWith(
              color: ColorResources.BLACK,
              fontSize: width*0.055,
            ),
          ),
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
            _isloaded? questionHistory.isEmpty? Container(
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
              child: Center(
                  child: Container(
                    height: height * 0.2,
                    width: width*0.5,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Images.no_data),
                      ),
                    ),
                  )
              ),
            ): Container(
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
              child: Column(
                children: [
                  Flexible(
                    child: ListView.builder(itemCount: questionHistory.length,itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return All_Answer_List(widget.langType,questionHistory[index].freeQueAnswerList,questionHistory[index].question,questionHistory[index].id);
                            },));
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: width - 44,
                                        margin: const EdgeInsets.only(left: 10, bottom: 2,right: 10),
                                        child: Text(questionHistory[index].userName,
                                          style: poppinsMedium.copyWith(
                                            color: ColorResources.BLACK,
                                            fontSize: width * 0.05,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: height * 0.035,
                                            width: width * 0.06,
                                            margin: const EdgeInsets.only(right: 10,left: 10),
                                            child: Image.asset(Images.msg,color: ColorResources.ORANGE,),
                                          ),
                                          Container(
                                            width: (width -width * 0.06) - 44,
                                            alignment: Alignment.topLeft,
                                            child: Text(questionHistory[index].question,
                                              style: poppinsMedium.copyWith(
                                                color: ColorResources.GREY,
                                                fontSize: width * 0.04,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: width - 20,
                                        alignment: Alignment.centerRight,
                                        child: Text(questionHistory[index].created,
                                          style: poppinsMedium.copyWith(
                                            color: ColorResources.GREY,
                                            fontSize: width * 0.035,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    ),
                  )
                ],
              ),
            ): const Center(child: CircularProgressIndicator(),),
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
        )
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
