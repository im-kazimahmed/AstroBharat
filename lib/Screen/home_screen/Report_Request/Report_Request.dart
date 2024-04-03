import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../HttpService/HttpService.dart';
import '../../../HttpService/model/Report_history_Model.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import 'Report_detail.dart';

class Report_Request extends StatefulWidget {
  String langType;
  Report_Request(this.langType);

  @override
  State<Report_Request> createState() => _Report_RequestState();
}

class _Report_RequestState extends State<Report_Request> {


  List<Data> report_history  = List.empty(growable: true);
  bool islode=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // report_history
    HttpService.report_history_api().then((value) {
      if (mounted) {
        setState(() {
          print(value['success']);
          if (value['success'] == true) {
            var values = ReportHistoryModel.fromJson(value).data;
            report_history.addAll(values);
            print(report_history.length);
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
          title: widget.langType=="English"?Text('Report Request',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)):Text('रिपोर्ट अनुरोध',
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
        body: islode?report_history.length==0?Container(
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
                child: ListView.builder(itemCount: report_history.length,itemBuilder: (context, index) {
                  return  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
                    child: InkWell(onTap:() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Report_view(widget.langType,report_history[index].id);
                      },));
                    },
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
                        child: Row(
                          children: [
                            Container(
                                height: height * 0.08,
                                width: width * 0.15,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorResources.WHITE,),
                                child: CachedNetworkImage(
                                  height: height * 0.08,
                                  width: width * 0.15,
                                  fit: BoxFit.fill,
                                  imageUrl:
                                  "${AppConstants.IMAGE_VIEW}${report_history[index].image}",
                                  placeholder: (context, url) =>
                                      Image.asset(Images.Astrobharat_logo),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(Images.Astrobharat_logo),
                                )
                            ),
                            Column(
                              children: [
                                Container(
                                  width: (width-width * 0.2)-40,
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text('${report_history[index].name}',
                                      style: poppinsMedium.copyWith(
                                          color: ColorResources.BLACK, fontSize: width*0.045)),
                                ),
                                Container(
                                  width: (width-width * 0.2)-40,
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 10,),
                                  child: Text('${report_history[index].created}',
                                      style: poppinsMedium.copyWith(
                                          color: ColorResources.BLACK, fontSize: width*0.045)),
                                ),
                              ],
                            ),
                          ],
                        ),
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
