//
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:miniplayer/miniplayer.dart';
//
// import '../../Controllers/stream_controller.dart';
// import '../../Controllers/user_controller.dart';
// import '../../HttpService/HttpService.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../utill/app_constants.dart';
// import '../../utill/color_resources.dart';
// import '../../utill/styles.dart';
//
// class StreamScreenFixed extends StatefulWidget {
//   final String selectedLanguage;
//   final bool isSession;
//   final String sessionType;
//   const StreamScreenFixed({Key? key, required this.selectedLanguage, required this.isSession, required this.sessionType}) : super(key: key);
//
//   @override
//   State<StreamScreenFixed> createState() => _StreamScreenFixedState();
// }
//
// class _StreamScreenFixedState extends State<StreamScreenFixed>  with SingleTickerProviderStateMixin {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         color: Colors.purple.withOpacity(0.2),
//         child: Stack(
//           children: [
//
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
//
//
//
//
//
//
// }
//
//
// class MyApp2 extends StatefulWidget {
//   final String selectedLanguage;
//   final bool isSession;
//   final String sessionType;
//   const MyApp2({Key? key, required this.selectedLanguage, required this.isSession, required this.sessionType}) : super(key: key);
//
//   @override
//   State<MyApp2> createState() => _MyApp2State();
// }
//
// class _MyApp2State extends State<MyApp2> {
//   final LiveStreamController streamController = Get.find<LiveStreamController>();
//   final UserController userController = Get.find<UserController>();
//   final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey
//   = GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold
//   final MiniplayerController _controller = MiniplayerController();
//   double screenHeight = 50;
//   // late AnimationController _controller;
//   // late Animation<double> _animation;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     streamController.isInitialized.value = false;
//     streamController.isSession.value = widget.isSession;
//     HttpService.getAgoraTokenApi(streamController.channelName.value).then((value) => {
//       streamController.token.value = value['token'],
//       setupVideoSDKEngine(),
//       print("printing token:${value['token']}")
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       // home: StreamScreenFixed(
//       //   selectedLanguage: widget.selectedLanguage,
//       //   sessionType: widget.sessionType,
//       //   isSession: widget.isSession,
//       // ),
//       builder: (context, child) { // <--- Important part
//         return Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: Container(
//             width: double.infinity,
//             height: double.infinity,
//             color: Colors.purple.withOpacity(0.2),
//             child: Stack(
//               children: [
//                 _videoPanel(),
//                 if(!streamController.isJoined.value)
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
//                           color: ColorResources.ORANGE,
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: InkWell(
//                           onTap: streamController.isLoading.value ? null: () => {
//                             streamController.isInitialized.value ? join(): showError()
//                           },
//                           child: streamController.isLoading.value ?
//                           const CircularProgressIndicator():
//                           FittedBox(
//                             child: Text(
//                               "Start Streaming",
//                               style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 Miniplayer(
//                   minHeight: screenHeight,
//                   maxHeight: MediaQuery.of(context).size.height,
//                   onDismiss: () {
//                     _controller.dispose();
//                   },
//                   controller: _controller,
//                   builder: (height, percentage) {
//                     if(percentage > 0.2) {
//                       return Container(
//                         color: Colors.black,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text("Live Stream Screen", style: TextStyle(color: Colors.white),),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     } else {
//                       return Container(
//                         color: Colors.blue,
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Text('minimized Screen'),
//                                 InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                     screenHeight = 0;
//
//                                     });
//                                   },
//                                   child: Icon(Icons.dangerous),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//
//   Future<void> setupVideoSDKEngine() async {
//     // retrieve or request camera and microphone permissions
//     await [Permission.microphone, Permission.camera].request();
//     //create an instance of the Agora engine
//     streamController.agoraEngine = createAgoraRtcEngine();
//     await streamController.agoraEngine.initialize(const RtcEngineContext(
//         appId: AppConstants.agoraAppId
//     ));
//
//     await streamController.agoraEngine.enableVideo();
//
//     // Register the event handler
//     streamController.agoraEngine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           showMessage("Local user uid:${connection.localUid} joined the channel");
//           streamController.isJoined.value = true;
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           showMessage("Remote user uid:$remoteUid joined the channel");
//           streamController.participantCount.value++;
//           HttpService.addParticipantIntoSession(userController.userDetails.first.id);
//           streamController.remoteUid?.value = remoteUid;
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           showMessage("Remote user uid:$remoteUid left the channel");
//           HttpService.removeParticipantFromSession(userController.userDetails.first.id);
//           streamController.participantCount.value--;
//           streamController.remoteUid = null;
//         },
//       ),
//     );
//     streamController.isInitialized.value = true;
//   }
//
//   showMessage(String message) {
//     scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
//       content: Text(message),
//     ));
//   }
//
//   Widget _videoPanel() {
//     if (!streamController.isJoined.value) {
//       return streamController.isLoading.value ? const Center(child: CircularProgressIndicator()):
//       Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
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
//         streamController.isLoading.value = false;
//       }
//       return AgoraVideoView(
//         controller: VideoViewController(
//           rtcEngine: streamController.agoraEngine,
//           canvas: const VideoCanvas(uid: 0),
//         ),
//       );
//     }
//   }
//
//   void join() async {
//     // createChatRoom();
//     streamController.isLoading.value = true;
//     // Set channel options
//     ChannelMediaOptions options;
//
//     // Set channel profile and client role
//     options = const ChannelMediaOptions(
//       clientRoleType: ClientRoleType.clientRoleBroadcaster,
//       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
//     );
//     await streamController.agoraEngine.startPreview();
//
//     await streamController.agoraEngine.joinChannel(
//       token: streamController.token.value,
//       channelId: streamController.channelName.value,
//       options: options,
//       uid: streamController.uid.value,
//     );
//
//     // if(widget.isSession) {
//     //   widget.sessionType == "group" ? HttpService.update_live_status(1): null;
//     // } else {
//     //   HttpService.update_live_status(1);
//     // }
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
//   void leave() async {
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     if(mounted) {
//       streamController.remoteUid = null;
//       streamController.isJoined.value = false;
//       streamController.isLoading.value = false;
//     }
//     streamController.agoraEngine.leaveChannel();
//     // print("groupName: $groupName, groupId: $groupId ");
//     // String groupId = prefs.getString("groupId")!;
//     // await DatabaseService(uid: auth.currentUser?.uid).deleteGroup(groupId);
//     // HttpService.deleteChatRoomApi(userController.userDetails.first.id);
//
//     // if(widget.isSession) {
//     //   widget.sessionType == "group" ? HttpService.update_live_status(0): null;
//     // } else {
//     //   HttpService.update_live_status(0);
//     // }
//   }
//
//
//   @override
//   void dispose() {
//     // HttpService.update_live_status(0);
//     // _controller.dispose();
//     _dispose();
//     // TODO: implement dispose
//     super.dispose();
//   }
//
//   Future<void> _dispose() async {
//     await streamController.agoraEngine.leaveChannel();
//     await streamController.agoraEngine.release();
//   }
//
// }