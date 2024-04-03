import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../HttpService/HttpService.dart';
import '../../HttpService/model/Language_Model.dart';
import '../../utill/app_constants.dart';
import '../../utill/color_resources.dart';
import '../../utill/images.dart';
import '../../utill/share_preferences.dart';
import '../../utill/styles.dart';

import '../address_screen/address_screen.dart';

class language_page extends StatefulWidget {

  @override
  State<language_page> createState() => _language_pageState();
}

class _language_pageState extends State<language_page> {
  String language = "";

  bool islode = false;

  List<int> language_check_id = [];
  List<Data> language_list = List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    select_language();
    language = PreferenceUtils.getString("language");
    print("language::::::::::$language");
  }

  select_language() async {

    get() async {
      final prefs = await SharedPreferences.getInstance();
    }


    HttpService.select_language_api().then((value) {
      if (mounted) {
        setState(() {
          print(value['success']);
          if (value['success'] == "true") {
            var values = LanguageModel
                .fromJson(value)
                .data;
            language_list.addAll(values);
            print(language_list.length);

            print(language_list);
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
              "Select language",
              style: poppinsBold.copyWith(
                  color: ColorResources.BLACK, fontSize: 19),
            )
                : Text(
              "भाषा चुनेंं",
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
                child:language_list.length==0?Container(
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
                  itemCount: language_list.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (language_list[index].is_check == true) {
                            language_list[index].is_check = false;
                            language_check_id
                                .remove(language_list[index].id);
                          } else {
                            language_list[index].is_check = true;
                            language_check_id
                                .add(language_list[index].id);
                          }
                          print(
                              "check ::::::::::::: ${language_check_id}");
                        });
                      },
                      child: Container(
                        margin:
                        const EdgeInsets.only(left: 20, bottom: 10, top: 5),
                        child: Row(
                          children: [
                            Checkbox(
                                activeColor: ColorResources.ORANGE,
                                value: language_list[index].is_check,
                                onChanged: (value) {
                                  setState(() {
                                    language_list[index].is_check =
                                    value!;
                                    if (language_list[index].is_check ==
                                        true) {
                                      language_check_id.add(
                                          language_list[index]
                                              .id);
                                    } else {
                                      language_check_id.remove(
                                          language_list[index]
                                              .id);
                                    }
                                    print(
                                        "check ::::::::::::: ${language_check_id}");
                                  });
                                }),
                            Text(
                              "${language_list[index].languageName}",
                              style: poppinsBold.copyWith(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            language_list.length==0? const SizedBox():Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (language_check_id.isNotEmpty) {
                          print(language_check_id);
                          var string_language= language_check_id.join(",");
                          print(string_language);

                          PreferenceUtils.setString("language_id", string_language);
                          print("------------------------${  PreferenceUtils.getString("language_id")}");
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return address_page(true,[]);
                              },)
                          );
                        } else {
                          language == "English"
                              ? AppConstants.show_toast(
                              "Please select language")
                              : AppConstants.show_toast(
                              "कृपया भाषा चुनेंं");
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
                              color: Colors.white),
                        )
                            : Text(
                          "अगला",
                          style: poppinsBold.copyWith(
                              color: Colors.white),
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
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
