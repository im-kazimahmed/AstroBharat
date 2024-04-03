import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miniplayer/miniplayer.dart';

import '../../../Chat/service/database_service.dart';
import '../../../Controllers/stream_controller.dart';
import '../../../Controllers/user_controller.dart';
import '../../../HttpService/HttpService.dart';
import '../../../HttpService/model/Wallet_list_Model.dart';
import '../../../HttpService/model/redeem_withdrawal_model.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/share_preferences.dart';
import '../../../utill/styles.dart';
import '../../stream/video_screen.dart';
import 'Request_money.dart';
class Wallet_screen extends StatefulWidget {
  String langType;
  Wallet_screen(this.langType);


  @override
  State<Wallet_screen> createState() => _Wallet_screenState();
}

class _Wallet_screenState extends State<Wallet_screen> {
  final LiveStreamController streamController = Get.find<LiveStreamController>();
  final UserController userController = Get.find<UserController>();
  FirebaseAuth auth = FirebaseAuth.instance;

  Color colors = Colors.black;
  Color? cc;
  Color? cc1;
  List<Data> wallet_list = List.empty(growable: true);
  List<Data1> redeem_withdrawal = List.empty(growable: true);
  bool islode = false;
  int ? balance;
  String ?  minimum;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cc = colors;
    get_api();
    print(PreferenceUtils.getString('token'));
  }
  get_api(){
    HttpService.wallet_api().then((value) {
      if (mounted) {
        setState(() {
          print(value['success']);
          if (value['success'] == true) {
            balance= int.parse(value['total_amt'].toString());
            minimum= value['wallet_limit'];
            print(value["total_amt"]);
            var values = WalletListModel.fromJson(value).data;
            wallet_list.addAll(values);
            // print(wallet_list.length);
            // print(wallet_list);
          }
          else{
            // balance=value['total_amt'];
            // minimum=value['wallet_limit'];
            balance= int.parse(value['total_amt'].toString());
            minimum="250";
          }
          get_redeem_withdrawal_api();
        });
      }
    });
  }
  get_redeem_withdrawal_api(){
    HttpService.redeem_withdrawal_api().then((value) {
      if (mounted) {
        setState(() {
          print(value['success']);
          if (value['success'] == true||value['success'] == "true") {
            var values = RedeemWithdrawalModel.fromJson(value).data1;
            redeem_withdrawal.addAll(values);
            // print(redeem_withdrawal.length);
            // print(redeem_withdrawal);
          }
          islode = true;
        });
      }
    });
  }

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
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: ColorResources.BLACK,
              )),
          title: widget.langType=="English"?Text('Wallet',
              style: poppinsMedium.copyWith(
                    color: ColorResources.BLACK, fontSize: width*0.055)):Text('बटुआ',
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
            islode? Container(
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
                    offset: const Offset(0, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(05),
              ),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(widget.langType=="English"?'Your balance':"आपका संतुलन",
                          style: poppinsRegular.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.06)),
                      Text('$balance₹',
                          style: poppinsRegular.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.05)),
                      Text(widget.langType=="English"?'Minimum withdrawal rupees : ${minimum}':'न्यूनतम निकासी रुपये : ${minimum}',
                          textAlign: TextAlign.center,
                          style: poppinsRegular.copyWith(
                              color: ColorResources.GREY, fontSize: width * 0.045)),
                      Container(
                        margin: EdgeInsets.only(
                            top: height * 0.030,
                            left: width * 0.24,
                            right: width * 0.24),
                        padding: EdgeInsets.only(
                            top: height * 0.015, bottom: height * 0.015),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ColorResources.ORANGE,
                        ),
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            if(balance!>int.parse(minimum.toString())){
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return request_money(widget.langType,balance!);
                              },));
                            }else{
                              widget.langType == "English"
                                  ? AppConstants.show_toast("minimun balance 250 up")
                                  : AppConstants.show_toast("मिनिमम बैलेंस 250 अप");
                            }

                          },
                          child: Text(widget.langType=="English"?'Withdrawal':'निकासी',
                              style: poppinsMedium.copyWith(
                                  color: ColorResources.WHITE, fontSize: width*0.04)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    cc = colors;
                                    cc1=Colors.transparent;
                                  });
                                },
                                child: Text(widget.langType=="English"?'Income ':'आय',
                                    textAlign: TextAlign.center,
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.05)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    cc1 = colors;
                                    cc=Colors.transparent;
                                  });
                                },
                                child: Text(widget.langType=="English"?'Redeem':'भुनाना',
                                    textAlign: TextAlign.center,
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.05)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(height: 1, color: cc),
                          ),
                          Expanded(
                            child: Container(height: 1, color: cc1),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      wallet_list.length==0? const SizedBox(
                        height: 20,
                      ):const SizedBox(),
                      cc == colors ? wallet_list.length==0?Container(
                        color: Colors.transparent,
                        child: Center(
                            child: Container(
                              height: height * 0.2,
                              width: width*0.5,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(Images.no_data))),
                            )
                        ),
                      ): ListView.builder(
                        itemCount: wallet_list.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Card(
                                elevation: 2,
                                child: Container(
                                  height: height * 0.08,
                                  width: width * 0.18,
                                  margin: const EdgeInsets.all(5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      Images.wallet,
                                      height: 10,
                                      width: 10,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(
                                        left: 10, top: 10),
                                    child: Text(
                                        '+ ${wallet_list[index].amount}',
                                        style: poppinsMedium.copyWith(
                                            color: ColorResources.ORANGE,
                                            fontSize: width * 0.04)),
                                  ),
                                  Container(
                                    width: (width - width * 0.20) - 35,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(
                                        left: 10, bottom: 10),
                                    child: Text(
                                        "${wallet_list[index].trannsactionType} ${wallet_list[index].created}",
                                        style: poppinsMedium.copyWith(
                                            color: ColorResources.GREY,
                                            fontSize: width * 0.035)),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ):redeem_withdrawal.length==0?Container(
                        color: Colors.transparent,
                        child: Center(
                            child: Container(
                              height: height * 0.2,
                              width: width*0.5,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(Images.no_data))),
                            )
                        ),
                      ):  ListView.builder(
                        itemCount: redeem_withdrawal.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Card(
                                elevation: 2,
                                child: Container(
                                  height: height * 0.08,
                                  width: width * 0.18,
                                  margin: const EdgeInsets.all(5),
                                  child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.remove_circle_outline,color: ColorResources.RED,size: 45,)
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // width: (width - width * 0.20) - 35,
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(
                                        left: 10, bottom: 10),
                                    child: Text(
                                        "${redeem_withdrawal[index].typeMsg} \n${redeem_withdrawal[index].created}",
                                        style: poppinsMedium.copyWith(
                                            color: ColorResources.GREY,
                                            fontSize: width * 0.035)),
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(
                                        left: 10, top: 10,right: 10),
                                    child: Text(
                                        '- ${redeem_withdrawal[index].requestAmt}',
                                        style: poppinsMedium.copyWith(
                                            color: ColorResources.BLACK,
                                            fontSize: width * 0.04)),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(
                                        left: 10,right: 10),
                                    child: Text(
                                        redeem_withdrawal[index].withdrawStatus==0?widget.langType=="English"?'pending':'लंबित':redeem_withdrawal[index].withdrawStatus==1?widget.langType=="English"?"Accepted":"को स्वीकृत":widget.langType=="English"?"Cancelles":"रद्द",
                                        style: poppinsMedium.copyWith(
                                            color: ColorResources.BLACK,
                                            fontSize: width * 0.04)),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ):const Center(child: CircularProgressIndicator(),),
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
