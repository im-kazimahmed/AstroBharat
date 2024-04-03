import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../HttpService/HttpService.dart';
import '../../HttpService/model/Skill_model.dart';
import '../../utill/app_constants.dart';
import '../../utill/color_resources.dart';
import '../../utill/images.dart';
import '../../utill/share_preferences.dart';

import '../../utill/styles.dart';
import 'language_screen.dart';

class skill_screen extends StatefulWidget {
  const skill_screen({Key? key}) : super(key: key);

  @override
  State<skill_screen> createState() => _skill_screenState();
}

class _skill_screenState extends State<skill_screen> {
  String language = "";
  bool islode = false;
  List<int> skill_check_id = [];
  List<Data> skill_list  = List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    select_skill();
    language = PreferenceUtils.getString("language");
    print("language::::::::::$language");
  }

  select_skill() async {
    get() async {
      final prefs = await SharedPreferences.getInstance();
    }


    HttpService.select_skill_api().then((value) {
      if (mounted) {
        setState(() {
          print(value['success']);
          if (value['success'] == "true") {
            var values = SkillModel.fromJson(value).data;
            skill_list.addAll(values);
            print(skill_list.length);

            print(skill_list);
          }
          islode = true;

        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorResources.WHITE,
            title: Container(
              alignment: Alignment.center,
              child: language == "English"
                  ? Text(
                "Select Skill",
                style: poppinsBold.copyWith(
                    color: ColorResources.BLACK, fontSize: 19),
              )
                  : Text(
                "कौशल चुनें",
                style: poppinsBold.copyWith(
                    color: ColorResources.BLACK, fontSize: 19),
              ),
            ),
            actions: [
              SizedBox(
                width: width * 0.15,
              )
            ],
          ),
          body: islode
              ? Column(
            children: [
              Expanded(
                child: Container(
                  color: ColorResources.WHITE,
                  child:skill_list.length==0?Container(
                    color: Colors.transparent,
                    child: Center(
                        child: Container(
                          height: height * 0.2,
                          width: width*0.5,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Images.no_data))),
                        )
                    ),
                  ): ListView.builder(
                    itemCount: skill_list.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {

                            if(skill_list[index].is_check == true)
                            {
                              skill_list[index].is_check = false;
                              skill_check_id.remove(skill_list[index].id);

                            }
                            else{
                              skill_list[index].is_check = true;
                              skill_check_id.add(skill_list[index].id);

                            }
                            print(
                                "check ::::::::::::: ${skill_check_id}");
                          });
                        },
                        child: Container(
                          margin:
                          const EdgeInsets.only(left: 20, bottom: 10, top: 5),
                          child: Row(
                            children: [
                              Checkbox(
                                  activeColor: ColorResources.ORANGE,
                                  value: skill_list[index].is_check,
                                  onChanged: (value) {
                                    setState(()  {
                                      skill_list[index].is_check = value!;
                                      if (skill_list[index].is_check == true) {
                                        skill_check_id.add(skill_list[index].id);
                                      } else {
                                        skill_check_id.remove(skill_list[index].id);
                                      }
                                      print("check ::::::::::::: ${skill_check_id}");
                                    });
                                  }),
                              Text(
                                "${skill_list[index].skillName}",
                                style:
                                poppinsBold.copyWith(fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            skill_list.length==0?const SizedBox():  Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (skill_check_id.isNotEmpty) {

                            var string_skil= skill_check_id.join(",");
                            print(skill_check_id);
                            PreferenceUtils.setString("skill_id", string_skil);
                            print("------------------------${  PreferenceUtils.getString("skill_id")}");
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return language_page();
                                },)
                               );
                          } else {
                            language == "English"
                                ? AppConstants.show_toast("Please select skill")
                                : AppConstants.show_toast("कृपया कौशल का चयन करें");
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
                          child: language == "English"
                              ? Text(
                            "Next",
                            style: poppinsBold.copyWith(
                                color: ColorResources.WHITE),
                          )
                              : Text(
                            "अगला",
                            style: poppinsBold.copyWith(
                                color: ColorResources.WHITE),
                          ),
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
              child: const Center(child: CircularProgressIndicator())),
        ));
  }
}

