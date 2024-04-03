import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../HttpService/HttpService.dart';
import '../../../HttpService/model/Waiting_list_Model.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';

class Waiting_List extends StatefulWidget {
  String langType;

  Waiting_List(this.langType);

  @override
  State<Waiting_List> createState() => _Waiting_ListState();
}

class _Waiting_ListState extends State<Waiting_List> {
  List<Data> waitinh_list = List.empty(growable: true);
  bool islode = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HttpService.waiting_list_api().then((value) {
      if (mounted) {
        setState(() {
          print(value['success']);
          if (value['success'] == true) {
            var values = WaitingListModel.fromJson(value).data;
            waitinh_list.addAll(values);
            print(waitinh_list.length);
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
          title: widget.langType == "English"
              ? Text('Waiting List',
                  style: poppinsMedium.copyWith(
                      color: ColorResources.BLACK, fontSize: width * 0.055))
              : Text('प्रतीक्षा सूची',
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
        body: islode
            ? waitinh_list.length == 0
                ? Container(
                    decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        image: DecorationImage(
                            image: AssetImage(Images.Splash_Screen),
                            fit: BoxFit.fill),
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
                      width: width * 0.5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Images.no_data))),
                    )),
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        image: DecorationImage(
                            image: AssetImage(Images.Splash_Screen),
                            fit: BoxFit.fill),
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
                          child: ListView.builder(
                            itemCount: waitinh_list.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
                                child: Card(
                                  elevation: 2,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              height: height * 0.08,
                                              width: width * 0.15,
                                              margin: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: ColorResources.WHITE,
                                              ),
                                              child: CachedNetworkImage(
                                                height: height * 0.08,
                                                width: width * 0.15,
                                                fit: BoxFit.fill,
                                                imageUrl:
                                                    "${AppConstants.IMAGE_VIEW}${waitinh_list[index].userImage}",
                                                placeholder: (context, url) =>
                                                    Image.asset(Images
                                                        .Astrobharat_logo),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(Images
                                                        .Astrobharat_logo),
                                              )),
                                          Column(
                                            children: [
                                              Container(
                                                // color: Colors.red,
                                                width:
                                                    (width - width * 0.30) - 40,
                                                alignment: Alignment.centerLeft,
                                                // margin: EdgeInsets.only(left: 10, bottom: 10),
                                                child: Text(
                                                    '${waitinh_list[index].userName}',
                                                    style:
                                                        poppinsRegular.copyWith(
                                                            color:
                                                                ColorResources
                                                                    .BLACK,
                                                            fontSize:
                                                                width * 0.035)),
                                              ),
                                              Container(
                                                // color: Colors.red,
                                                width:
                                                    (width - width * 0.30) - 40,
                                                alignment: Alignment.centerLeft,
                                                // margin: EdgeInsets.only(left: 10, bottom: 10),
                                                child: Text(
                                                    '${waitinh_list[index].created}',
                                                    style:
                                                        poppinsMedium.copyWith(
                                                            color:
                                                                ColorResources
                                                                    .BLACK,
                                                            fontSize:
                                                                width * 0.045)),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: height * 0.03,
                                            width: width * 0.07,
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        Images.msg))),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
