import 'package:astrobharat/HttpService/model/Question_History_Model.dart';
import 'package:astrobharat/Screen/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../HttpService/HttpService.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';

class All_Answer_List extends StatefulWidget {
  String langType; List<FreeQueAnswerList> freeQueAnswerList;
  String question;
  int Id;
  All_Answer_List(this.langType,this.freeQueAnswerList, this.question,this.Id );


  @override
  State<All_Answer_List> createState() => _All_Answer_ListState();
}

class _All_Answer_ListState extends State<All_Answer_List> {
  TextEditingController my_answer_controller=TextEditingController();

  @override
  Widget build(BuildContext context)  {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final st = MediaQuery.of(context).padding.top;
    final tbody = height - st;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading:IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_sharp,color: ColorResources.BLACK,)),
          title:widget.langType=="English"? Text('All Answer',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)):Text('सभी उत्तर',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)),
          backgroundColor: ColorResources.ORANGE_WHITE,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        body:  widget.freeQueAnswerList.length==0?Container(
          decoration: BoxDecoration(
              color: ColorResources.WHITE,
              image: DecorationImage(
                  image: AssetImage(Images.Splash_Screen),fit: BoxFit.fill
              ),
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
              Container(
                // color: Colors.red,
                width: width ,
                // alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 10, bottom: 2,right: 10,top: 5),
                child: Text('${widget.question}',
                    style: poppinsMedium.copyWith(
                        color: ColorResources.BLACK,
                        fontSize: width * 0.05)),
              ),
              InkWell(
                onTap: () {
                  get_answer(height);
                },
                child: Container(
                  color: ColorResources.BLACK,
                  width: width ,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 10, bottom: 2,right: 10,top: 5),
                  padding: EdgeInsets.all( 5),
                  child: Text(widget.langType=="English"? 'Repiy it':'इसका प्रतिकार करें',
                      style: poppinsMedium.copyWith(
                          color: ColorResources.WHITE,
                          fontSize: width * 0.04)),
                ),
              ),
            ],
          ),
        ): Container(
          decoration: BoxDecoration(
              color: ColorResources.WHITE,
              image: DecorationImage(
                  image: AssetImage(Images.Splash_Screen),fit: BoxFit.fill
              ),
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
              Container(
                // color: Colors.red,
                width: width ,
                // alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 10, bottom: 2,right: 10,top: 5),
                child: Text('${widget.question}',
                    style: poppinsMedium.copyWith(
                        color: ColorResources.BLACK,
                        fontSize: width * 0.05)),
              ),
              InkWell(
                onTap: () {
                  get_answer(height);
                },
                child: Container(
                  color: ColorResources.BLACK,
                  width: width ,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 10, bottom: 2,right: 10,top: 5),
                  padding: EdgeInsets.all( 5),
                  child: Text(widget.langType=="English"? 'Repiy it':'इसका प्रतिकार करें',
                      style: poppinsMedium.copyWith(
                          color: ColorResources.WHITE,
                          fontSize: width * 0.04)),
                ),
              ),
              SizedBox(height: 5,),
              Flexible(
                child: ListView.builder(itemCount: widget.freeQueAnswerList.length,itemBuilder: (context, index) {
                  return   Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      // color: Colors.red,
                                      width: width - 80,
                                      // alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: 10, bottom: 2,right: 10),
                                      child: Text('${widget.freeQueAnswerList[index].astrologerName}',
                                          style: poppinsMedium.copyWith(
                                              color: ColorResources.BLACK,
                                              fontSize: width * 0.05)),
                                    ),
                                    widget.freeQueAnswerList[index].isMe==1?
                                    IconButton(onPressed: () {
                                      EasyLoading.show();
                                      get_answer_delete_api(widget.freeQueAnswerList[index].id);
                                    }, icon: Icon(Icons.delete_forever,color: ColorResources.RED,)):SizedBox(),
                                  ],
                                ),
                                Container(

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: height * 0.035,
                                        width: width * 0.06,
                                        // color: Colors.cyan,
                                        margin: EdgeInsets.only(right: 10,left: 10),
                                        child: Image.asset(Images.msg,color: ColorResources.ORANGE,),
                                      ),
                                      Container(
                                        // color: Colors.red,
                                        width: (width -width * 0.06) - 44,
                                        alignment: Alignment.topLeft,
                                        // margin: EdgeInsets.only(left: 10, bottom: 10),
                                        child: Text('${widget.freeQueAnswerList[index].answer}',
                                            style: poppinsMedium.copyWith(
                                                color: ColorResources.GREY,
                                                fontSize: width * 0.04)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // color: Colors.red,
                                  width: width - 20,
                                  alignment: Alignment.centerRight,
                                  // margin: EdgeInsets.only(left: 10, bottom: 10),
                                  child: Text('${widget.freeQueAnswerList[index].created}',
                                      style: poppinsMedium.copyWith(
                                          color: ColorResources.GREY,
                                          fontSize: width * 0.035)),
                                ),
                              ],
                            ),

                          ],
                        )
                      ],
                    ),
                  )
                  ;
                },),
              )
            ],
          ),
        )
      ),
    );
  }

  void get_answer(double height) {
    showDialog(
        barrierDismissible:
        false,
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              Container(
                decoration:
                BoxDecoration(
                    color:
                    Colors.white),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: ColorResources.ORANGE),
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.all(15),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 4,
                              style: poppinsRegular.copyWith(fontSize: 16),
                              controller: my_answer_controller,
                              onChanged: (value) {
                                if(value[0]==" ")
                                  {
                                    setState(() {
                                      my_answer_controller.text="";
                                    });
                                  }
                              },
                              decoration: InputDecoration(
                                counterText: "",
                                hintText: "Write Your Answer",
                                contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
                                hintStyle: poppinsRegular.copyWith(fontSize: 16),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: Colors.transparent)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: Colors.transparent)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  Navigator.pop(context);
                                  my_answer_controller.text="";
                                });
                              },
                              child: Container(
                                height: height * 0.05,
                                decoration: BoxDecoration(
                                    color: ColorResources.ORANGE,
                                    borderRadius: BorderRadius.circular(3)),
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 15, bottom: 10, top: 10),
                                child: Text("Close", style: poppinsRegular.copyWith(fontSize: 18, color: ColorResources.WHITE)),
                              )),
                        ),
                        Expanded(
                          child: InkWell(
                          onTap: () {
                            if(my_answer_controller.text.isEmpty)
                              {
                                setState(() {
                                  widget.langType == "English" ? AppConstants.show_toast("Please Enter Answer") : AppConstants.show_toast("कृपया उत्तर दर्ज करें");
                                });
                              }
                            else{
                              setState(() {
                                EasyLoading.show();
                                AppConstants.closeKeyboard();
                                Navigator.pop(context);
                                get_answer_call_api(widget.Id,my_answer_controller.text);

                              });
                            }
                          },
                              child: Container(
                                height: height * 0.05,
                                decoration: BoxDecoration(
                                    color: ColorResources.WHITE,
                                    borderRadius: BorderRadius.circular(3)),
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(right: 15, bottom: 10, top: 10),
                                child: Text("Submit", style: poppinsRegular.copyWith(fontSize: 18, color: Colors.black)),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        },
    );
  }

  void get_answer_call_api(int Id, String text) {
    print("     :::::::::::$text");
    HttpService.get_answer_api(Id,text).then((value) {
      if (mounted) {
        setState(() {
          print(value['success']);
          if (value['success'] == true||value['success'] == 'true') {

            EasyLoading.dismiss();
            my_answer_controller.text="";
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return home();
            },));
          }
          else{
            my_answer_controller.text="";
            EasyLoading.dismiss();
            widget.langType == "English" ? AppConstants.show_toast("Answer is already given") : AppConstants.show_toast("उत्तर पहले ही दिया जा चुका है");
          }
        });
      }
    });
  }

  void get_answer_delete_api(int id) {
    HttpService.get_answer_delete_api(id).then((value) {
      if (mounted) {
        setState(() {
          print(value['success']);
          if (value['success'] == true||value['success'] == 'true'||value['success'] == "true") {

            EasyLoading.dismiss();

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return home();
            },));
          }
          else{
            my_answer_controller.text="";
            EasyLoading.dismiss();
            widget.langType == "English" ? AppConstants.show_toast("Answer is already given") : AppConstants.show_toast("उत्तर पहले ही दिया जा चुका है");
          }
        });
      }
    });
  }
}
