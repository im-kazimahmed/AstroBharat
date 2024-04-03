// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:zego_zimkit/compnents/conversation_list.dart';
// // import 'package:zego_zimkit/pages/message_list_page.dart';
// import '../../../HttpService/model/Chat_History_Model.dart';
// import '../../../utill/color_resources.dart';
// import '../../../utill/styles.dart';
//
// class Chat_History extends StatefulWidget {
//   String langType;
//   Chat_History(this.langType);
//
//   @override
//   State<Chat_History> createState() => _Chat_HistoryState();
// }
//
// class _Chat_HistoryState extends State<Chat_History> {
//    List<Data>  chat_history  = List.empty(growable: true);
//   // bool islode=false;
//   bool islode=true;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // HttpService.chat_history_api().then((value) {
//     //   if (mounted) {
//     //     setState(() {
//     //       print(value['success']);
//     //       if (value['success'] == true) {
//     //         var values = ChatHistoryModel.fromJson(value).data;
//     //         chat_history.addAll(values);
//     //         print(chat_history.length);
//     //       }
//     //       islode = true;
//     //     });
//     //   }
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     final st = MediaQuery.of(context).padding.top;
//     final tbody = height - st;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           leading:IconButton(onPressed: () {
//             Navigator.pop(context);
//           }, icon: Icon(Icons.arrow_back_sharp,color: ColorResources.BLACK,)),
//           title: widget.langType=="English"? Text('Chat History',
//               style: poppinsMedium.copyWith(
//                   color: ColorResources.BLACK, fontSize: width*0.055)):Text('संवाद का इतिहास',
//               style: poppinsMedium.copyWith(
//                   color: ColorResources.BLACK, fontSize: width*0.055)),
//           backgroundColor: ColorResources.ORANGE_WHITE,
//           elevation: 2,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(15),
//             ),
//           ),
//         ),
//         body:ZIMKitConversationListView(
//           onPressed: (context, conversation, defaultAction) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) {
//                   return ZIMKitMessageListPage(
//                     conversationID: conversation.id,
//                     conversationType: conversation.type,
//                   );
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
// // islode? chat_history.length==0?Container(
// //   decoration: BoxDecoration(
// //       color: ColorResources.WHITE,
// //       image:const DecorationImage(
// //           image: AssetImage(Images.Splash_Screen),fit: BoxFit.fill
// //       ),
// //       boxShadow: [
// //         BoxShadow(
// //             color: Colors.grey.withOpacity(0.2),
// //             spreadRadius: 1,
// //             blurRadius: 7,
// //             offset: Offset(0, 1)),
// //       ],
// //       borderRadius: BorderRadius.circular(05)),
// //   child: Center(
// //       child: Container(
// //         height: height * 0.2,
// //         width: width*0.5,
// //         decoration:const BoxDecoration(
// //             image: DecorationImage(
// //                 image: AssetImage(Images.no_data))),
// //       )
// //   ),
// // ):Container(
// //   decoration: BoxDecoration(
// //       color: ColorResources.WHITE,
// //       image: const DecorationImage(
// //           image: AssetImage(Images.Splash_Screen),fit: BoxFit.fill
// //       ),
// //       boxShadow: [
// //         BoxShadow(
// //             color: Colors.grey.withOpacity(0.2),
// //             spreadRadius: 1,
// //             blurRadius: 7,
// //             offset: Offset(0, 1)),
// //       ],
// //       borderRadius: BorderRadius.circular(05)),
// //   child: Column(
// //     children: [
// //       Flexible(
// //         child: ListView.builder(itemCount: chat_history.length,itemBuilder: (context, index) {
// //           return   Padding(
// //             padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
// //             child: InkWell(
// //               onTap: () {
// //                 Navigator.push(context, MaterialPageRoute(builder: (context) {
// //                   return chat(chat_history[index].id,widget.langType,chat_history[index].name);
// //                 },));
// //               },
// //               child: Container(
// //                 decoration: BoxDecoration(
// //                     color: ColorResources.WHITE,
// //                     boxShadow: [
// //                       BoxShadow(
// //                           color: Colors.grey.withOpacity(0.2),
// //                           spreadRadius: 1,
// //                           blurRadius: 7,
// //                           offset:const Offset(0, 2)),
// //                     ],
// //                     borderRadius: BorderRadius.circular(05)),
// //                 child: Row(
// //                   children: [
// //                     Container(
// //                         height: height * 0.08,
// //                         width: width * 0.15,
// //                         margin: EdgeInsets.all(10),
// //                         decoration: BoxDecoration(
// //                           borderRadius: BorderRadius.circular(10),
// //                           color: ColorResources.ORANGE,),
// //                         child: CachedNetworkImage(
// //                           height: height * 0.08,
// //                           width: width * 0.15,
// //                           fit: BoxFit.fill,
// //                           imageUrl:
// //                           "${AppConstants.IMAGE_VIEW}${chat_history[index].image}",
// //                           placeholder: (context, url) =>
// //                               Image.asset(Images.Astrobharat_logo),
// //                           errorWidget: (context, url, error) =>
// //                               Image.asset(Images.Astrobharat_logo),
// //                         )
// //                     ),
// //                     Column(
// //                       children: [
// //                         Container(
// //                           width: (width-width * 0.2)-40,
// //                           alignment: Alignment.centerLeft,
// //                           margin:const EdgeInsets.only(left: 10),
// //                           child: Text( '${chat_history[index].name}',
// //                               style: poppinsMedium.copyWith(
// //                                   color: ColorResources.BLACK, fontSize: width*0.045)),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           );
// //         },),
// //       )
// //
// //     ],
// //   ),
// // ):Center(child: CircularProgressIndicator(),),