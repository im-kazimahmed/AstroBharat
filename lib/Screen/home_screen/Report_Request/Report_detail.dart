import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../HttpService/HttpService.dart';
import '../../../HttpService/model/Report_view_history_Model.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';

class Report_view extends StatefulWidget {
  String langType; int id;
  Report_view(this.langType,this.id);


  @override
  State<Report_view> createState() => _Report_viewState();
}

class _Report_viewState extends State<Report_view> {



  List<Data> report_view_history  = List.empty(growable: true);
  bool islode=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    HttpService.report_view_history_api(widget.id).then((value) {
      if (mounted) {
        setState(() {
          print(value['success']);
          if (value['success'] == true) {
            var values = ReportViewHistoryModel.fromJson(value).data;
            report_view_history.add(values);
            print(report_view_history.length);
          }
          islode = true;
        });
      }
    });
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
          leading:IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_sharp,color: ColorResources.BLACK,)),
          title: widget.langType=="English"?Text('Report detail',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)):Text('रिपोर्ट विवरण',
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
        body: islode?report_view_history.length==0?Container(
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
        )
            :Container(
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
                child: ListView.builder(itemCount: report_view_history.length,itemBuilder: (context, index) {
                  return  Padding(
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
                              height: height * 0.15,
                              width: width * 0.27,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorResources.WHITE,),
                              child: CachedNetworkImage(
                                height: height * 0.08,
                                width: width * 0.15,
                                fit: BoxFit.fill,
                                imageUrl:
                                "${AppConstants.IMAGE_VIEW}${report_view_history[index].image}",
                                placeholder: (context, url) =>
                                    Image.asset(Images.Astrobharat_logo),
                                errorWidget: (context, url, error) =>
                                    Image.asset(Images.Astrobharat_logo),
                              )
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('User name :',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('${report_view_history[index].name}',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(height: 2,color: Colors.black12,),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('First name :',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('${report_view_history[index].fname}',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(height: 2,color: Colors.black12,),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('Last name:',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('${report_view_history[index].lname}',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(height: 2,color: Colors.black12,),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('Gendar:',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('${report_view_history[index].gender}',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(height: 2,color: Colors.black12,),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('Email id:',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('${report_view_history[index].email}',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(height: 2,color: Colors.black12,),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('Mobile no :',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('${report_view_history[index].moNo}',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(height: 2,color: Colors.black12,),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('Brith Date :',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('${report_view_history[index].bdayDate}',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(height: 2,color: Colors.black12,),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('Birth of time:',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('${report_view_history[index].timeBday}',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(height: 2,color: Colors.black12,),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('city :',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('${report_view_history[index].city}',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(height: 2,color: Colors.black12,),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('State :',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('${report_view_history[index].state}',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(height: 2,color: Colors.black12,),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('Country :',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('${report_view_history[index].country}',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(height: 2,color: Colors.black12,),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('Marital Status :',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('${report_view_history[index].maritalStatus}',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(height: 2,color: Colors.black12,),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('Comment :',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                              Container(
                                // width: (width/2)-40,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                child: Text('${report_view_history[index].comment}',
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK, fontSize: width*0.045)),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(height: 2,color: Colors.black12,),
                          SizedBox(height: 5,),
                        ],
                      ),
                    ),
                  );
                },),
              )

            ],
          ),
        ): Center(child: CircularProgressIndicator(),),
      ),
    );
  }

}
