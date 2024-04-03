import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../../address_screen/address_screen.dart';

class Change_Location extends StatefulWidget {
  List<dynamic> user_detali;
  String langType;
  Change_Location(this.user_detali, this.langType);

  @override
  State<Change_Location> createState() => _Change_LocationState();
}

class _Change_LocationState extends State<Change_Location> {
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
          title: widget.langType=="English"?Text('Change Location',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)):Text('स्थान बदलें',
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
                      widget.langType=="English"? Text('Select Experirnce',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.030)):Text('अनुभव का चयन करें',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.030)),
                      Text('${widget.user_detali[0].experience}',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.045)),
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
                      widget.langType=="English"? Text('Country',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.030)):Text('देश',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.030)),
                      Text('${widget.user_detali[0].countryName}',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.045)),
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
                      widget.langType=="English"?  Text('State',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.030)):Text('राज्य',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.030)),
                      Text('${widget.user_detali[0].stateName}',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.045)),
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
                      widget.langType=="English"?Text('City',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.030)):Text('शहर',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.030)),
                      Text('${widget.user_detali[0].cityName}',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.045)),
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
                      widget.langType=="English"? Text('Address',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.030)):Text('पता',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.030)),
                      Text('${widget.user_detali[0].address}',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.045)),
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
                      widget.langType=="English"?Text('Pincode',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.030)):Text('पिन कोड',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.030)),
                      Text('${widget.user_detali[0].pincode}',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.045)),
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
                      widget.langType=="English"?  Text('Highest Degree',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.030)): Text('उच्चतम उपाधि',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.030)),
                      Text('${widget.user_detali[0].highestDegree}',
                          style: poppinsMedium.copyWith(
                              color: ColorResources.BLACK, fontSize: width*0.045)),
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
                      return address_page(false,widget.user_detali);
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
