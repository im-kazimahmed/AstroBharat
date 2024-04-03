import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../HttpService/HttpService.dart';
import '../../../HttpService/model/User_chat_view_Model.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';

class chat extends StatefulWidget {
  int id;

  String langType;
  String name;

  chat(this.id, this.langType, this.name);

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  List<Data> chat_list = List.empty(growable: true);
  bool loader = false, islode = false, message_loading = true;
  ScrollController listScrollController = ScrollController();

  // static double itemHeight=0.0;
  static double itemWidth = 0.0;
  TextEditingController _mesage_controller = TextEditingController();
  FocusNode _mesage_CodeFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_msg();
  }

  get_msg() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      load_message();
    });
  }

  load_message() {
    // HttpService.user_chat_view_api(widget.id).then((value) {
    //   if (mounted) {
    //     setState(() {
    //       // print(value['success']);
    //       message_loading = false;
    //       if (value['success'] == true) {
    //         chat_list = List.empty(growable: true);
    //         var values = UserChatViewModel.fromJson(value).data.reversed;
    //         chat_list.addAll(values);
    //         // print(chat_list.length);
    //       }
    //       get_msg();
    //       islode = true;
    //     });
    //   }
    // });
  }

  dateformatechamge(String date) {
    DateTime parseDate = new DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('d MMM yyyy HH:mm');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
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
              icon: Icon(
                Icons.arrow_back_sharp,
                color: ColorResources.BLACK,
              )),
          title: Text('${widget.name}',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width * 0.055)),
          backgroundColor: ColorResources.ORANGE_WHITE,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              color: ColorResources.WHITE,
              image: DecorationImage(
                  image: AssetImage(Images.Splash_Screen), fit: BoxFit.fill),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 1)),
              ],
              borderRadius: BorderRadius.circular(05)),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: height,
                      child: message_loading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: ColorResources.ORANGE,
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              controller: listScrollController,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(
                                  top: height * 0.01,
                                  bottom: 56,
                                  left: height * 0.025,
                                  right: height * 0.025),
                              physics: ClampingScrollPhysics(),
                              itemCount: chat_list.length,
                              reverse: true,
                              itemBuilder: (context, index) {
                                return chat_list[index].userType == 1
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 30),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 15),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: Text(
                                              chat_list[index].msg,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: ColorResources.WHITE),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.0016,
                                          ),
                                          Text(
                                              dateformatechamge(
                                                  chat_list[index].created),
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 30),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 15),
                                            decoration: BoxDecoration(
                                                color: ColorResources.ORANGE,
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: Text(
                                              chat_list[index].msg,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: ColorResources.BLACK),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.0016,
                                          ),
                                          Text(
                                              dateformatechamge(
                                                  chat_list[index].created),
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                        ],
                                      );
                              },
                            ),
                    ),
                    Container(
                      height: 60,
                      color: Colors.white,
                      padding: EdgeInsets.only(top: 2),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  // padding: EdgeInsets.symmetric(vertical: 2,),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: ColorResources.ORANGE)),
                                  child: TextFormField(
                                    controller: _mesage_controller,
                                    maxLines: 1,
                                    focusNode: _mesage_CodeFocus,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.send,
                                    onChanged: (value) {
                                      if (value[0] == " ") {
                                        _mesage_controller.text = "";
                                      }
                                    },
                                    style: poppinsRegular.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: ColorResources.BLACK),
                                    decoration: InputDecoration(
                                      fillColor: Colors.transparent,
                                      hintText: 'Type here maessage',
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 15),
                                      isDense: true,
                                      counterText: '',
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintStyle: poppinsRegular.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).hintColor),
                                      errorStyle: TextStyle(height: 1.5),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              loader
                                  ? Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: ColorResources.ORANGE,
                                        ),
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        print(
                                            "     =============${_mesage_controller.text}");
                                        if (_mesage_controller.text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            duration:
                                                Duration(milliseconds: 1500),
                                            content: Text(
                                                'Please Enter Message',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color:
                                                        ColorResources.BLACK)),
                                            backgroundColor:
                                                ColorResources.ORANGE,
                                          ));
                                        } else {
                                          Future.delayed(Duration.zero).then((value){
                                            send_msg(_mesage_controller.text);
                                            _mesage_controller.text='';
                                            FocusScope.of(context).unfocus();
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        Icons.send,
                                        color: Colors.black,
                                        size: 30,
                                      ))
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void send_msg(String msg) {
    setState(() {
      loader = true;
    });
    // HttpService.get_send_msg_api(msg, widget.id).then((value) {
    //   if (mounted) {
    //     setState(() {
    //       if (value['success'] == true) {
    //         setState(() {
    //           listScrollController
    //               .jumpTo(listScrollController.position.minScrollExtent);
    //           load_message();
    //         });
    //       }
    //       loader = false;
    //     });
    //   }
    // });
  }
}
