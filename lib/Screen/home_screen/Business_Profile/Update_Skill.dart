import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../HttpService/HttpService.dart';
import '../../../HttpService/model/Skill_model.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../home_screen.dart';

class Update_Skill extends StatefulWidget {
  List<dynamic> user_detalil;
  String langTypel;
  Update_Skill(this.user_detalil, this.langTypel);

  @override
  State<Update_Skill> createState() => _Update_SkillState();
}

class _Update_SkillState extends State<Update_Skill> {


  List<int> skill_check_id = List.empty(growable: true);
  List<Data> skill_list = List.empty(growable: true);
  bool islode = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    select_skill();

    print(skill_check_id);
  }

  select_skill() async {
    get() async {
      final prefs = await SharedPreferences.getInstance();
    }

    HttpService.select_skill_api().then((value) {
      if (mounted) {
        setState(() {
          print(value['success']);
          if (value['success'] == "true"||value['success'] == true) {
            var values = SkillModel.fromJson(value).data;
            skill_list.addAll(values);
            print(skill_list.length);
            print(skill_list);
            skill_check_id.addAll(widget.user_detalil[0].skill);
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
          title:widget.langTypel=="English"? Text('Update Skill',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width * 0.055)):Text('अद्यतन कौशल',
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
                child:skill_list.length==0?Container(
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
                  itemCount: skill_list.length,
                  itemBuilder: (context, index) {
                    for(int i=0;i<skill_check_id.length;i++){
                      if(skill_check_id[i]==skill_list[index].id)
                      {
                        skill_list[index].is_check = true;
                      }
                    }
                    return InkWell(
                      onTap: () {
                        setState(() {

                          if (skill_list[index].is_check == true) {
                            skill_list[index].is_check = false;
                            skill_check_id.remove(skill_list[index].id);
                          } else {
                            skill_list[index].is_check = true;
                            skill_check_id.add(skill_list[index].id);
                          }
                          print("check ::::::::::::: ${skill_check_id}");
                        });
                      },
                      child: Container(
                        margin:
                        EdgeInsets.only(left: 20, bottom: 10, top: 5),
                        child: Row(
                          children: [
                            Checkbox(
                                activeColor: ColorResources.ORANGE,
                                value: skill_list[index].is_check,
                                onChanged: (value) {
                                  setState(() {
                                    skill_list[index].is_check = value!;
                                    if (skill_list[index].is_check ==
                                        true) {
                                      skill_check_id
                                          .add(skill_list[index].id);
                                    } else {
                                      skill_check_id.remove(
                                          skill_list[index].id);
                                    }
                                    print(
                                        "check ::::::::::::: ${skill_check_id}");
                                  });
                                }),
                            Container(
                              child: Text(
                                "${skill_list[index].skillName}",
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
            skill_list.length==0?SizedBox():  Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (skill_check_id.isNotEmpty) {
                          EasyLoading.show();
                          var skill = skill_check_id.join(",");
                          print(skill);
                          HttpService.edit_skill_api(skill).then((value) {
                            if (mounted) {
                              setState(() {
                                print(value['success']);
                                if (value['success'] == "true"||value['success'] == true) {
                                  EasyLoading.dismiss();
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
                          widget.langTypel == "English"
                              ? AppConstants.show_toast(
                              "please select Skill")
                              : AppConstants.show_toast(
                              "कृपया कौशल का चयन करें");
                          AppConstants.show_toast("please select Skill");
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorResources.ORANGE,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.only(

                            right: height * 0.02,
                            left: height * 0.02),
                        height: height * 0.06,
                        alignment: Alignment.center,
                        child: widget.langTypel == "English"
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
            child: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
