import 'package:astrobharat/Screen/register_screen/skill_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../HttpService/HttpService.dart';
import '../../HttpService/model/Category_model.dart';
import '../../utill/app_constants.dart';
import '../../utill/color_resources.dart';
import '../../utill/images.dart';
import '../../utill/share_preferences.dart';
import '../../utill/styles.dart';

class category_screen extends StatefulWidget {
  const category_screen({Key? key}) : super(key: key);

  @override
  State<category_screen> createState() => _category_screenState();
}

class _category_screenState extends State<category_screen> {
  String language = "";

  bool islode = false;

  List<int> Category_check_id = [];
  List<Data> Category_list  = List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    language = PreferenceUtils.getString("language");
    print("language::::::::::$language");
    print("language::::::::::${PreferenceUtils.getString("country_code")}");
    Category();
  }
  Category(){

    get() async {
      final prefs = await SharedPreferences.getInstance();
    }

    HttpService.select_category_api().then((value) {
      if (mounted) {
        setState(() {
          print(value['success']);
          if (value['success'] == "true") {
            var values = CategoryModel.fromJson(value).data;
            Category_list.addAll(values);
            print(Category_list.length);

            print(Category_list);
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
                "Select Category",
                style: poppinsBold.copyWith(
                    color: ColorResources.BLACK, fontSize: 19),
              )
                  : Text(
                "श्रेणी चुनना",
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
          body: islode ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  color: ColorResources.WHITE,
                  child: Category_list.length==0?Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Container(
                        height: height * 0.2,
                        width: width*0.5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage(Images.no_data))),
                      ),
                    ),
                  ):Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: ListView.builder(
                      itemCount: Category_list.length,
                      itemBuilder: (context, index) {
                        if (Category_list[index].parentId == 0) {
                          // Category is a parent category
                          bool isParentCategoryChecked = false;
                          for (var subIndex = 0; subIndex < Category_list.length; subIndex++) {
                            if (Category_list[subIndex].parentId == Category_list[index].id) {
                              // Subcategory under the parent category
                              if (Category_list[subIndex].is_check) {
                                isParentCategoryChecked = true;
                              }
                            }
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${Category_list[index].categoryName}",
                                style: poppinsBold.copyWith(fontSize: 17),
                              ),
                              const SizedBox(height: 5),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: Category_list.length,
                                itemBuilder: (context, subIndex) {
                                  if (Category_list[subIndex].parentId == Category_list[index].id) {
                                    // Subcategory under the parent category
                                    return InkWell(
                                      onTap: () {
                                        print(isParentCategoryChecked);
                                        setState(() {
                                          if (Category_list[subIndex].is_check) {
                                            Category_list[subIndex].is_check = false;
                                            Category_check_id.remove(Category_list[subIndex].id);
                                          } else {
                                            Category_list[subIndex].is_check = true;
                                            Category_check_id.add(Category_list[subIndex].id);
                                          }
                                          // Check if all subcategories are selected
                                          bool allSubcategoriesSelected = true;
                                          for (var subIndex = 0; subIndex < Category_list.length; subIndex++) {
                                            if (Category_list[subIndex].parentId == Category_list[index].id &&
                                                !Category_list[subIndex].is_check) {
                                              allSubcategoriesSelected = false;
                                              break;
                                            }
                                          }
                                          // Update parent category checkbox based on subcategory selection
                                          isParentCategoryChecked = allSubcategoriesSelected;
                                          // Update parent category ID list
                                          if (allSubcategoriesSelected) {
                                            Category_check_id.add(Category_list[index].id);
                                          } else {
                                            Category_check_id.remove(Category_list[index].id);
                                          }
                                          print("check ::::::::::::: ${Category_check_id}");
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 20, bottom: 10, top: 5),
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              activeColor: ColorResources.ORANGE,
                                              value: Category_list[subIndex].is_check,
                                              onChanged: (value) {
                                                setState(() {
                                                  Category_list[subIndex].is_check = value!;
                                                  // Check if all subcategories are selected
                                                  bool allSubcategoriesSelected = true;
                                                  for (var subIndex = 0; subIndex < Category_list.length; subIndex++) {
                                                    if (Category_list[subIndex].parentId == Category_list[index].id &&
                                                        !Category_list[subIndex].is_check) {
                                                      allSubcategoriesSelected = false;
                                                      break;
                                                    }
                                                  }
                                                  // Update parent category checkbox based on subcategory selection
                                                  isParentCategoryChecked = allSubcategoriesSelected;
                                                  // Update parent category ID list
                                                  if (value) {
                                                    Category_check_id.add(Category_list[subIndex].id);
                                                  } else {
                                                    Category_check_id.remove(Category_list[subIndex].id);
                                                  }
                                                  // Update parent category ID list
                                                  if (allSubcategoriesSelected) {
                                                    Category_check_id.add(Category_list[index].id);
                                                  } else {
                                                    Category_check_id.remove(Category_list[index].id);
                                                  }
                                                  print("check ::::::::::::: ${Category_check_id}");
                                                });
                                              },
                                            ),
                                            Text(
                                              "${Category_list[subIndex].categoryName}",
                                              style: poppinsBold.copyWith(fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox.shrink(); // Hide non-subcategory items
                                  }
                                },
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink(); // Hide non-parent category items
                        }
                      },
                    ),
                  ),
                ),
              ),
              Category_list.length==0?const SizedBox():Container(
                color: ColorResources.WHITE,
                margin: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if(Category_check_id.isNotEmpty)
                          {

                            var string_Category= Category_check_id.join(",");
                            print(string_Category);
                            PreferenceUtils.setString("category", string_Category);
                            print("------------------------${  PreferenceUtils.getString("category")}");
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return  const skill_screen();
                                },)
                               );
                          }
                          else{
                            language == "English" ? AppConstants.show_toast("Please select Category") : AppConstants.show_toast("कृपया श्रेणी का चयन करें");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorResources.ORANGE,
                              borderRadius: BorderRadius.circular(10)),
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
          )   : Container(height:height,
              width:width,color:Colors.white,child: const Center(child: CircularProgressIndicator())) ,
        ));
  }
}