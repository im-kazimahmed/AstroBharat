// import 'dart:developer';
// import 'dart:math' as math;
//
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:agora_token_service/agora_token_service.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../Chat/pages/chat_page.dart';
// import '../../Chat/service/database_service.dart';
// import '../../HttpService/HttpService.dart';
// import '../../utill/app_constants.dart';
// import '../../utill/color_resources.dart';
// import '../../utill/images.dart';
// import '../../utill/styles.dart';
// import '../../HttpService/model/Get_uesr_detali_model.dart';
//
//
// class StreamingPage extends StatefulWidget {
//   final Data userDetails;
//   final bool isSession;
//   final int? appointmentId;
//   const StreamingPage({Key? key, required this.userDetails, required this.isSession, this.appointmentId}) : super(key: key);
//
//   @override
//   _StreamingPageState createState() => _StreamingPageState();
// }
//
// class _StreamingPageState extends State<StreamingPage> with SingleTickerProviderStateMixin {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   math.Random rand = math.Random();
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   bool isAttended = false;
//
//   String channelName = "test";
//   String token = "007eJxTYFBfoJakz7gi/07+jL1PZDb82HDg6XbzS64Krv1++w849zxVYDAySDVLNEtNSbMwMjQxNDWySEy2MEpJNjayTDNMTkw2L1g1MaUhkJGhwVmbkZEBAkF8FoaS1OISBgYAjiEgQg==";
//   bool isLoading = false;
//
//   int uid = 0; // uid of the local user
//   int? _remoteUid; // uid of the remote user
//   bool _isJoined = false; // Indicates if the local user has joined the channel
//   late RtcEngine agoraEngine; // Agora engine instance
//
//   final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey
//   = GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold
//
//   @override
//   void initState() {
//     super.initState();
//     HttpService.getAgoraTokenApi(channelName).then((value) => {
//       print("token before $token"),
//       setState(() {
//         token = value['token'];
//       }),
//       setupVideoSDKEngine(),
//       print("token after $token"),
//       print("printing token:${value['token']}")
//     });
//     // Set up an instance of Agora engine
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat();
//     _animation = Tween(begin: 0.0, end: 2.0).animate(_controller);
//   }
//
//   // void generateToken() {
//   //   const appId = AppConstants.agoraAppId;
//   //   const appCertificate = AppConstants.agoraAppCertificate;
//   //   const channelName = 'test';
//   //   String uid = rand.nextInt(999999).toString();
//   //   const role = RtcRole.publisher;
//   //
//   //   const expirationInSeconds = 3600;
//   //   final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//   //   final expireTimestamp = currentTimestamp + expirationInSeconds;
//   //
//   //   final token = RtcTokenBuilder.build(
//   //     appId: appId,
//   //     appCertificate: appCertificate,
//   //     channelName: channelName,
//   //     uid: uid,
//   //     role: role,
//   //     expireTimestamp: expireTimestamp,
//   //   );
//   //
//   //   setState(() {
//   //     this.token = token;
//   //   });
//   //   print('token: $token');
//   // }
//
//   Future<void> setupVideoSDKEngine() async {
//     // retrieve or request camera and microphone permissions
//     await [Permission.microphone, Permission.camera].request();
//
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
//           setState(() {
//             _remoteUid = remoteUid;
//           });
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid,
//             UserOfflineReasonType reason) {
//           showMessage("Remote user uid:$remoteUid left the channel");
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//       ),
//     );
//   }
//
//   void join() async {
//     createChatRoom();
//     if(mounted) {
//       setState(() {
//         isLoading = true;
//       });
//     }
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
//       token: token,
//       channelId: channelName,
//       options: options,
//       uid: uid,
//     );
//     widget.isSession ? null : HttpService.update_live_status(1);
//   }
//
//   void leave() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if(mounted) {
//       setState(() {
//         _isJoined = false;
//         _remoteUid = null;
//         isLoading = false;
//       });
//     }
//     agoraEngine.leaveChannel();
//     // print("groupName: $groupName, groupId: $groupId ");
//     String groupId = prefs.getString("groupId")!;
//     await DatabaseService(uid: auth.currentUser?.uid).deleteGroup(groupId);
//     HttpService.deleteChatRoomApi(widget.userDetails.id);
//     widget.isSession ? null : HttpService.update_live_status(0);
//   }
//
//   showMessage(String message) {
//     scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
//       content: Text(message),
//     ));
//   }
//
//   void markAttended(int appointmentId) {
//     HttpService.editAppointmentMarkAttendedApi(appointmentId).then((value) {
//       if (mounted) {
//         setState(() {
//           print(value['success']);
//           if (value['success'] == "true" || value['success'] == true) {
//             isAttended = true;
//             // showDialogueBox("Success", "Appointment successfully updated!", true);
//           } else {
//             isAttended = false;
//             // showDialogueBox("Failed", "Failed to update try again", false);
//             print("failed to update");
//           }
//         });
//       }
//     });
//   }
//
//   // Build UI
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return MaterialApp(
//       scaffoldMessengerKey: scaffoldMessengerKey,
//       home: Scaffold(
//           body: SizedBox(
//             height: size.height,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   // Container for the local video
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height - 100,
//                     width: MediaQuery.of(context).size.width,
//                     // decoration: BoxDecoration(border: Border.all()),
//                     child: Center(child: Column(
//                       children: [
//                         SizedBox(
//                             height: MediaQuery.of(context).size.height- 400,
//                             child: _videoPanel()
//                         ),
//                         if(_isJoined)
//                           SizedBox(
//                             height: 300,
//                             child: ValueListenableBuilder<String?>(
//                               valueListenable: AppConstants.groupId,
//                               builder: (context, id, _) {
//                                 if(id != null){
//                                   return ValueListenableBuilder<String?>(
//                                     valueListenable: AppConstants.groupName,
//                                     builder: (context, group, _) {
//                                       return ChatPage(
//                                         groupId: id,
//                                         groupName: group!,
//                                         userName: widget.userDetails.fullName,
//                                       );
//                                     },
//                                   );
//                                 } else {
//                                   return const Center(child: CircularProgressIndicator());
//                                 }
//                               },
//                             ),
//                           )
//                       ],
//                     )),
//                   ),
//                   // Container(
//                   //   height: size.height - 50,
//                   //   decoration: BoxDecoration(border: Border.all()),
//                   //   child: Center(child: _videoPanel()),
//                   // ),
//
//                   // Button Row
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10.0),
//                           alignment: Alignment.center,
//                           height: size.height * 0.055,
//                           width:  size.width * 0.35,
//                           decoration: BoxDecoration(
//                               color: ColorResources.ORANGE,
//                               borderRadius: BorderRadius.circular(5)),
//                           child: InkWell(
//                             onTap: isLoading ? null: () => {join()},
//                             child: isLoading ?
//                             const CircularProgressIndicator():
//                             FittedBox(
//                               child: Text(
//                                 "Start Streaming",
//                                 style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE)),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 20),
//                         Container(
//                           padding: const EdgeInsets.all(10.0),
//                           alignment: Alignment.center,
//                           height: size.height * 0.055,
//                           width:  size.width * 0.35,
//                           decoration: BoxDecoration(
//                             color: ColorResources.ORANGE,
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: InkWell(
//                             onTap: () => {leave()},
//                             child: FittedBox(
//                               child: Text(
//                                 "Leave",
//                                 style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
//                               ),
//                             ),
//                           ),
//                         )                    ],
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   // Row(
//                   //   children: <Widget>[
//                   //     Expanded(
//                   //       child: ElevatedButton(
//                   //         child: const Text("Start Streaming"),
//                   //         onPressed: () => {join()},
//                   //       ),
//                   //     ),
//                   //     const SizedBox(width: 10),
//                   //     Expanded(
//                   //       child: ElevatedButton(
//                   //         child: const Text("Leave"),
//                   //         onPressed: () => {leave()},
//                   //       ),
//                   //     ),
//                   //   ],
//                   // ),
//                   // Button Row ends
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
//
//   Widget _videoPanel() {
//     if (!_isJoined) {
//       return isLoading ? const Center(child: CircularProgressIndicator()):
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
//                             imageUrl: AppConstants.IMAGE_VIEW+widget.userDetails.image,
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
//           isLoading = false;
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
//   void joinChatRoom({
//     required String groupId,
//     required String groupName,
//   }) async {
//     await DatabaseService(uid: auth.currentUser?.uid)
//         .toggleGroupJoin(groupId, widget.userDetails.fullName, groupName);
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
//       // });
//     // }
//   }
//
//   void createChatRoom() async {
//     String newGroupName = rand.nextInt(1000000).toString();
//     await DatabaseService(uid: auth.currentUser?.uid)
//         .createGroup(widget.userDetails.fullName, auth.currentUser!.uid, newGroupName);
//
//     Future.delayed(const Duration(seconds: 2), () {
//       joinChatRoom(
//         groupId: AppConstants.groupId.value!,
//         groupName: AppConstants.groupName.value!,
//       );
//       HttpService.createChatRoomApi(AppConstants.groupName.value!, AppConstants.groupId.value!, widget.userDetails.id).then((value) {
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
//     _controller.dispose();
//     super.dispose();
//     _dispose();
//     HttpService.update_live_status(0);
//   }
//
//   Future<void> _dispose() async {
//     await agoraEngine.leaveChannel();
//     await agoraEngine.release();
//   }
//
// }
//
//
//
//
//
// // import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// //
// //
// //
// //
// // /// Get your own App ID at https://dashboard.agora.io/
// // // String get appId {
// // //   // Allow pass an `appId` as an environment variable with name `TEST_APP_ID` by using --dart-define
// // //   return const String.fromEnvironment('TEST_APP_ID',
// // //       defaultValue: '4eced9c67dc7485e93d8edad4384a9ee');
// // // }
// //
// // /// Please refer to https://docs.agora.io/en/Agora%20Platform/token
// // // String get token {
// // //   // Allow pass a `token` as an environment variable with name `TEST_TOKEN` by using --dart-define
// // //   return const String.fromEnvironment('TEST_TOKEN',
// // //       defaultValue: 'a052ccad6d1a42e28271b41dd18ae985');
// // // }
// //
// // /// Your channel ID
// // // String get channelId {
// // //   // Allow pass a `channelId` as an environment variable with name `TEST_CHANNEL_ID` by using --dart-define
// // //   return const String.fromEnvironment(
// // //     'TEST_CHANNEL_ID',
// // //     defaultValue: 'test',
// // //   );
// // // }
// //
// // /// Your int user ID
// // const int uid = 0;
// //
// // /// Your user ID for the screen sharing
// // const int screenSharingUid = 10;
// //
// // /// Your string user ID
// // const String stringUid = '0';
// //
// // // String get musicCenterAppId {
// // //   // Allow pass a `token` as an environment variable with name `TEST_TOKEN` by using --dart-define
// // //   return const String.fromEnvironment('MUSIC_CENTER_APPID',
// // //       defaultValue: '<MUSIC_CENTER_APPID>');
// // // }
// //
// //
// // /// MultiChannel Example
// // class JoinChannelVideo extends StatefulWidget {
// //   /// Construct the [JoinChannelVideo]
// //   const JoinChannelVideo({Key? key}) : super(key: key);
// //
// //   @override
// //   State<StatefulWidget> createState() => _State();
// // }
// //
// // class _State extends State<JoinChannelVideo> {
// //   late final RtcEngine _engine;
// //
// //   bool isJoined = false, switchCamera = true, switchRender = true;
// //   Set<int> remoteUid = {};
// //   late TextEditingController _controller;
// //   bool _isUseFlutterTexture = false;
// //   bool _isUseAndroidSurfaceView = false;
// //   ChannelProfileType _channelProfileType =
// //       ChannelProfileType.channelProfileLiveBroadcasting;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = TextEditingController(text: 'test');
// //
// //     _initEngine();
// //   }
// //
// //   @override
// //   void dispose() {
// //     super.dispose();
// //     _dispose();
// //   }
// //
// //   Future<void> _dispose() async {
// //     await _engine.leaveChannel();
// //     await _engine.release();
// //   }
// //
// //   Future<void> _initEngine() async {
// //     _engine = createAgoraRtcEngine();
// //     await _engine.initialize(RtcEngineContext(
// //       appId: "20e6a6edf82141528ac82dc329f1cac7",
// //     ));
// //
// //     _engine.registerEventHandler(RtcEngineEventHandler(
// //       onError: (ErrorCodeType err, String msg) {
// //         logSink.log('[onError] err: $err, msg: $msg');
// //       },
// //       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
// //         logSink.log(
// //             '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
// //         setState(() {
// //           isJoined = true;
// //         });
// //       },
// //       onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
// //         logSink.log(
// //             '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
// //         setState(() {
// //           remoteUid.add(rUid);
// //         });
// //       },
// //       onUserOffline:
// //           (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
// //         logSink.log(
// //             '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
// //         setState(() {
// //           remoteUid.removeWhere((element) => element == rUid);
// //         });
// //       },
// //       onLeaveChannel: (RtcConnection connection, RtcStats stats) {
// //         logSink.log(
// //             '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
// //         setState(() {
// //           isJoined = false;
// //           remoteUid.clear();
// //         });
// //       },
// //     ));
// //
// //     await _engine.enableVideo();
// //   }
// //
// //   Future<void> _joinChannel() async {
// //     await _engine.joinChannel(
// //       token: '007eJxTYBBaYqBu4Wrc8uZp/CyBk6eXuobuL6wSiNu3J3WuQ012ZJ8Cg5FBqlmiWWpKmoWRoYmhqZFFYrKFUUqysZFlmmFyYrL53q7klIZARobXHvzMjAwQCOKzMJSkFpcwMAAA7jceeg==',
// //       channelId: _controller.text,
// //       uid: uid,
// //       options: ChannelMediaOptions(
// //         channelProfile: _channelProfileType,
// //         clientRoleType: ClientRoleType.clientRoleAudience,
// //       ),
// //     );
// //   }
// //
// //   Future<void> _leaveChannel() async {
// //     await _engine.leaveChannel();
// //   }
// //
// //   Future<void> _switchCamera() async {
// //     await _engine.switchCamera();
// //     setState(() {
// //       switchCamera = !switchCamera;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return ExampleActionsWidget(
// //       displayContentBuilder: (context, isLayoutHorizontal) {
// //         return Stack(
// //           children: [
// //             AgoraVideoView(
// //               controller: VideoViewController(
// //                 rtcEngine: _engine,
// //                 canvas: const VideoCanvas(uid: 0),
// //                 useFlutterTexture: _isUseFlutterTexture,
// //                 useAndroidSurfaceView: _isUseAndroidSurfaceView,
// //               ),
// //               onAgoraVideoViewCreated: (viewId) {
// //                 _engine.startPreview();
// //               },
// //             ),
// //             Align(
// //               alignment: Alignment.topLeft,
// //               child: SingleChildScrollView(
// //                 scrollDirection: Axis.horizontal,
// //                 child: Row(
// //                   children: List.of(remoteUid.map(
// //                         (e) => SizedBox(
// //                       width: 120,
// //                       height: 120,
// //                       child: AgoraVideoView(
// //                         controller: VideoViewController.remote(
// //                           rtcEngine: _engine,
// //                           canvas: VideoCanvas(uid: e),
// //                           connection:
// //                           RtcConnection(channelId: _controller.text),
// //                           useFlutterTexture: _isUseFlutterTexture,
// //                           useAndroidSurfaceView: _isUseAndroidSurfaceView,
// //                         ),
// //                       ),
// //                     ),
// //                   )),
// //                 ),
// //               ),
// //             )
// //           ],
// //         );
// //       },
// //       actionsBuilder: (context, isLayoutHorizontal) {
// //         final channelProfileType = [
// //           ChannelProfileType.channelProfileLiveBroadcasting,
// //           ChannelProfileType.channelProfileCommunication,
// //         ];
// //         final items = channelProfileType
// //             .map((e) => DropdownMenuItem(
// //           child: Text(
// //             e.toString().split('.')[1],
// //           ),
// //           value: e,
// //         ))
// //             .toList();
// //
// //         return Column(
// //           mainAxisAlignment: MainAxisAlignment.start,
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             TextField(
// //               controller: _controller,
// //               decoration: const InputDecoration(hintText: 'Channel ID'),
// //             ),
// //             if (!kIsWeb &&
// //                 (defaultTargetPlatform == TargetPlatform.android ||
// //                     defaultTargetPlatform == TargetPlatform.iOS))
// //               Row(
// //                 mainAxisSize: MainAxisSize.min,
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 children: [
// //                   if (defaultTargetPlatform == TargetPlatform.iOS)
// //                     Column(
// //                         mainAxisAlignment: MainAxisAlignment.start,
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           const Text('Rendered by Flutter texture: '),
// //                           Switch(
// //                             value: _isUseFlutterTexture,
// //                             onChanged: isJoined
// //                                 ? null
// //                                 : (changed) {
// //                               setState(() {
// //                                 _isUseFlutterTexture = changed;
// //                               });
// //                             },
// //                           )
// //                         ]),
// //                   if (defaultTargetPlatform == TargetPlatform.android)
// //                     Column(
// //                         mainAxisAlignment: MainAxisAlignment.start,
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           const Text('Rendered by Android SurfaceView: '),
// //                           Switch(
// //                             value: _isUseAndroidSurfaceView,
// //                             onChanged: isJoined
// //                                 ? null
// //                                 : (changed) {
// //                               setState(() {
// //                                 _isUseAndroidSurfaceView = changed;
// //                               });
// //                             },
// //                           ),
// //                         ]),
// //                 ],
// //               ),
// //             const SizedBox(
// //               height: 20,
// //             ),
// //             const Text('Channel Profile: '),
// //             DropdownButton<ChannelProfileType>(
// //               items: items,
// //               value: _channelProfileType,
// //               onChanged: isJoined
// //                   ? null
// //                   : (v) {
// //                 setState(() {
// //                   _channelProfileType = v!;
// //                 });
// //               },
// //             ),
// //             const SizedBox(
// //               height: 20,
// //             ),
// //             BasicVideoConfigurationWidget(
// //               rtcEngine: _engine,
// //               title: 'Video Encoder Configuration',
// //               setConfigButtonText: const Text(
// //                 'setVideoEncoderConfiguration',
// //                 style: TextStyle(fontSize: 10),
// //               ),
// //               onConfigChanged: (width, height, frameRate, bitrate) {
// //                 _engine.setVideoEncoderConfiguration(VideoEncoderConfiguration(
// //                   dimensions: VideoDimensions(width: width, height: height),
// //                   frameRate: frameRate,
// //                   bitrate: bitrate,
// //                 ));
// //               },
// //             ),
// //             const SizedBox(
// //               height: 20,
// //             ),
// //             Row(
// //               children: [
// //                 Expanded(
// //                   flex: 1,
// //                   child: ElevatedButton(
// //                     onPressed: isJoined ? _leaveChannel : _joinChannel,
// //                     child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
// //                   ),
// //                 )
// //               ],
// //             ),
// //             if (defaultTargetPlatform == TargetPlatform.android ||
// //                 defaultTargetPlatform == TargetPlatform.iOS) ...[
// //               const SizedBox(
// //                 height: 20,
// //               ),
// //               ElevatedButton(
// //                 onPressed: _switchCamera,
// //                 child: Text('Camera ${switchCamera ? 'front' : 'rear'}'),
// //               ),
// //             ],
// //           ],
// //         );
// //       },
// //     );
// //     // if (!_isInit) return Container();
// //   }
// // }
// //
// //
// //
// //
// //
// //
// //
// //
// // class BasicVideoConfigurationWidget extends StatefulWidget {
// //   const BasicVideoConfigurationWidget({
// //     Key? key,
// //     required this.rtcEngine,
// //     required this.setConfigButtonText,
// //     required this.title,
// //     this.width = 960,
// //     this.height = 540,
// //     this.frameRate = 15,
// //     this.bitrate = 0,
// //     this.onConfigChanged,
// //   }) : super(key: key);
// //
// //   final RtcEngine rtcEngine;
// //
// //   final String title;
// //   final int width;
// //   final int height;
// //   final int frameRate;
// //   final int bitrate;
// //
// //   final Widget setConfigButtonText;
// //   final Function(int width, int height, int frameRate, int bitrate)?
// //   onConfigChanged;
// //
// //   @override
// //   State<BasicVideoConfigurationWidget> createState() =>
// //       _BasicVideoConfigurationWidgetState();
// // }
// //
// // class _BasicVideoConfigurationWidgetState
// //     extends State<BasicVideoConfigurationWidget> {
// //   late TextEditingController _heightController;
// //   late TextEditingController _widthController;
// //   late TextEditingController _frameRateController;
// //   late TextEditingController _bitrateController;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     _widthController = TextEditingController(text: widget.width.toString());
// //     _heightController = TextEditingController(text: widget.height.toString());
// //     _frameRateController =
// //         TextEditingController(text: widget.frameRate.toString());
// //     _bitrateController = TextEditingController(text: widget.bitrate.toString());
// //   }
// //
// //   @override
// //   void dispose() {
// //     super.dispose();
// //     _dispose();
// //   }
// //
// //   Future<void> _dispose() async {
// //     _widthController.dispose();
// //     _heightController.dispose();
// //     _frameRateController.dispose();
// //     _bitrateController.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.all(8),
// //       decoration: BoxDecoration(
// //         color: Colors.blueGrey[50],
// //         borderRadius: const BorderRadius.all(Radius.circular(4.0)),
// //       ),
// //       child: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         mainAxisAlignment: MainAxisAlignment.start,
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             widget.title,
// //             style: const TextStyle(fontSize: 10),
// //           ),
// //           const SizedBox(
// //             height: 10,
// //           ),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.start,
// //             mainAxisSize: MainAxisSize.max,
// //             children: [
// //               Expanded(
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.start,
// //                   mainAxisSize: MainAxisSize.min,
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     const Text('width: '),
// //                     TextField(
// //                       controller: _widthController,
// //                       decoration: const InputDecoration(
// //                         hintText: 'width',
// //                         border: OutlineInputBorder(gapPadding: 0.0),
// //                         isDense: true,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(
// //                 width: 10,
// //               ),
// //               Expanded(
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.start,
// //                   mainAxisSize: MainAxisSize.min,
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     const Text('heigth: '),
// //                     TextField(
// //                       controller: _heightController,
// //                       decoration: const InputDecoration(
// //                         hintText: 'height',
// //                         border: OutlineInputBorder(),
// //                         isDense: true,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(
// //             height: 10,
// //           ),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.start,
// //             mainAxisSize: MainAxisSize.max,
// //             children: [
// //               Expanded(
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.start,
// //                   mainAxisSize: MainAxisSize.min,
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     const Text('frame rate: '),
// //                     TextField(
// //                       controller: _frameRateController,
// //                       decoration: const InputDecoration(
// //                         hintText: 'frame rate',
// //                         border: OutlineInputBorder(),
// //                         isDense: true,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(
// //                 width: 10,
// //               ),
// //               Expanded(
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.start,
// //                   mainAxisSize: MainAxisSize.min,
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     const Text('bitrate: '),
// //                     TextField(
// //                       controller: _bitrateController,
// //                       decoration: const InputDecoration(
// //                         hintText: 'bitrate',
// //                         border: OutlineInputBorder(),
// //                         isDense: true,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(
// //             width: 10,
// //           ),
// //           ElevatedButton(
// //             child: widget.setConfigButtonText,
// //             onPressed: () {
// //               widget.onConfigChanged?.call(
// //                   int.parse(_widthController.text),
// //                   int.parse(_heightController.text),
// //                   int.parse(_frameRateController.text),
// //                   int.parse(_bitrateController.text));
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// //
// //
// //
// // typedef ExampleActionsBuilder = Widget Function(
// //     BuildContext context, bool isLayoutHorizontal);
// //
// // class ExampleActionsWidget extends StatelessWidget {
// //   const ExampleActionsWidget({
// //     Key? key,
// //     required this.displayContentBuilder,
// //     this.actionsBuilder,
// //   }) : super(key: key);
// //
// //   final ExampleActionsBuilder displayContentBuilder;
// //
// //   final ExampleActionsBuilder? actionsBuilder;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final mediaData = MediaQuery.of(context);
// //     final bool isLayoutHorizontal = mediaData.size.aspectRatio >= 1.5 ||
// //         (kIsWeb ||
// //             !(defaultTargetPlatform == TargetPlatform.android ||
// //                 defaultTargetPlatform == TargetPlatform.iOS));
// //
// //     if (actionsBuilder == null) {
// //       return displayContentBuilder(context, isLayoutHorizontal);
// //     }
// //
// //     const actionsTitle = Text(
// //       'Actions',
// //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
// //     );
// //
// //     if (isLayoutHorizontal) {
// //       return Row(
// //         mainAxisAlignment: MainAxisAlignment.start,
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         mainAxisSize: MainAxisSize.max,
// //         children: [
// //           Expanded(
// //             flex: 1,
// //             child: SingleChildScrollView(
// //               child: Container(
// //                 padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   mainAxisAlignment: MainAxisAlignment.start,
// //                   mainAxisSize: MainAxisSize.max,
// //                   children: [
// //                     actionsTitle,
// //                     actionsBuilder!(context, isLayoutHorizontal),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //           Container(
// //             color: Colors.grey.shade100,
// //             width: 20,
// //           ),
// //           Expanded(
// //             flex: 2,
// //             child: displayContentBuilder(context, isLayoutHorizontal),
// //           ),
// //         ],
// //       );
// //     }
// //
// //     return Stack(
// //       children: [
// //         SizedBox.expand(
// //           child: Container(
// //             padding: const EdgeInsets.only(bottom: 150),
// //             child: displayContentBuilder(context, isLayoutHorizontal),
// //           ),
// //         ),
// //         DraggableScrollableSheet(
// //           initialChildSize: 0.25,
// //           snap: true,
// //           maxChildSize: 0.7,
// //           builder: (BuildContext context, ScrollController scrollController) {
// //             return Container(
// //               decoration: const BoxDecoration(
// //                   color: Color.fromARGB(255, 253, 253, 253),
// //                   borderRadius: BorderRadius.only(
// //                     topLeft: Radius.circular(24.0),
// //                     topRight: Radius.circular(24.0),
// //                   ),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       blurRadius: 20.0,
// //                       color: Colors.grey,
// //                     ),
// //                   ]),
// //               padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
// //               child: SingleChildScrollView(
// //                 controller: scrollController,
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   mainAxisAlignment: MainAxisAlignment.start,
// //                   mainAxisSize: MainAxisSize.max,
// //                   children: [
// //                     actionsTitle,
// //                     actionsBuilder!(context, isLayoutHorizontal),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         )
// //       ],
// //     );
// //   }
// // }
// //
// //
// // /// [AppBar] action that shows a [Overlay] with log.
// // class LogActionWidget extends StatefulWidget {
// //   /// Construct the [LogActionWidget]
// //   const LogActionWidget({Key? key}) : super(key: key);
// //
// //   @override
// //   _LogActionWidgetState createState() => _LogActionWidgetState();
// // }
// //
// // class _LogActionWidgetState extends State<LogActionWidget> {
// //   bool _isOverlayShowed = false;
// //
// //   OverlayEntry? _overlayEntry;
// //
// //   @override
// //   void dispose() {
// //     _removeOverlay();
// //
// //     super.dispose();
// //   }
// //
// //   void _removeOverlay() {
// //     if (_overlayEntry != null) {
// //       _overlayEntry!.remove();
// //       _overlayEntry = null;
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return TextButton(
// //         onPressed: () {
// //           if (_isOverlayShowed) {
// //             _removeOverlay();
// //           } else {
// //             _overlayEntry = OverlayEntry(builder: (c) {
// //               return Positioned(
// //                 left: 0,
// //                 top: 0,
// //                 height: MediaQuery.of(context).size.height * 0.5,
// //                 width: MediaQuery.of(context).size.width,
// //                 child: Container(
// //                   color: Colors.black87,
// //                   child: SafeArea(
// //                     bottom: false,
// //                     child: Material(
// //                       color: Colors.transparent,
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         mainAxisSize: MainAxisSize.max,
// //                         children: [
// //                           Row(
// //                             mainAxisSize: MainAxisSize.max,
// //                             children: [
// //                               TextButton(
// //                                 onPressed: () {
// //                                   logSink.clear();
// //                                 },
// //                                 child: const Text(
// //                                   'Clear log',
// //                                   style: TextStyle(color: Colors.white),
// //                                 ),
// //                               ),
// //                               Expanded(
// //                                 child: Align(
// //                                   alignment: Alignment.topRight,
// //                                   child: IconButton(
// //                                       color: Colors.transparent,
// //                                       onPressed: () {
// //                                         _removeOverlay();
// //                                         _isOverlayShowed = !_isOverlayShowed;
// //                                       },
// //                                       icon: const Icon(
// //                                         Icons.close,
// //                                         color: Colors.white,
// //                                       )),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           const Expanded(
// //                             child: SingleChildScrollView(
// //                               child: LogWidget(),
// //                             ),
// //                           )
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             });
// //             Overlay.of(context).insert(_overlayEntry!);
// //           }
// //           _isOverlayShowed = !_isOverlayShowed;
// //           // setState(() {
// //
// //           // });
// //         },
// //         child: const Text(
// //           'Log',
// //           style: TextStyle(color: Colors.white),
// //         ));
// //   }
// // }
// //
// // /// LogWidget
// // class LogWidget extends StatefulWidget {
// //   /// Construct the [LogWidget]
// //   const LogWidget({
// //     Key? key,
// //     this.logSink,
// //     this.textStyle = const TextStyle(fontSize: 15, color: Colors.white),
// //   }) : super(key: key);
// //
// //   /// This [LogSink] is used to add log.
// //   final LogSink? logSink;
// //
// //   /// The text style of the log.
// //   final TextStyle textStyle;
// //
// //   @override
// //   _LogWidgetState createState() => _LogWidgetState();
// // }
// //
// // class _LogWidgetState extends State<LogWidget> {
// //   VoidCallback? _listener;
// //   late final LogSink _logSink;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     _logSink = widget.logSink ?? _defaultLogSink;
// //
// //     _listener ??= () {
// //       setState(() {});
// //     };
// //
// //     _logSink.addListener(_listener!);
// //   }
// //
// //   @override
// //   void dispose() {
// //     if (_listener != null) {
// //       _logSink.removeListener(_listener!);
// //       _listener = null;
// //     }
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Text(
// //       _logSink.output(),
// //       style: widget.textStyle,
// //     );
// //   }
// // }
// //
// // /// Class that add and update the log in [LogActionWidget]
// // class LogSink extends ChangeNotifier {
// //   final StringBuffer _stringBuffer = StringBuffer();
// //
// //   /// Add log to [LogActionWidget]
// //   void log(String log) {
// //     _stringBuffer.writeln(log);
// //     notifyListeners();
// //   }
// //
// //   /// Get all logs
// //   String output() {
// //     return _stringBuffer.toString();
// //   }
// //
// //   /// Clear logs
// //   void clear() {
// //     _stringBuffer.clear();
// //     notifyListeners();
// //   }
// // }
// //
// // final LogSink _defaultLogSink = LogSink();
// //
// // /// The global [LogSink]
// // LogSink get logSink => _defaultLogSink;
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// // // import 'dart:async';
// // //
// // // import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:permission_handler/permission_handler.dart';
// // //
// // // const appId = "4eced9c67dc7485e93d8edad4384a9ee";
// // // const token = "a052ccad6d1a42e28271b41dd18ae985";
// // // const channel = "test";
// // //
// // //
// // //
// // // class MyApp2 extends StatefulWidget {
// // //   const MyApp2({Key? key}) : super(key: key);
// // //
// // //   @override
// // //   State<MyApp2> createState() => _MyApp2State();
// // // }
// // //
// // // class _MyApp2State extends State<MyApp2> {
// // //   int? _remoteUid;
// // //   bool _localUserJoined = false;
// // //   late RtcEngine _engine;
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     initAgora();
// // //   }
// // //
// // //   Future<void> initAgora() async {
// // //     // retrieve permissions
// // //     await [Permission.microphone, Permission.camera].request();
// // //
// // //     //create the engine
// // //     _engine = createAgoraRtcEngine();
// // //     await _engine.initialize(const RtcEngineContext(
// // //       appId: appId,
// // //       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
// // //     ));
// // //
// // //     _engine.registerEventHandler(
// // //       RtcEngineEventHandler(
// // //         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
// // //           debugPrint("local user ${connection.localUid} joined");
// // //           setState(() {
// // //             _localUserJoined = true;
// // //           });
// // //         },
// // //         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
// // //           debugPrint("remote user $remoteUid joined");
// // //           setState(() {
// // //             _remoteUid = remoteUid;
// // //           });
// // //         },
// // //         onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
// // //           debugPrint("remote user $remoteUid left channel");
// // //           setState(() {
// // //             _remoteUid = null;
// // //           });
// // //         },
// // //         onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
// // //           debugPrint('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
// // //         },
// // //       ),
// // //     );
// // //
// // //     await _engine.setClientRole(role: ClientRoleType.clientRoleAudience);
// // //     await _engine.enableVideo();
// // //     await _engine.startPreview();
// // //
// // //     await _engine.joinChannel(
// // //       token: token,
// // //       channelId: channel,
// // //       uid: 0,
// // //       options: const ChannelMediaOptions(),
// // //     );
// // //   }
// // //
// // //   // Create UI with local view and remote view
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('Agora Video Call'),
// // //       ),
// // //       body: Stack(
// // //         children: [
// // //           Center(
// // //             child: _remoteVideo(),
// // //           ),
// // //           Align(
// // //             alignment: Alignment.topLeft,
// // //             child: SizedBox(
// // //               width: 100,
// // //               height: 150,
// // //               child: Center(
// // //                 child: _localUserJoined
// // //                     ? AgoraVideoView(
// // //                   controller: VideoViewController(
// // //                     rtcEngine: _engine,
// // //                     canvas: const VideoCanvas(uid: 0),
// // //                   ),
// // //                 )
// // //                     : const CircularProgressIndicator(),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   // Display remote user's video
// // //   Widget _remoteVideo() {
// // //     if (_remoteUid != null) {
// // //       return AgoraVideoView(
// // //         controller: VideoViewController.remote(
// // //           rtcEngine: _engine,
// // //           canvas: VideoCanvas(uid: _remoteUid),
// // //           connection: const RtcConnection(channelId: channel),
// // //         ),
// // //       );
// // //     } else {
// // //       return const Text(
// // //         'Please wait for remote user to join',
// // //         textAlign: TextAlign.center,
// // //       );
// // //     }
// // //   }
// // // }