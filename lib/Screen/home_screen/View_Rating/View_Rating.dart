import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../HttpService/HttpService.dart';
import '../../../HttpService/model/View_History_Model.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
class View_Rating extends StatefulWidget {
  String langType;
  View_Rating(this.langType);

  @override
  State<View_Rating> createState() => _View_RatingState();
}

class _View_RatingState extends State<View_Rating> {


  List<Data> view_history  = List.empty(growable: true);
  bool islode=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HttpService.view_history_api().then((value) {
      if (mounted) {
        setState(() {
          print(value['success']);
          if (value['success'] == true) {
            var values = ViewHistoryModel.fromJson(value).data;
            view_history.addAll(values);
            print(view_history.length);
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
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_sharp,
                color: ColorResources.BLACK,
              )),
          title:widget.langType=="English"? Text('My Reviews',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.05)):Text('मेरी समीक्षा',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.05)),
          backgroundColor: ColorResources.ORANGE_WHITE,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        body: islode? view_history.length==0?Container(
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
                child: ListView.builder(itemCount: view_history.length,itemBuilder: (context, index) {
                  return   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(elevation: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: height * 0.08,
                                  width: width * 0.15,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorResources.ORANGE,),
                                  child: CachedNetworkImage(
                                    height: height * 0.08,
                                    width: width * 0.15,
                                    fit: BoxFit.fill,
                                    imageUrl:
                                    "${AppConstants.IMAGE_VIEW}${view_history[index].userImage}",
                                    placeholder: (context, url) =>
                                        Image.asset(Images.Astrobharat_logo),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(Images.Astrobharat_logo),
                                  )
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: (width-width * 0.2)-50,
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only( top: 5),
                                    child: Text('${view_history[index].reviewDate}',
                                        style: poppinsMedium.copyWith(
                                            color: ColorResources.GREY, fontSize: width*0.03)),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text('${view_history[index].userName}',
                                        style: poppinsMedium.copyWith(
                                            color: ColorResources.GREY, fontSize: width*0.05)),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 5),
                                    child:   RatingBarIndicator(
                                      rating:double.parse(view_history[index].reviewRating.toString()),
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: width*0.06,
                                      direction: Axis.horizontal,
                                    ),
                                  ),

                                  Container(
                                    width: (width-width * 0.2)-50,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 10, bottom: 10),
                                    child: Text('${view_history[index].comments}',
                                        style: poppinsMedium.copyWith(
                                            color: ColorResources.BLACK, fontSize: width*0.04)),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },),
              )

            ],
          ),
        ):Center(child: CircularProgressIndicator(),),

      ),
    );
  }
}
