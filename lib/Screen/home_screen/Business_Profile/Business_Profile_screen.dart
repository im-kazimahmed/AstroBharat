import 'package:astrobharat/HttpService/model/Get_uesr_detali_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniplayer/miniplayer.dart';
import '../../../Chat/service/database_service.dart';
import '../../../Controllers/stream_controller.dart';
import '../../../Controllers/user_controller.dart';
import '../../../HttpService/HttpService.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../../stream/video_screen.dart';
import 'Bank_Detail.dart';
import 'Change_Location.dart';
import 'Personal_Detail.dart';
import 'Proof_Verification.dart';
import 'Update_Fees.dart';
import 'Update_Category.dart';
import 'Update_Language.dart';
import 'Update_Skill.dart';

class BusinessProfileScreen extends StatefulWidget {
  final String langType;
  const BusinessProfileScreen(this.langType, {super.key});


  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  final UserController userController = Get.find<UserController>();
  final LiveStreamController streamController = Get.find<LiveStreamController>();
  FirebaseAuth auth = FirebaseAuth.instance;

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
          title: widget.langType=="English"?Text('Business Profile',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)):Text('व्यापार प्रोफ़ाइल',
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
                  borderRadius: BorderRadius.circular(05)),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: height * 0.1,
                            width: width * 0.2,
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              boxShadow: [BoxShadow(color: ColorResources.GREY,blurRadius: 0.9)],
                              color: ColorResources.WHITE,),
                            child:  CachedNetworkImage(
                              height: height * 0.08,
                              width: width * 0.15,
                              fit: BoxFit.fill,
                              imageUrl:
                              "${AppConstants.IMAGE_VIEW}${userController.userDetails[0].image}",
                              placeholder: (context, url) =>
                                  Image.asset(Images.Astrobharat_logo),
                              errorWidget: (context, url, error) =>
                                  Image.asset(Images.Astrobharat_logo),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(left: 10, top: 10),
                                child: Text(userController.userDetails[0].fullName,
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.04)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(left: 10, bottom: 10),
                                child: Text('+91 ${userController.userDetails[0].moNo }',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.04)),
                              ),
                            ],
                          ),

                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
                        decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1)), // changes position of shadow
                            ],
                            borderRadius: BorderRadius.circular(05)),
                        child: ListTile(
                          leading: const Icon(Icons.person_rounded,color: ColorResources.ORANGE,),
                          title:  Text(
                              widget.langType=="English"?'Personal Detail':'व्यक्तिगत जानकारी',
                              style: poppinsMedium.copyWith(
                                  color: ColorResources.BLACK, fontSize: width*0.04)
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,color: ColorResources.BLACK,),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return personal_detail(userController.userDetails,widget.langType);
                            },));
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
                        decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1)), // changes position of shadow
                            ],
                            borderRadius: BorderRadius.circular(05)),
                        child: ListTile(
                          leading: const Icon(Icons.menu,color: ColorResources.ORANGE,),
                          title: Text(
                              widget.langType=="English"?'Update Fees':'अद्यतन शुल्क',
                              style: poppinsMedium.copyWith(
                                  color: ColorResources.BLACK, fontSize: width*0.04),
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,color: ColorResources.BLACK,),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return UpdateFeesScreen(userController.userDetails,widget.langType);
                            },));
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
                        decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1)), // changes position of shadow
                            ],
                            borderRadius: BorderRadius.circular(05)),
                        child: ListTile(
                          leading: const Icon(Icons.menu,color: ColorResources.ORANGE,),
                          title:   Text(
                              widget.langType=="English"?'Update Skill':'अद्यतन कौशल',
                              style: poppinsMedium.copyWith(
                                  color: ColorResources.BLACK, fontSize: width*0.04)
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,color: ColorResources.BLACK,),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return Update_Skill(userController.userDetails,widget.langType);
                            },));
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
                        decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1)), // changes position of shadow
                            ],
                            borderRadius: BorderRadius.circular(05)),
                        child: ListTile(
                          leading: const Icon(Icons.apps_rounded,color: ColorResources.ORANGE,),
                          title:   Text(
                              widget.langType=="English"?'Update Category':'अद्यतन श्रेणी',
                              style: poppinsMedium.copyWith(
                                  color: ColorResources.BLACK, fontSize: width*0.04)
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,color: ColorResources.BLACK,),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return Update_Category(userController.userDetails,widget.langType);
                            },));
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
                        decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1)), // changes position of shadow
                            ],
                            borderRadius: BorderRadius.circular(05)),
                        child: ListTile(
                          leading: const Icon(Icons.language,color: ColorResources.ORANGE,),
                          title:   Text(
                              widget.langType=="English"?'Update Language':'अद्यतन भाषा',
                              style: poppinsMedium.copyWith(
                                  color: ColorResources.BLACK, fontSize: width*0.04)
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,color: ColorResources.BLACK,),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return Update_Language(userController.userDetails,widget.langType);
                            },));
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
                        decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1)), // changes position of shadow
                            ],
                            borderRadius: BorderRadius.circular(05)),
                        child: ListTile(
                          leading: const Icon(Icons.location_on,color: ColorResources.ORANGE,),
                          title:   Text(
                              widget.langType=="English"? 'Change Location':'स्थान बदलें',
                              style: poppinsMedium.copyWith(
                                  color: ColorResources.BLACK, fontSize: width*0.04)
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,color: ColorResources.BLACK,),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return Change_Location(userController.userDetails,widget.langType);
                            },));
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
                        decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1)), // changes position of shadow
                            ],
                            borderRadius: BorderRadius.circular(05)),
                        child: ListTile(
                          leading: const Icon(Icons.account_balance,color: ColorResources.ORANGE,),
                          title:   Text(
                              widget.langType=="English"? 'Bank Detail':'बैंक का विवरण',
                              style: poppinsMedium.copyWith(
                                  color: ColorResources.BLACK, fontSize: width*0.04)
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,color: ColorResources.BLACK,),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return Bank_Detail(userController.userDetails,widget.langType);
                            },));
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
                        decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1)), // changes position of shadow
                            ],
                            borderRadius: BorderRadius.circular(05)),
                        child: ListTile(
                          leading: const Icon(Icons.verified,color: ColorResources.ORANGE,),
                          title:   Text(
                              widget.langType=="English"? 'Proof Verification & Bio':'सबूत सत्यापन और जैव',
                              style: poppinsMedium.copyWith(
                                  color: ColorResources.BLACK, fontSize: width*0.04)
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,color: ColorResources.BLACK,),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return Proof_Verification(widget.langType);
                            },));
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
                        decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            boxShadow: [
                              BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1)), // changes position of shadow
                            ],
                            borderRadius: BorderRadius.circular(05)),
                        child: ListTile(
                          leading: const Icon(Icons.photo_album_outlined,color: ColorResources.ORANGE,),
                          title:   Text(
                              widget.langType=="English"? 'Album & Certificate':'एल्बम और प्रमाणपत्र',
                              style: poppinsMedium.copyWith(
                                  color: ColorResources.BLACK, fontSize: width*0.04)
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,color: ColorResources.BLACK,),
                          onTap: () {
                            // Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  )
                ],
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
