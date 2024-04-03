// // Flutter imports:
// // ignore_for_file: depend_on_referenced_packages
//
// // Flutter imports:
// import 'package:astrobharat/Controllers/user_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:math' as math;
//
// // Package imports:
// import 'package:provider/provider.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// // Project imports:
// import '../../Controllers/stream_controller.dart';
// import './util/sizer_custom/sizer.dart';
// import './widgets/app_bar_stream.dart';
// import './widgets/comment_widget.dart';
// import './provider/hearts_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../Chat/service/database_service.dart';
// import '../../HttpService/HttpService.dart';
// import '../../utill/app_constants.dart';
// import '../../utill/color_resources.dart';
// import '../../utill/images.dart';
// import '../../utill/styles.dart';
// import '../../HttpService/model/Get_uesr_detali_model.dart';
//
// class StreamScreen extends StatefulWidget {
//   final String selectedLanguage;
//   final bool isSession;
//   final String sessionType;
//   const StreamScreen({Key? key, required this.selectedLanguage, required this.isSession, required this.sessionType}) : super(key: key);
//
//   @override
//   State<StreamScreen> createState() => _StreamScreenState();
// }
//
// class _StreamScreenState extends State<StreamScreen> with SingleTickerProviderStateMixin {
//   final LiveStreamController streamController = Get.find<LiveStreamController>();
//   final UserController userController = Get.find<UserController>();
//   FirebaseAuth auth = FirebaseAuth.instance;
//   math.Random rand = math.Random();
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   String channelName = "test";
//   // String token = "007eJxTYHDXlHvYcexSOsuFZ0dULrUJzT734GL2r77t0sbStzOPuS1SYDAySDVLNEtNSbMwMjQxNDWySEy2MEpJNjayTDNMTkw2f6fSntIQyMiwdG42IyMDBIL4LAwlqcUlDAwA0EMhYw==";
//
//   int uid = 0; // uid of the local user
//   int? _remoteUid; // uid of the remote user
//   bool _isLoading = false;
//   bool _isJoined = false;
//   late RtcEngine agoraEngine; // Agora engine instance
//
//   final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey
//   = GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold
//
//
//   @override
//   void initState() {
//     super.initState();
//     streamController.isInitialized.value = false;
//     streamController.isSession.value = widget.isSession;
//     HttpService.getAgoraTokenApi(channelName).then((value) => {
//       streamController.token.value = value['token'],
//       setupVideoSDKEngine(),
//       print("printing token:${value['token']}")
//     });
//
//     // Set up an instance of Agora engine
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat();
//     _animation = Tween(begin: 0.0, end: 2.0).animate(_controller);
//   }
//
//   Future<void> setupVideoSDKEngine() async {
//     // retrieve or request camera and microphone permissions
//     await [Permission.microphone, Permission.camera].request();
//     //create an instance of the Agora engine
//     agoraEngine = createAgoraRtcEngine();
//     await agoraEngine.initialize(const RtcEngineContext(
//         appId: AppConstants.agoraAppId
//     ));
//
//     await agoraEngine.enableVideo();
//
//     // Register the event handler
//     agoraEngine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           showMessage("Local user uid:${connection.localUid} joined the channel");
//           setState(() {
//             _isJoined = true;
//           });
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           showMessage("Remote user uid:$remoteUid joined the channel");
//           streamController.participantCount.value++;
//           HttpService.addParticipantIntoSession(userController.userDetails.first.id);
//           setState(() {
//             _remoteUid = remoteUid;
//           });
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           showMessage("Remote user uid:$remoteUid left the channel");
//           HttpService.removeParticipantFromSession(userController.userDetails.first.id);
//           streamController.participantCount.value--;
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//       ),
//     );
//
//     streamController.isInitialized.value = true;
//   }
//
//   void join() async {
//     createChatRoom();
//     setState(() {
//       _isLoading = true;
//     });
//     // Set channel options
//     ChannelMediaOptions options;
//
//     // Set channel profile and client role
//     options = const ChannelMediaOptions(
//       clientRoleType: ClientRoleType.clientRoleBroadcaster,
//       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//     );
//     await agoraEngine.startPreview();
//
//     await agoraEngine.joinChannel(
//       token: streamController.token.value,
//       channelId: channelName,
//       options: options,
//       uid: uid,
//     );
//
//     if(widget.isSession) {
//       widget.sessionType == "group" ? HttpService.update_live_status(1): null;
//     } else {
//       HttpService.update_live_status(1);
//     }
//   }
//
//   void leave() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if(mounted) {
//       setState(() {
//         _remoteUid = null;
//         _isJoined = false;
//         _isLoading = false;
//       });
//     }
//     agoraEngine.leaveChannel();
//     // print("groupName: $groupName, groupId: $groupId ");
//     String groupId = prefs.getString("groupId")!;
//     await DatabaseService(uid: auth.currentUser?.uid).deleteGroup(groupId);
//     HttpService.deleteChatRoomApi(userController.userDetails.first.id);
//
//     if(widget.isSession) {
//       widget.sessionType == "group" ? HttpService.update_live_status(0): null;
//     } else {
//       HttpService.update_live_status(0);
//     }
//   }
//
//   showMessage(String message) {
//     scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
//       content: Text(message),
//     ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => FloatingHeartsProvider()),
//       ],
//       child: WillPopScope(
//         onWillPop: () async {
//           Get.defaultDialog(
//             contentPadding: const EdgeInsets.all(20.0),
//             title: "Leave live stream",
//             content: const Text(
//               "Are you sure you want to leave live stream ?",
//               // textAlign: TextAlign.center,
//               overflow: TextOverflow.clip,
//             ),
//             onConfirm: () async {
//               // SharedPreferences prefs = await SharedPreferences.getInstance();
//               // String groupId = prefs.getString("groupId")!;
//               // String groupName = prefs.getString("groupName")!;
//
//               // print(AppConstants.groupName);
//               // print(groupName);
//
//               // print(AppConstants.groupId);
//               // print(groupId);
//               leave();
//               Get.back();
//               Get.back();
//             },
//             onCancel: () {
//               print("cancel");
//             },
//             buttonColor: ColorResources.ORANGE,
//             confirmTextColor: ColorResources.WHITE,
//             cancelTextColor: ColorResources.BLACK,
//           );
//           return true;
//         },
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: Container(
//             width: double.infinity,
//             height: double.infinity,
//             color: Colors.purple.withOpacity(0.2),
//             child: Stack(
//               children: [
//                 //Video Container
//                 _videoPanel(),
//                 Padding(
//                   padding:
//                       EdgeInsets.symmetric(vertical: 16.sp, horizontal: 16.sp),
//                   child: AppBarStream(
//                     consultantDetails: userController.userDetails.first,
//                     onLeave: leave,
//                     isJoined: _isJoined,
//                   ),
//                 ),
//                 if(_isJoined)
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20.sp)
//                         .add(EdgeInsets.only(bottom: 10.sp)),
//                     child: Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           ValueListenableBuilder<String?>(
//                             valueListenable: AppConstants.groupId,
//                             builder: (context, id, _) {
//                               if(id != null){
//                                 return ValueListenableBuilder<String?>(
//                                   valueListenable: AppConstants.groupName,
//                                   builder: (context, group, _) {
//                                     return CommentWidgets(
//                                       groupId: id,
//                                       groupName: group!,
//                                       userImage: userController.userDetails.first.image,
//                                       userName: userController.userDetails.first.fullName,
//                                     );
//                                   },
//                                 );
//                               } else {
//                                 return const Center(child: CircularProgressIndicator());
//                               }
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 if(!_isJoined)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
//                     child: Align(
//                       alignment: Alignment.topRight,
//                       child: Container(
//                         padding: const EdgeInsets.all(10.0),
//                         alignment: Alignment.center,
//                         height: MediaQuery.of(context).size.height * 0.055,
//                         width:  MediaQuery.of(context).size.width * 0.35,
//                         decoration: BoxDecoration(
//                             color: ColorResources.ORANGE,
//                             borderRadius: BorderRadius.circular(5)),
//                         child: InkWell(
//                           onTap: _isLoading ? null: () => {
//                             streamController.isInitialized.value ? join(): showError()
//                           },
//                           child: _isLoading ?
//                           const CircularProgressIndicator():
//                           FittedBox(
//                             child: Text(
//                                 "Start Streaming",
//                                 style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE)),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _videoPanel() {
//     if (!_isJoined) {
//       return _isLoading ? const Center(child: CircularProgressIndicator()):
//       Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               child: AnimatedBuilder(
//                   animation: _animation,
//                   builder: (BuildContext context, Widget? child) {
//                     return ClipOval(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: Colors.red,
//                             width: _animation.value * 2.50,
//                           ),
//                         ),
//                         margin: const EdgeInsets.only(left: 10, top: 10),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(70),
//                           child: CachedNetworkImage(
//                             width: MediaQuery.of(context).size.width * 0.3,
//                             height: MediaQuery.of(context).size.width * 0.3,
//                             fit: BoxFit.fill,
//                             imageUrl: AppConstants.IMAGE_VIEW+userController.userDetails.first.image,
//                             placeholder: (context, url) => Image.asset(Images.Astrobharat_logo),
//                             errorWidget: (context, url, error) => Image.asset(Images.Astrobharat_logo),
//                           ),
//                         ),
//                       ),
//                     );
//                   }
//               ),
//             ),
//             const SizedBox(height: 20,),
//             const Text(
//               'Waiting to start streaming',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//           ],
//         ),
//       );
//     } else {
//       if(mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//       return AgoraVideoView(
//         controller: VideoViewController(
//           rtcEngine: agoraEngine,
//           canvas: const VideoCanvas(uid: 0),
//         ),
//       );
//     }
//   }
//
//
//   void joinChatRoom({
//     required String groupId,
//     required String groupName,
//   }) async {
//     await DatabaseService(uid: auth.currentUser?.uid)
//         .toggleGroupJoin(groupId, userController.userDetails.first.fullName, groupName);
//     // if (_isJoined) {
//     // showSnackbar(context, Colors.green, "Successfully joined the group");
//     // Future.delayed(const Duration(seconds: 2), () {
//     //   nextScreen(
//     //       context,
//     //       ChatPage(
//     //           groupId: groupId,
//     //           groupName: groupName,
//     //           userName: userName));
//     // });
//     // }
//     // else {
//     //   setState(() {
//     //     isJoined = !isJoined;
//     //     showSnackbar(context, Colors.red, "Left the group $groupName");
//     // });
//     // }
//   }
//
//   void createChatRoom() async {
//     String newGroupName = rand.nextInt(1000000).toString();
//     await DatabaseService(uid: auth.currentUser?.uid)
//         .createGroup(userController.userDetails.first.fullName, auth.currentUser!.uid, newGroupName);
//
//     Future.delayed(const Duration(seconds: 2), () {
//       joinChatRoom(
//         groupId: AppConstants.groupId.value!,
//         groupName: AppConstants.groupName.value!,
//       );
//       HttpService.createChatRoomApi(AppConstants.groupName.value!, AppConstants.groupId.value!, userController.userDetails.first.id).then((value) {
//         // if (mounted) {
//         //   // setState(() {
//         //     print(value);
//         //     //  print(value['success']);
//         //     if (value['success'] == "true") {
//         //       var values = ChatRoomModel.fromJson(value).chatRoomDetails;
//         //       print(values.first);
//         //       print("success");
//         //     }
//         //   // });
//         // }
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     HttpService.update_live_status(0);
//     _controller.dispose();
//     _dispose();
//     super.dispose();
//   }
//
//   Future<void> _dispose() async {
//     await agoraEngine.leaveChannel();
//     await agoraEngine.release();
//   }
//
//   showError() {
//     Get.defaultDialog(
//         contentPadding: const EdgeInsets.all(8.0),
//         title: widget.selectedLanguage == "English" ? "Initialization error": "आरंभीकरण त्रुटि",
//         content: Text(
//           widget.selectedLanguage == "English" ?
//           "Cannot initialize live streaming please try again or restart the app and try again":
//           "लाइव स्ट्रीमिंग प्रारंभ नहीं की जा सकती, कृपया पुनः प्रयास करें या ऐप पुनः प्रारंभ करें और पुनः प्रयास करें",
//           textAlign: TextAlign.center,
//         ),
//         actions: [
//           InkWell(
//             onTap: () => Get.back(),
//             child: Container(
//               alignment: Alignment.center,
//               height: MediaQuery.of(context).size.height * 0.055,
//               width: 100,
//               decoration: BoxDecoration(
//                 color: ColorResources.ORANGE,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Text(widget.selectedLanguage == "English"? "OK": "ठीक",
//                 style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
//               ),
//             ),
//           ),
//         ]
//     );
//   }
//
// }
