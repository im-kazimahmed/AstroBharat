import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../HttpService/HttpService.dart';

import '../../../HttpService/model/Category_model.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../home_screen.dart';
class Update_Category extends StatefulWidget {
  List<dynamic> user_detali;
  String langType;
  Update_Category(this.user_detali, this.langType);

  @override
  State<Update_Category> createState() => _Update_CategoryState();
}

class _Update_CategoryState extends State<Update_Category> {

  bool islode = false;

  List<int> Category_check_id = List.empty(growable: true);
  List<Data> Category_list  = List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Category();
    // Category_check_id=widget.user_detali[0].category;
  }
  Category(){
    HttpService.select_category_api().then((value) {
      if (mounted) {
        setState(() {
          if (value['success'] == "true"||value['success'] == true) {
            var values = CategoryModel.fromJson(value).data;
            Category_list.addAll(values);
            Category_check_id.addAll(widget.user_detali[0].category);
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
    print(Category_check_id);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: ColorResources.BLACK,
              )),
          title:widget.langType=="English"? Text('Update Category',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width * 0.055)):Text('अद्यतन श्रेणी',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width * 0.055)),
          backgroundColor: ColorResources.ORANGE_WHITE,
          elevation: 2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        body:  islode
            ? Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    image: const DecorationImage(
                        image: AssetImage(Images.Splash_Screen),fit: BoxFit.fill
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 1)),
                    ],
                    borderRadius: BorderRadius.circular(05)),
                child: Category_list.length==0?Container(
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
                  itemCount: Category_list.length,
                  itemBuilder: (context, index) {
                    // for(int i=0;i<Category_check_id.length;i++){
                    //   if(Category_check_id[i]==Category_list[index].id)
                    //   {
                    //   print(Category_list[index].is_check);
                    //     Category_list[index].is_check = true;
                    //   }
                    // }
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

                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Category_list[index].categoryName,
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
                                      print("isParentCategoryChecked:$isParentCategoryChecked");
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
                                            Category_list[subIndex].categoryName,
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
                        ),
                      );
                    } else {
                      return const SizedBox.shrink(); // Hide non-parent category items
                    }
                    // return InkWell(
                    //   onTap: () {
                    //     setState(() {
                    //       if(Category_list[index].is_check == true)
                    //       {
                    //         Category_list[index].is_check = false;
                    //         Category_check_id.remove(Category_list[index].id);
                    //       }
                    //       else{
                    //         Category_list[index].is_check = true;
                    //         Category_check_id.add(Category_list[index].id);
                    //       }
                    //       print(
                    //           "check ::::::::::::: ${Category_check_id}");
                    //     });
                    //   },
                    //   child: Container(
                    //     margin: const EdgeInsets.only(left: 20, bottom: 10, top: 5),
                    //     child: Row(
                    //       children: [
                    //         Checkbox(
                    //             activeColor: ColorResources.ORANGE,
                    //             // checkColor: ,
                    //             value: Category_list[index].is_check,
                    //             onChanged: (value) {
                    //               setState(() {
                    //                 Category_list[index].is_check = value!;
                    //                 if (Category_list[index].is_check == true) {
                    //                   Category_check_id.add(Category_list[index].id);
                    //                 } else {
                    //                   Category_check_id.remove(Category_list[index].id);
                    //                 }
                    //                 print("check ::::::::::::: ${Category_check_id}");
                    //               });
                    //             }),
                    //         Container(
                    //           child: Text("${Category_list[index].categoryName}",
                    //             style: poppinsBold.copyWith(fontSize: 17),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // );
                  },
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
                          EasyLoading.show();
                          var Category= Category_check_id.join(",");
                          print(Category);

                          HttpService.edit_Category_api(Category).then((value) {
                            if (mounted) {
                              setState(() {
                                print(value['success']);
                                if (value['success'] == "true" ||value['success'] == true) {
                                  EasyLoading.dismiss();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return const home();
                                      },));
                                }
                                else{
                                  EasyLoading.dismiss();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return const home();
                                      },));
                                }
                              });
                            }
                          });
                        }
                        else{
                          AppConstants.show_toast("please select Category");
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorResources.ORANGE,
                            borderRadius: BorderRadius.circular(10)),
                        height: height * 0.06,
                        alignment: Alignment.center,
                        child: Text(
                          widget.langType == "English" ? "UPDATE": "अपडेट करें",
                          style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ):Container(height:height,
            width:width,color:Colors.white,child: const Center(child: CircularProgressIndicator())) ,
      ),
    );
  }
}
