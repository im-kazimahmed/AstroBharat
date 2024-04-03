import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../HttpService/HttpService.dart';
import '../../../HttpService/model/Get_bank_detail_model.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_textfield.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../home_screen.dart';
import 'Add_bank_details.dart';

class request_money extends StatefulWidget {
  String langType;
  int balance;
  request_money(this.langType,this.balance);


  @override
  State<request_money> createState() => _request_moneyState();
}

class _request_moneyState extends State<request_money> {
  List<Data> bank_detail  = List.empty(growable: true);
  TextEditingController Amount_noController =TextEditingController();
  FocusNode Amount_noFocus = FocusNode();
  bool islode=false;

  String bank_id="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    get_bank_detail();
  }
  get_bank_detail(){

    setState(() {
      bank_detail  = List.empty(growable: true);
      islode=false;
    });
    HttpService.get_bank_detail_api().then((value) {
      if (mounted) {
        setState(() {
          print(value['success']);
          if (value['success'] == true) {
            var values = GetBankDetailModel.fromJson(value).data;
            bank_detail.addAll(values);
            print(bank_detail.length);
          }
          islode = true;
        });
      }
    });
  }
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
          title: widget.langType=="English"? Text('request money',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)):Text('पैसे का अनुरोध',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)),
          backgroundColor: ColorResources.ORANGE_WHITE,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          actions: [
            IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return add_bank_details(widget.langType);
            },)).then((value) {
              get_bank_detail();
            });
            }, icon: Icon(Icons.add,color: ColorResources.BLACK,))
          ],
        ),
        body: islode?bank_detail.length==0?Container(
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
          child: Center(
              child: Container(
                height: height * 0.2,
                width: width*0.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Images.no_data))),
              )
          ),
        ):Container(
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
              Flexible(
                child: ListView.builder(itemCount: bank_detail.length,itemBuilder: (context, index) {
                  if(bank_detail[index].type=="Google pay"){
                    return   Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(0, 2)),
                            ],
                            borderRadius: BorderRadius.circular(05)),
                                    child: Column(
                                      children: [
                                        Container(
                                            color: ColorResources.EVENT_BG,
                                          child: Row(
                                            children: [
                                              Radio(
                                                  value:  "${bank_detail[index].id}",
                                                  groupValue:bank_id,
                                                  onChanged: (value){
                                                    setState(() {
                                                      bank_id=value.toString();
                                                    });
                                                    print(bank_id);
                                                  }
                                              ),
                                              Text('Google pay',
                                                  style: poppinsRegular.copyWith(
                                                      color: ColorResources.BLACK, fontSize: width*0.05)),
                                              Expanded(child: Container()),
                                              IconButton(onPressed: () {
                                                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                //   return add_bank_details(widget.langType);
                                                // },)).then((value) {
                                                //
                                                // });
                                              }, icon: Icon(Icons.close,color: ColorResources.RED,))
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all( 8),
                                              child: Text('Google pay No :',
                                                  style: poppinsRegular.copyWith(
                                                      color: ColorResources.BLACK, fontSize: width*0.045)),
                                            ),
                                            Container(
                                              margin: EdgeInsets.all( 8),
                                              child: Text('${bank_detail[index].googlePayNo}',
                                                  style: poppinsRegular.copyWith(
                                                      color: ColorResources.BLACK, fontSize: width*0.045)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }else if(bank_detail[index].type=="Paytm"){
                    return   Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(0, 2)),
                            ],
                            borderRadius: BorderRadius.circular(05)),
                        child: Column(
                          children: [
                            Container(
                              color: ColorResources.EVENT_BG,
                              child: Row(
                                children: [
                                  Radio(
                                      value:  "${bank_detail[index].id}",
                                      groupValue:bank_id,
                                      onChanged: (value){
                                        setState(() {
                                          bank_id=value.toString();
                                        });
                                        print(bank_id);
                                      }
                                  ),
                                  Text('Paytm',
                                      style: poppinsRegular.copyWith(
                                          color: ColorResources.BLACK, fontSize: width*0.05)),
                                  Expanded(child: Container()),
                                  IconButton(onPressed: () {
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    //   return add_bank_details(widget.langType);
                                    // },)).then((value) {
                                    //
                                    // });
                                  }, icon: Icon(Icons.close,color: ColorResources.RED,))
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all( 8),
                                  child: Text('Paytm No :',
                                      style: poppinsRegular.copyWith(
                                          color: ColorResources.BLACK, fontSize: width*0.045)),
                                ),
                                Container(
                                  margin: EdgeInsets.all( 8),
                                  child: Text('${bank_detail[index].paytmMoNo}',
                                      style: poppinsRegular.copyWith(
                                          color: ColorResources.BLACK, fontSize: width*0.045)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  else{
                    return   Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(0, 2)),
                            ],
                            borderRadius: BorderRadius.circular(05)),
                        child: Column(
                          children: [
                            Container(
                              color: ColorResources.EVENT_BG,
                              child: Row(
                                children: [
                                  Radio(
                                      value:  "${bank_detail[index].id}",
                                      groupValue:bank_id,
                                      onChanged: (value){
                                        setState(() {
                                          bank_id=value.toString();
                                        });
                                        print(bank_id);
                                      }
                                  ),
                                  Text('Bank',
                                      style: poppinsRegular.copyWith(
                                          color: ColorResources.BLACK, fontSize: width*0.05)),
                                  Expanded(child: Container()),
                                  IconButton(onPressed: () {
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    //   return add_bank_details(widget.langType);
                                    // },)).then((value) {
                                    //
                                    // });
                                  }, icon: Icon(Icons.close,color: ColorResources.RED,))
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all( 8),
                                  child: Text('Bank Name :',
                                      style: poppinsRegular.copyWith(
                                          color: ColorResources.BLACK, fontSize: width*0.045)),
                                ),
                                Container(
                                  margin: EdgeInsets.all( 8),
                                  child: Text('${bank_detail[index].accName}',
                                      style: poppinsRegular.copyWith(
                                          color: ColorResources.BLACK, fontSize: width*0.045)),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all( 8),
                                  child: Text('Bank Account number :',
                                      style: poppinsRegular.copyWith(
                                          color: ColorResources.BLACK, fontSize: width*0.045)),
                                ),

                                Flexible(
                                  child: Container(
                                    margin: EdgeInsets.all( 8),
                                    child: Text('${bank_detail[index].accNo}',
                                        style: poppinsRegular.copyWith(
                                            color: ColorResources.BLACK, fontSize: width*0.045)),
                                  ),
                                ),

                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all( 8),
                                  child: Text('ifsc Code:',
                                      style: poppinsRegular.copyWith(
                                          color: ColorResources.BLACK, fontSize: width*0.045)),
                                ),

                                Container(
                                  margin: EdgeInsets.all( 8),
                                  child: Text('${bank_detail[index].ifscCode}',
                                      style: poppinsRegular.copyWith(
                                          color: ColorResources.BLACK, fontSize: width*0.045)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(onTap: () {
                    if(bank_id==""){
                      widget.langType == "English"
                          ? AppConstants.show_toast("please Select withdrew  type")
                          : AppConstants.show_toast("कृपया वापस लिए गए प्रकार का चयन करें");
                    }
                    else{
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            contentPadding:
                            EdgeInsets.symmetric(
                                horizontal: width * 0.05,
                                vertical: height * 0.015),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0,right: 4),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text('Please Enter Request Amount',
                                          style: poppinsRegular.copyWith(
                                              color: ColorResources.BLACK, fontSize: width*0.04)),
                                    ),
                                    IconButton(onPressed: () {
                                    Navigator.pop(context);
                                    }, icon: Icon(Icons.close,color: ColorResources.RED,))
                                  ],
                                ),
                              ),
                              WhiteTextField(
                                controller:Amount_noController,
                                focusNode: Amount_noFocus,
                                nextNode: null,
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                hintText: 'Amount',
                                isPhoneNumber:true,
                              ),
                              SizedBox(height: 10,),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                InkWell(onTap: () {
                                  Navigator.pop(context);
                                },
                                  child: Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    color: ColorResources.BLACK,
                                    padding: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                                    child: Text('Cancel Request',textAlign: TextAlign.center,
                                        style: poppinsRegular.copyWith(
                                            color: ColorResources.WHITE, fontSize: width*0.035)),
                                  ),
                                ),
                                InkWell(onTap: () {
                                  setState(() {

                                  });
                                  if(Amount_noController.text.isEmpty){
                                    widget.langType == "English"
                                        ? AppConstants.show_toast("please enter Amount")
                                        : AppConstants.show_toast("कृपया राशि दर्ज करें");
                                  }else if(widget.balance<int.parse(Amount_noController.text.toString())){
                                    widget.langType == "English"
                                        ? AppConstants.show_toast("You bank Account has insufficient funds.")
                                        : AppConstants.show_toast("आपके बैंक खाते में अपर्याप्त धनराशि है।");
                                  }
                                  else if(int.parse(Amount_noController.text.toString())<250){
                                    widget.langType == "English"
                                        ? AppConstants.show_toast("minimun balance 250 up")
                                        : AppConstants.show_toast("मिनिमम बैलेंस 250 अप");
                                  }
                                  else{
                                    setState(() {
                                      islode=false;
                                      AppConstants.closeKeyboard();
                                      Navigator.pop(context);
                                    });
                                    HttpService.withdrawal_api(Amount_noController.text,bank_id).then((value) {
                                      if (mounted) {
                                        setState(() {
                                          print("///////////////////${value['success']}");
                                          if (value['success'] == true||value['success'] == "true") {
                                            print("object");
                                            Amount_noController.text="";
                                          Get.to(() => home());
                                          // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          //   return home();
                                          // },));
                                          }else{
                                            Amount_noController.text="";
                                            AppConstants.show_toast("${value['message']}");
                                          }
                                          islode = true;
                                        });
                                      }
                                    });
                                  }

                                },
                                  child: Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    color: ColorResources.BLACK,
                                    padding: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                                    child: Text('Send Request',textAlign: TextAlign.center,
                                        style: poppinsRegular.copyWith(
                                            color: ColorResources.WHITE, fontSize: width*0.035)),
                                  ),
                                ),
                              ],)
                            ],
                          );
                        },
                      );
                    }

                  },
                    child: Container(
                      color: ColorResources.BLACK,
                      width: width,
                      height: 50,
                      padding: EdgeInsets.all( 8),
                      child: Center(
                        child: Text(widget.langType=="English"?'Send Request':'अनुरोध भेजा',textAlign: TextAlign.center,
                            style: poppinsRegular.copyWith(
                                color: ColorResources.WHITE, fontSize: width*0.045)),
                      ),
                    ),
                  ),

                ],
              )
            ],
          ),
        ): Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
