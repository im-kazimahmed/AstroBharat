// // Flutter imports:
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// // Package imports:
// import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
// import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
//
// import '../../HttpService/HttpService.dart';
//
// class LivePage extends StatelessWidget {
//   final String liveID;
//   final bool isHost;
//   final String name;
//
//    LivePage({
//     Key? key,
//     required this.liveID,
//     this.isHost = false, required this.name,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: ZegoUIKitPrebuiltLiveStreaming(
//         appID: 1238742016 /*input your AppID*/,
//         appSign: '0d448a1ea8399aadd3ac4c963e8e7770d775edc068d0a3ee071499371c15eeca' /*input your AppSign*/,
//         userID: liveID,
//         userName: "id_$liveID",
//         liveID: liveID,
//         config: isHost
//             ? ZegoUIKitPrebuiltLiveStreamingConfig.host(
//           plugins: [ZegoUIKitSignalingPlugin()],
//         )
//             : ZegoUIKitPrebuiltLiveStreamingConfig.audience(
//           plugins: [ZegoUIKitSignalingPlugin()],
//         )
//           ..onLeaveConfirmation = isHost? (BuildContext context) async {
//             return await showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   backgroundColor: Colors.blue[900]!.withOpacity(0.9),
//                   title: const Text("This is your custom dialog",
//                       style: TextStyle(color: Colors.white70)),
//                   content: const Text(
//                       "You can customize this dialog as you like",
//                       style: TextStyle(color: Colors.white70)),
//                   actions: [
//                     ElevatedButton(
//                       child: const Text("Cancel",
//                           style: TextStyle(color: Colors.white70)),
//                       onPressed: () => Navigator.of(context).pop(false),
//                     ),
//                     ElevatedButton(
//                       child: const Text("Exit"),
//                       onPressed: () {
//                         EasyLoading.show();
//                         HttpService.update_live_status(0).then((value) {
//                           EasyLoading.dismiss();
//                           Navigator.of(context).pop(true);
//                         });
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           }:null
//           ..startLiveButtonBuilder=isHost?(context, startLive) {
//            return ElevatedButton(onPressed: () {
//              EasyLoading.show();
//              HttpService.update_live_status(1).then((value) {
//                EasyLoading.dismiss();
//                startLive();
//              });
//            }, child: Text("START"));
//           } :null
//
//       ),
//     );
//   }
// }
