import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../HttpService/HttpService.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../home_screen.dart';

class UpdateFeesScreen extends StatefulWidget {
  List userDetails;
  String langType;
  UpdateFeesScreen(this.userDetails, this.langType, {super.key});

  @override
  State<UpdateFeesScreen> createState() => _UpdateFeesScreenState();
}

class _UpdateFeesScreenState extends State<UpdateFeesScreen>{
  TextEditingController individualFeeController = TextEditingController();
  TextEditingController groupFeeController = TextEditingController();
  FocusNode individualFeeNode = FocusNode();
  FocusNode groupFeeNode = FocusNode();
  String _isSelected  = "English";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    individualFeeController.text = widget.userDetails[0].liveStreamFees.toString();
    groupFeeController.text = widget.userDetails[0].appointmentFees.toString();
    _isSelected = widget.langType;
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading:IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_sharp,color: ColorResources.BLACK,)),
          title: _isSelected=="English"?Text('Update Fees',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)):Text('अद्यतन शुल्क',
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
        body:  Container(
          decoration: BoxDecoration(
            color: ColorResources.WHITE,
            image: const DecorationImage(
              image: AssetImage(Images.Splash_Screen),fit: BoxFit.fill,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(_isSelected == "English"
                    ? "Here you can update group session and individual session per hour fee which user will pay from their wallet in order to book an appointment or join live stream of yours calculated by hours"
                    : "यहां आप ग्रुप सेशन और इंडिविजुअल सेशन प्रति घंटे के शुल्क को अपडेट कर सकते हैं, जिसे यूजर अपॉइंटमेंट बुक करने के लिए या घंटों के हिसाब से आपकी लाइव स्ट्रीम में शामिल होने के लिए अपने वॉलेट से भुगतान करेंगे।",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(left: 25, top: 15, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isSelected == "English"
                          ? "Group Session Fee"
                          : "समूह सत्र शुल्क",
                      style: poppinsMedium.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 5,),
                    TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      maxLines: 1,
                      maxLength: 10,
                      style: poppinsMedium.copyWith(fontSize: 16),
                      controller: groupFeeController,
                      focusNode: groupFeeNode,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: _isSelected == "English"
                            ? "Enter appointment amount"
                            : "नियुक्ति राशि दर्ज करें",
                        suffixText: "₹",
                        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
                        hintStyle: poppinsMedium.copyWith(fontSize: 17),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black,),),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black,),),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.only(left: 25, top: 15, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        _isSelected == "English"
                            ? "Individual Session Fee"
                            : "व्यक्तिगत सत्र शुल्क",
                      style: poppinsMedium.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 5,),
                    TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      maxLines: 1,
                      maxLength: 10,
                      style: poppinsMedium.copyWith(fontSize: 16),
                      controller: individualFeeController,
                      focusNode: individualFeeNode,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: _isSelected == "English"
                            ? "Enter hourly fee amount"
                            : "प्रति घंटा शुल्क राशि दर्ज करें",
                        suffixText: "₹",
                        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
                        hintStyle: poppinsMedium.copyWith(fontSize: 17),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {

                      int groupFee = groupFeeController.text.isNotEmpty ? int.parse(groupFeeController.text):0;
                      int oneToOneFee = individualFeeController.text.isNotEmpty ? int.parse(individualFeeController.text):0;

                      if (groupFee == 0 && oneToOneFee == 0) {
                        _isSelected == "English"
                            ? AppConstants.show_toast("Please specify atleast one session type fee")
                            : AppConstants.show_toast("कृपया कम से कम एक सत्र प्रकार का शुल्क निर्दिष्ट करें");
                      } else {
                        EasyLoading.show();
                        HttpService.editFeesApi(
                          userId: widget.userDetails[0].id,
                          liveFees: oneToOneFee,
                          appointmentFees: groupFee,
                        ).then((value) {
                          if (mounted) {
                            setState(() {
                              print(value['success']);
                              if (value['success'] == "true"||value['success'] == true) {
                                EasyLoading.dismiss();
                                showDialogueBox("Success", "Fees successfully updated!", true);
                              }
                              else {
                                EasyLoading.dismiss();
                                showDialogueBox("Failed", "Failed to update try again", false);
                                print("failed to update");
                              }
                            });
                          }
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: height * 0.055,
                      width:  width * 0.55,
                      decoration: BoxDecoration(
                          color: ColorResources.ORANGE,
                          borderRadius: BorderRadius.circular(5)),
                      child: _isSelected == "English"
                          ? Text("UPDATE",
                          style:
                          poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE))
                          : Text("अपडेट करें",
                          style:
                          poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE)),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ),
    );
  }


  showDialogueBox(String title, body, bool isSuccess) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Stack(clipBehavior: Clip.none, children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: isSuccess ? MediaQuery.of(context).size.height * 0.60:
              MediaQuery.of(context).size.height * 0.35,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if(isSuccess)
                      Flexible(child: Image.asset("assets/image/success.png"))
                    else
                      const Flexible(child: Icon(Icons.clear, size: 50,)),
                    Text(title, textAlign: TextAlign.center, style: poppinsBold),
                    const SizedBox(height: 10),
                    Text(body, textAlign: TextAlign.center, style: poppinsBold),
                    const SizedBox(height: 20),
                    Row(children: [
                      Expanded(child: InkWell(
                        onTap: ()  => isSuccess ? Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> home()), (route) => false): Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: ColorResources.ORANGE,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('OK', style: poppinsBold.copyWith(color: ColorResources.WHITE,fontWeight: FontWeight.w500)),
                        ),
                      )),
                      const SizedBox(height: 30),
                    ]),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ]),
        );
      },
    );
  }

}
