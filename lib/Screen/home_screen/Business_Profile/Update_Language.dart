import 'package:astrobharat/Screen/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../HttpService/HttpService.dart';
import '../../../HttpService/model/Language_Model.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';

class Update_Language extends StatefulWidget {
  List<dynamic> user_detali;
  String langType;
  Update_Language(this.user_detali, this.langType);

  @override
  State<Update_Language> createState() => _Update_LanguageState();
}

class _Update_LanguageState extends State<Update_Language> {

  bool islode = false;
  List<int> language_check_id = List.empty(growable: true);
  List<Data> language_list = List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("111111111111111110   ${widget.user_detali[0].language}");
    select_language();
  }

  select_language() async {
    HttpService.select_language_api().then((value) {
      if (mounted) {
        setState(() {
          if (value['success'] == "true"||value['success'] == true) {
            var values = LanguageModel.fromJson(value).data;
            language_list.addAll(values);
            print(language_list.length);
            print(language_list);
            language_check_id.addAll(widget.user_detali[0].language);
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
          title: widget.langType=="English"?Text('Update Language',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)):Text('अद्यतन भाषा',
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
        body : islode
            ? Column(
          children: [
            Expanded(
              child: Container(
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
                child:language_list.length==0?Container(
                  color: Colors.transparent,
                  child: Center(
                      child: Container(
                        height: height * 0.2,
                        width: width*0.5,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Images.no_data))),
                      )
                  ),
                ): ListView.builder(
                  itemCount: language_list.length,
                  itemBuilder: (context, index) {
                    for(int i=0;i<language_check_id.length;i++){
                      if(language_check_id[i]==language_list[index].id)
                      {
                        language_list[index].is_check = true;
                      }
                    }
                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (language_list[index].is_check == true) {
                            language_list[index].is_check = false;
                            language_check_id.remove(language_list[index].id);
                          } else {
                            language_list[index].is_check = true;
                            language_check_id.add(language_list[index].id);
                          }
                          print(
                              "check ::::::::::::: ${language_check_id}");
                        });
                      },
                      child: Container(
                        margin:
                        EdgeInsets.only(left: 20, bottom: 10, top: 5),
                        child: Row(
                          children: [
                            Checkbox(
                                activeColor: ColorResources.ORANGE,
                                value: language_list[index].is_check,
                                onChanged: (value) {
                                  setState(() {
                                    language_list[index].is_check = value!;
                                    if (language_list[index].is_check == true) {
                                      language_check_id.add(language_list[index].id);
                                    } else {
                                      language_check_id.remove(language_list[index].id);
                                    }
                                    print(
                                        "check ::::::::::::: ${language_check_id}");
                                  });
                                }),
                            Container(
                              child: Text(
                                "${language_list[index].languageName}",
                                style: poppinsBold.copyWith(fontSize: 17),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            language_list.length==0?SizedBox(): Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (language_check_id.isNotEmpty) {
                          EasyLoading.show();
                          print(language_check_id);
                          var language= language_check_id.join(",");
                          print(language);
                          HttpService.edit_language_api(language).then((value) {
                            if (mounted) {
                              setState(() {
                                print(value['success']);
                                if (value['success'] == "true"||value['success'] == true) {
                                  EasyLoading.dismiss();
                                  language_check_id.addAll(language_check_id);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return home();
                                      },));
                                }
                                else{
                                  EasyLoading.dismiss();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return home();
                                      },));
                                }
                              });
                            }
                          });


                        } else {
                          AppConstants.show_toast(
                              "please select language");
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorResources.ORANGE,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(
                            bottom: height * 0.03,
                            right: height * 0.02,
                            left: height * 0.02),
                        height: height * 0.06,
                        alignment: Alignment.center,
                        child: widget.langType == "English"
                            ? Text("UPDATE",
                            style:
                            poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE))
                            : Text("अपडेट करें",
                            style:
                            poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
            : Container(
          height: height,
          width: width,
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
