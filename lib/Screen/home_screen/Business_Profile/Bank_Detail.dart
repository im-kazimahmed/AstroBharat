import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/styles.dart';
import '../../account_detaile_screen/account_detaile_screen.dart';


class Bank_Detail extends StatefulWidget {
  List<dynamic> user_detali;
  String langType;
  Bank_Detail(this.user_detali,this.langType );


  @override
  State<Bank_Detail> createState() => _Bank_DetailState();
}

class _Bank_DetailState extends State<Bank_Detail> {
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
          leading:IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_sharp,color: ColorResources.BLACK,)),
          title: widget.langType=="English"?Text('Bank Detail',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)):Text('बैंक का विवरण',
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
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)), // changes position of shadow
                      ],
                      borderRadius: BorderRadius.circular(05)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.langType=="English"?Text('Pancard Number',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.03)):Text('पैन कार्ड नंबर',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.03)),
                      Text('${widget.user_detali[0].pancard}',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.045)),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)), // changes position of shadow
                      ],
                      borderRadius: BorderRadius.circular(05)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.langType=="English"? Text('Aadharcard Number',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.03)): Text('आधार कार्ड संख्या',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.03)),
                      Text('${widget.user_detali[0].aadharCard}',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.045)),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)), // changes position of shadow
                      ],
                      borderRadius: BorderRadius.circular(05)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.langType=="English"? Text('Bank Account Number',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.03)): Text('बैंक खाता संख्या',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.03)),
                      Text('${widget.user_detali[0].bankAddNumber}',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.045)),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)), // changes position of shadow
                      ],
                      borderRadius: BorderRadius.circular(05)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.langType=="English"?    Text('Account type',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.03)):Text('खाते का प्रकार',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.03)),
                      Text('${widget.user_detali[0].accType}',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.045)),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)), // changes position of shadow
                      ],
                      borderRadius: BorderRadius.circular(05)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.langType=="English"?  Text('IFSC Code',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.03)):Text('आईएफएससी कोड',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.03)),
                      Text('${widget.user_detali[0].IFSCCode}',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.045)),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)), // changes position of shadow
                      ],
                      borderRadius: BorderRadius.circular(05)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.langType=="English"?Text('Holder Name',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.03)):Text('धारक का नाम',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.03)),
                      Text('${widget.user_detali[0].accHolderName}',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.045)),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)), // changes position of shadow
                      ],
                      borderRadius: BorderRadius.circular(05)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.langType=="English"? Text('Bank Name',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.03)):Text('बैंक का नाम',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.03)),
                      Text('${widget.user_detali[0].bankName}',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK,  fontSize: width*0.045)),
                    ],
                  ),
                ),
                SizedBox(height: 50,),
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
                  child: InkWell(onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return account_detaile_page(false,widget.user_detali);
                    },));
                  },
                    child: widget.langType == "English"
                        ? Text("UPDATE",
                        style:
                        poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE))
                        : Text("अपडेट करें",
                        style:
                        poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
