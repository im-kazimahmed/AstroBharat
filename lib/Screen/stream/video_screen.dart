import 'dart:developer';
import 'dart:math' as math;
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:astrobharat/Screen/stream/util/sizer_custom/sizer.dart';
import 'package:astrobharat/Screen/stream/widgets/app_bar_stream.dart';
import 'package:astrobharat/Screen/stream/widgets/comment_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Chat/service/database_service.dart';
import '../../Controllers/stream_controller.dart';
import '../../Controllers/user_controller.dart';
import '../../HttpService/HttpService.dart';
import '../../utill/app_constants.dart';
import '../../utill/color_resources.dart';
import '../../utill/images.dart';
import '../../utill/styles.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoScreen extends StatefulWidget {
  final String selectedLanguage;
  const VideoScreen({super.key, required this.selectedLanguage});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> with SingleTickerProviderStateMixin {
  final LiveStreamController streamController = Get.find<LiveStreamController>();
  final UserController userController = Get.find<UserController>();
  FirebaseAuth auth = FirebaseAuth.instance;
  math.Random rand = math.Random();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey
  = GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold
  late Animation<double> _animation;
  List<int> remoteUids = [];

  @override
  void initState() {
    // TODO: implement initState
    streamController.animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _animation = Tween(begin: 0.0, end: 2.0).animate(streamController.animationController);

    if(streamController.isInitialized.value) {
      log("already initialized");
    } else {
      setupLiveStreaming();
    }
    super.initState();
  }

  setupLiveStreaming() async {
    await [Permission.microphone, Permission.camera].request();
    log("init State");
    HttpService.getAgoraTokenApi(streamController.channelName.value).then((value) => {
      streamController.token.value = value['token'],
      setupVideoSDKEngine(),
      print("printing token:${value['token']}")
    });
    streamController.isInitialized.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.purple.withOpacity(0.2),
        child: Obx(() => Stack(
          children: [
            _videoPanel(),
            // Obx(() => _videoPanel()),
            Padding(
              padding:
              EdgeInsets.symmetric(vertical: 16.sp, horizontal: 16.sp),
              child: AppBarStream(
                consultantDetails: userController.userDetails.first,
                onLeave: leave,
                isJoined: streamController.isJoined.value,
              ),
            ),
            if(streamController.newUserHasJoined.value)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.45, // Adjust the top position as needed
                left: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorResources.ORANGE,
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text(
                      streamController.newUserJoined.value,
                      style: const TextStyle(
                        color: ColorResources.WHITE,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            if(streamController.isJoined.value)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp)
                    .add(EdgeInsets.only(bottom: 10.sp)),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CommentWidgets(
                    groupId: streamController.chatGroupId.value,
                    groupName: streamController.chatGroupName.value,
                    userImage: userController.userDetails.first.image,
                    userName: userController.userDetails.first.fullName,
                  ),
                ),
              ),
            if(!streamController.isJoined.value)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.055,
                    width:  MediaQuery.of(context).size.width * 0.35,
                    decoration: BoxDecoration(
                      color: ColorResources.ORANGE,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InkWell(
                      onTap: streamController.isLoading.value ? null: () => {
                        streamController.isInitialized.value ? join(): showError()
                      },
                      child: streamController.isLoading.value ?
                      const CircularProgressIndicator():
                      FittedBox(
                        child: Text(
                          "Start Streaming",
                          style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        )),
      ),
    );
  }

  Widget _videoPanel() {
    if (!streamController.isJoined.value) {
      return streamController.isLoading.value ?
      const Center(child: CircularProgressIndicator()):
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              child: AnimatedBuilder(
                  animation: _animation,
                  builder: (BuildContext context, Widget? child) {
                    return ClipOval(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.red,
                            width: _animation.value * 2.50,
                          ),
                        ),
                        margin: const EdgeInsets.only(left: 10, top: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.width * 0.3,
                            fit: BoxFit.fill,
                            imageUrl: AppConstants.IMAGE_VIEW+userController.userDetails.first.image,
                            placeholder: (context, url) => Image.asset(Images.Astrobharat_logo),
                            errorWidget: (context, url, error) => Image.asset(Images.Astrobharat_logo),
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
            const SizedBox(height: 20,),
            const Text(
              'Waiting to start streaming',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    } else {
      streamController.isLoading.value = false;
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: streamController.agoraEngine,
          canvas: const VideoCanvas(uid: 0),
        ),
      );
    }
  }

  setupVideoSDKEngine() async {
    // retrieve or request camera and microphone permissions
    // await [Permission.microphone, Permission.camera].request();
    //create an instance of the Agora engine
    streamController.agoraEngine = createAgoraRtcEngine();
    await streamController.agoraEngine.initialize(const RtcEngineContext(
        appId: AppConstants.agoraAppId
    ));

    await streamController.agoraEngine.enableVideo();

    // Register the event handler
    streamController.agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          // showMessage("Local user uid:${connection.localUid} joined the channel");
          streamController.isJoined.value = true;
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          log("user joined");
          print("user joined");
          debugPrint("user joined");
          // showMessage("Remote user uid:$remoteUid joined the channel");
          // streamController.participantCount.value++;
          // HttpService.addParticipantIntoSession(userController.userDetails.first.id);
          streamController.remoteUids.add(remoteUid);
          remoteUids.add(remoteUid);
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          log("user left");
          print("user left");
          debugPrint("user left");
          // showMessage("Remote user uid:$remoteUid left the channel");
          // HttpService.removeParticipantFromSession(userController.userDetails.first.id);
          // streamController.participantCount.value--;
          streamController.remoteUids.remove(remoteUid);
          remoteUids.remove(remoteUid);
        },
      ),
    );

    streamController.isInitialized.value = true;
  }

  void join() async {
    createChatRoom();
    streamController.isLoading.value = true;
    // Set channel options
    ChannelMediaOptions options;

    // Set channel profile and client role
    options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      // channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    );
    await streamController.agoraEngine.startPreview();

    await streamController.agoraEngine.joinChannel(
      token: streamController.token.value,
      channelId: streamController.channelName.value,
      options: options,
      uid: streamController.uid.value,
    );

    streamController.isJoined.value = true;

    if(streamController.isSession.value) {
      streamController.selectedVideoProvider.value?.sessionType == "group" ? HttpService.update_live_status(1): null;
    } else {
      HttpService.update_live_status(1);
    }
    streamController.isLoading.value = false;

    await DatabaseService(uid: auth.currentUser?.uid).toggleGroupJoin(
      streamController.chatGroupId.value,
      userController.userDetails.first.fullName,
      streamController.chatGroupName.value,
    );
  }

  String getName(String r) {
    return r.substring(r.indexOf("_") + 1);
  }

  void leave() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      streamController.remoteUids.clear();
      streamController.isJoined.value = false;
      streamController.isLoading.value = false;
      streamController.agoraEngine.leaveChannel();
      streamController.isInitialized.value = false;
      streamController.selectedVideoProvider.value = null;
      streamController.animationController.dispose();
      // print("groupName: $groupName, groupId: $groupId ");
      // String groupId = prefs.getString("groupId")!;
    } catch (e) {
      //
    }

    try{
      log("exiting group");
      await DatabaseService(
        uid: FirebaseAuth.instance.currentUser!.uid).toggleGroupJoin(
        streamController.chatGroupId.value,
        userController.userDetails.first.fullName,
        streamController.chatGroupName.value,
      ).whenComplete(() => { log("group exited successfully") });
    } catch (e) {
      //
    }

    try{
      log("deleting group");
        await DatabaseService(
          uid: auth.currentUser?.uid).deleteGroup(
            streamController.chatGroupId.value,
        ).whenComplete(() => {
          log("group deleted successfully")
        });
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

  void createChatRoom() async {
    String newGroupName = rand.nextInt(1000000).toString();
    streamController.chatGroupName.value = newGroupName;
    await DatabaseService(uid: auth.currentUser?.uid).createGroup(
        userController.userDetails.first.fullName,
        auth.currentUser!.uid,
        streamController.chatGroupName.value,
    );
    await HttpService.createChatRoomApi(
      streamController.chatGroupName.value,
      streamController.chatGroupId.value,
      userController.userDetails.first.id,
    );
  }

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  showError() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(8.0),
        title: widget.selectedLanguage == "English" ? "Initialization error": "आरंभीकरण त्रुटि",
        content: Text(
          widget.selectedLanguage == "English" ?
          "Cannot initialize live streaming please try again or restart the app and try again":
          "लाइव स्ट्रीमिंग प्रारंभ नहीं की जा सकती, कृपया पुनः प्रयास करें या ऐप पुनः प्रारंभ करें और पुनः प्रयास करें",
          textAlign: TextAlign.center,
        ),
        actions: [
          InkWell(
            onTap: () => Get.back(),
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.055,
              width: 100,
              decoration: BoxDecoration(
                color: ColorResources.ORANGE,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(widget.selectedLanguage == "English"? "OK": "ठीक",
                style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
              ),
            ),
          ),
        ]
    );
  }

}
