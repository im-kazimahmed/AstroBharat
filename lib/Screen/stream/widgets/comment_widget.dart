// Flutter imports:
// ignore_for_file: depend_on_referenced_packages

// Flutter imports:
import 'dart:developer';

import 'package:astrobharat/utill/color_resources.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../../Chat/service/database_service.dart';
import '../../../Chat/widgets/message_tile.dart';
import '../../../Controllers/stream_controller.dart';
import '../../../HttpService/HttpService.dart';
import '../widgets/floating_hearts.dart';
import '../provider/hearts_provider.dart';
import './author_message_card.dart';
import '../util/common/touchable_opacity.dart';
import '../util/sizer_custom/sizer.dart';
import 'package:astrobharat/HttpService/model/message_model.dart';

class CommentWidgets extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userImage;
  final String userName;
  const CommentWidgets({Key? key, required this.groupId, required this.userImage, required this.userName, required this.groupName}) : super(key: key);

  @override
  State<CommentWidgets> createState() => _CommentWidgetsState();
}

class _CommentWidgetsState extends State<CommentWidgets> {
  final LiveStreamController streamController = Get.find<LiveStreamController>();
  Stream<QuerySnapshot>? chats;
  Stream<QuerySnapshot>? users;
  String admin = "";
  List<dynamic> oldMembers = [];

  @override
  void initState() {
    getChatAndAdmin();
    watchArray();
    super.initState();
  }

  void watchArray() {
    try {
      DocumentReference documentReference =
      FirebaseFirestore.instance.collection('groups').doc(streamController.chatGroupId.value);

      documentReference.snapshots().listen((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          dynamic data = snapshot.data();
          if (data != null && data['members'] != null) {
            List<dynamic> members = List.from(data['members']);

            // Check for new members
            for (var element in members) {
              if (!oldMembers.contains(element)) {
                List<String> parts = element.split("_");
                String name = parts[1];

                if(streamController.selectedVideoProvider.value?.userName != name) {
                  streamController.newUserHasJoined.value = true;
                  streamController.newUserJoined.value = "$name has joined";
                  Future.delayed(const Duration(seconds: 5), () {
                    streamController.newUserHasJoined.value = false;
                  });
                  print("New user $element joined");
                }
              }
            }

            // Check for removed members
            for (var element in oldMembers) {
              if (!members.contains(element)) {
                streamController.newUserHasJoined.value = true;
                List<String> parts = element.split("_");
                String name = parts[1];
                streamController.newUserJoined.value = "$name has left";
                Future.delayed(const Duration(seconds: 5), () {
                  streamController.newUserHasJoined.value = false;
                });
                print("User $element left");
              }
            }

            oldMembers = members;
            print('Updated members array: $members');
          }
        }
      });
    } catch (e) {
      //
    }
  }


  getChatAndAdmin() {
    try {
      Future.delayed(const Duration(seconds: 5), () {
        DatabaseService().getChats(streamController.chatGroupId.value).then((val) {
          setState(() {
            chats = val;
          });
          watchArray();
        });
      });
    } on FirebaseException catch (_, e) {
      log("error getting chats");
      log(_.message.toString());
    }

    DatabaseService().getGroupAdmin(streamController.chatGroupId.value).then((val) {
      // setState(() {
        admin = val;
      // });
    });
  }

  chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData ?
        ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return MessageTile(
              message: snapshot.data.docs[index]['message'],
              sender: snapshot.data.docs[index]['sender'],
              userImage: widget.userImage,
              sentByMe: widget.userName == snapshot.data.docs[index]['sender'],
            );
          },
        ): Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.sp,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.transparent,
                          Colors.white,
                          Colors.white,
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.sp),
                      height: 280.sp,
                      child: chatMessages(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.sp,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 4.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.sp),
                          color: Colors.grey.withOpacity(0.28),
                        ),
                        child: TextField(
                          controller: streamController.messageController,
                          cursorColor: ColorResources.ORANGE,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(fontSize: 11.sp, color: Colors.grey),
                            hintText: 'Send a message...',
                            contentPadding: EdgeInsets.all(12.sp),
                            suffixIcon: Container(
                              // padding: EdgeInsets.all(4.sp),
                              margin: EdgeInsets.all(4.sp),
                              width: 12.sp,
                              height: 12.sp,
                              decoration: BoxDecoration(
                                  color: ColorResources.ORANGE,
                                  borderRadius: BorderRadius.circular(100.sp)),
                              child: InkWell(
                                onTap: () => sendMessage(),
                                child: Icon(
                                  Icons.send,
                                  // PhosphorIcons.paperPlaneTiltBold,
                                  size: 16.0.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if(streamController.isSession.value)
                      SizedBox(
                        width: 2.sp,
                      ),
                    if(streamController.isSession.value)
                      TouchableOpacity(
                        onTap: () {
                          EasyLoading.show();
                          HttpService.editAppointmentMarkAttendedApi(streamController.appointmentId.value).then((value) {
                            print(streamController.appointmentId.value);
                            print(value);
                            print(value['success']);
                            if (value['success'] == "true" || value['success'] == true) {
                              streamController.isAttended.value = true;
                              EasyLoading.dismiss();
                              // showDialogueBox("Success", "Appointment successfully updated!", true);
                            } else {
                              EasyLoading.dismiss();
                              // showDialogueBox("Failed", "Failed to update try again", false);
                              print("failed to update");
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 4.sp),
                          height: 40.sp,
                          width: 40.sp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.sp),
                            color: Colors.grey.withOpacity(0.28),
                          ),
                          child: Icon(
                            Icons.done_all,
                            color: Colors.white,
                            size: 20.0.sp,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          // SizedBox(
          //   width: 6.sp,
          // ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     const Expanded(
          //       child: FloatingHeartsWidget(),
          //     ),
          //     TouchableOpacity(
          //       onTap: () {
          //         FloatingHeartsProvider floatingHeartsProvider =
          //             context.read<FloatingHeartsProvider>();
          //         floatingHeartsProvider.addHeart();
          //       },
          //       child: Container(
          //         height: 40.sp,
          //         width: 40.sp,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(100.sp),
          //           color: Colors.grey.withOpacity(0.28),
          //         ),
          //         child: Icon(
          //           Icons.favorite,
          //           color: Colors.red,
          //           size: 24.0.sp,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  sendMessage() {
    if (streamController.messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": streamController.messageController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService().sendMessage(widget.groupId, chatMessageMap);
      streamController.messageController.clear();
    }
  }

}
