import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../HttpService/HttpService.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_textfield.dart';
import '../../../utill/styles.dart';

class add_bank_details extends StatefulWidget {
  String langType;
  add_bank_details(this.langType);


  @override
  State<add_bank_details> createState() => _add_bank_detailsState();
}

class _add_bank_detailsState extends State<add_bank_details> {
  TextEditingController Google_noController =TextEditingController();
  FocusNode Google_noFocus = FocusNode();
  TextEditingController Paytm_noController =TextEditingController();
  FocusNode Paytm_noFocus = FocusNode();
  TextEditingController bank_acc_number_noController =TextEditingController();
  FocusNode  bank_acc_number_noFocus = FocusNode();
  TextEditingController  bank_acc_name_noController =TextEditingController();
  FocusNode bank_acc_name_noFocus = FocusNode();
  TextEditingController ifsc_code_noController =TextEditingController();
  FocusNode ifsc_code_noFocus = FocusNode();
  List<String> _add_details_list = ['Google pay', 'Paytm', 'Bank details'];
  String ? selectedItem;
  bool  loader = false;


  void add_google_detail(String selectedItem, String google) {
    setState(() {
      loader = true;
    });
    HttpService.add_details_api(selectedItem,google,"","","","").then((value) {
      if (mounted) {
        setState(() {
          if (value['success'] == true||value['success'] == "true") {
            setState(() {
              Navigator.pop(context);
            });
          }
          loader = false;
        });
      }
    });
  }

  void add_patym_detail(String selectedItem, String patym) {
    setState(() {
      loader = true;
    });
    HttpService.add_details_api(selectedItem, "", patym, "", "", "").then((value) {
      if (mounted) {
        setState(() {
          if (value['success'] == true||value['success'] == "true") {
            setState(() {
              Navigator.pop(context);
            });
          }
          loader = false;
        });
      }
    });
  }

  void add_bank_detail(String selectedItem, String bank_name , String bank_number, String ifsc_code) {
    setState(() {
      loader = true;
    });
    HttpService.add_details_api(selectedItem,"","",bank_name,bank_number,ifsc_code).then((value) {
      if (mounted) {
        setState(() {
          if (value['success'] == true||value['success'] == "true") {
            setState(() {
              Navigator.pop(context);
            });
          }
          loader = false;
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
          title: widget.langType=="English"? Text('add details',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)):Text('विवरण जोड़ें',
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
        body:loader?Center(child: CircularProgressIndicator(),):Column(children: [
          Flexible(child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: height*0.02),
            child: Column(
              children: [
                SizedBox(height: width*0.04,),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius:BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: ColorResources.BLACK.withOpacity(0.25),
                            blurRadius: 5
                        )
                      ]
                  ),
                  margin: EdgeInsets.only(bottom: 9,left: 3,right: 3),
                  child: DropdownButtonHideUnderline(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: DropdownButton(
                        hint: Text(
                          widget.langType=="English"?  "Select Payment type":"भुगतान प्रकार का चयन करें",
                          style: poppinsBold.copyWith(
                              color: Colors.black38),
                        ),
                        // Not necessary for Option 1
                        value: selectedItem,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                          size: 40,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedItem = newValue as String;
                          });
                        },
                        items: _add_details_list.map((location) {
                          return DropdownMenuItem(
                            child: new Text(
                              location,
                              style: poppinsBold.copyWith(fontSize: 17,
                                  color: Colors.black38),
                            ),
                            value: location,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                selectedItem=="Google pay"?
                Column(children: [
                  CustomTextTitle(title: "Google pay No"),
                  WhiteTextField(
                    controller:Google_noController,
                    focusNode: Google_noFocus,
                    nextNode: null,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    hintText: 'Google pay number',
                    isPhoneNumber:true,
                  ),
                  SizedBox(height: 10,),
                ],)
                    :
                selectedItem=="Paytm"?Column(children: [
                  CustomTextTitle(title: "Paytm No"),
                  WhiteTextField(
                    controller:Paytm_noController,
                    focusNode: Paytm_noFocus,
                    nextNode: null,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    hintText: 'Paytm number',
                    isPhoneNumber: true,
                  ),
                  SizedBox(height: 10,),
                ],)
                    :
                selectedItem=="Bank details"?Column(children: [
                  CustomTextTitle(title: "Bank details"),
                  SizedBox(height: 10,),
                  WhiteTextField(
                    controller:bank_acc_name_noController,
                    focusNode: bank_acc_name_noFocus,
                    nextNode: bank_acc_number_noFocus,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    hintText: 'Bank account name',
                    isPhoneNumber: false,
                  ),
                  Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorResources.WHITE,
                  borderRadius:BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: ColorResources.BLACK.withOpacity(0.25),
                        blurRadius: 5
                    )
                  ]
              ),
              margin: EdgeInsets.only(bottom: 9,left: 3,right: 3),
              child: TextFormField(
                controller: bank_acc_number_noController,
                maxLength: 12,
                focusNode: bank_acc_number_noFocus,
                keyboardType:  TextInputType.number,
                textInputAction:TextInputAction.next,
                onFieldSubmitted: (v) {
                  FocusScope.of(context).requestFocus(ifsc_code_noFocus);
                },
                style: poppinsMedium.copyWith(color: ColorResources.BLACK),
                inputFormatters: [ FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText:'Bank account number',
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
                  isDense: true,
                  counterText: '',
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  hintStyle: poppinsMedium.copyWith(color: Theme.of(context).hintColor),
                  errorStyle: TextStyle(height: 1.5),
                  border: InputBorder.none,
                ),
              ),
            ),
                  WhiteTextField(
                    controller:ifsc_code_noController,
                    focusNode: ifsc_code_noFocus,
                    nextNode: null,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    hintText: 'IFSC code',
                    isPhoneNumber: false,
                  ),
                ],)
                    :
                Column(children: [
                  SizedBox(height: 10,),
                ],),
                Container(
                  margin: EdgeInsets.only(
                      top: height * 0.030,
                      left: width * 0.24,
                      right: width * 0.24),
                  padding: EdgeInsets.only(
                      top: height * 0.015, bottom: height * 0.015),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorResources.ORANGE,
                  ),
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      print(selectedItem);
                      if(selectedItem==null) {
                        widget.langType == "English" ?  AppConstants.show_toast("Select Payment type") : AppConstants.show_toast("भुगतान का प्रकार चुने");
                        }
                      else if(selectedItem=="Google pay"){
                        if(Google_noController.text.isEmpty) {
                          widget.langType == "English" ?  AppConstants.show_toast("Enter in Valid  Details") : AppConstants.show_toast("मान्य विवरण दर्ज करें");
                        }
                        else if(Google_noController.text.length!=10) {
                          widget.langType == "English" ?  AppConstants.show_toast("Please Enter Valid Google pay Number") : AppConstants.show_toast("कृपया मान्य Google पे नंबर दर्ज करें");
                        }
                        else{
                          add_google_detail(selectedItem!,Google_noController.text);
                        }
                      }
                      else if( selectedItem=="Paytm"){
                        if(Paytm_noController.text.isEmpty) {
                          widget.langType == "English" ?  AppConstants.show_toast("Enter in Valid  Details") : AppConstants.show_toast("मान्य विवरण दर्ज करें");
                        }
                        else if(Paytm_noController.text.length!=10) {
                          widget.langType == "English" ?  AppConstants.show_toast("Please Enter Valid Paytm Number") : AppConstants.show_toast("कृपया मान्य पेटीएम नंबर दर्ज करें");
                        }
                        else{
                          add_patym_detail(selectedItem!,Paytm_noController.text);
                        }
                      }
                      else if (selectedItem=="Bank details"){
                        if(bank_acc_name_noController.text.isEmpty){
                          widget.langType == "English" ?  AppConstants.show_toast("Enter in Valid  bank Account name") : AppConstants.show_toast("मान्य बैंक खाता नाम दर्ज करें");
                        }
                        else if (bank_acc_number_noController.text.isEmpty){
                          widget.langType == "English" ?  AppConstants.show_toast("Enter in Valid bank number") : AppConstants.show_toast("मान्य बैंक खाता संख्या दर्ज करें");
                        }
                        else if(bank_acc_number_noController.text.length!=12){
                          widget.langType == "English" ?  AppConstants.show_toast("Enter in Valid bank Account number") : AppConstants.show_toast("मान्य बैंक खाता विवरण दर्ज करें");
                        }
                        else if(ifsc_code_noController.text.isEmpty){
                          widget.langType == "English" ?  AppConstants.show_toast("Enter in Valid ifsc code") : AppConstants.show_toast("वैध आईएफएससी कोड में दर्ज करें");
                        }
                        else{
                          add_bank_detail(selectedItem!,bank_acc_name_noController.text,bank_acc_number_noController.text,ifsc_code_noController.text);
                        }
                      }

                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return request_money(widget.langType);
                      // },));
                    },
                    child: Text(widget.langType=="English"?'detalis add':'डेटालिस जोड़ें',
                        style: poppinsMedium.copyWith(
                            color: ColorResources.BLACK, fontSize: width*0.04)),
                  ),
                ),
              ],
            ),
          ))
        ],)
      ),
    );
  }

}
