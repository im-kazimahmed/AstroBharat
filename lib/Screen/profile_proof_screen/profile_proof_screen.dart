import 'dart:convert';
import 'dart:io';
import 'package:astrobharat/Screen/login/login_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../HttpService/HttpService.dart';
import '../../utill/app_constants.dart';
import '../../utill/color_resources.dart';
import '../../utill/images.dart';
import '../../utill/share_preferences.dart';
import '../../utill/styles.dart';
import '../home_screen/home_screen.dart';

class profile_proof_page extends StatefulWidget {
  const profile_proof_page({Key? key}) : super(key: key);

  @override
  State<profile_proof_page> createState() => _profile_proof_pageState();
}

class _profile_proof_pageState extends State<profile_proof_page> {
  TextEditingController bio_controller = TextEditingController();

  FocusNode bio_focuse = FocusNode();

  // profile image piker
  File imageFile_profile = File("");
  ImageCropper imagecropp_profile = new ImageCropper();
  File profile_file = File("");
  String URLFile_profile = '';
  bool imglod_profile = true;

  // GOV proof  image piker
  // File imageFile_proof = File("");
  // ImageCropper imagecropp_proof = new ImageCropper();
  // File proof_file = File("");
  //
  // bool imglod_proof = true;


  String URLFile_proof = '';
  String language = "";
  String Fname = "";
  String Nname = "";
  String Email = "";
  String number = "";
  String ANumber = "";
  String Date = "";
  String Gender = "";
  String Password = "";
  String category = "";
  String skill = "";
  String slanguage = "";
  String experience = "";
  String country = "";
  String state = "";
  String city = "";
  String address = "";
  String pincode = "";
  String degree = "";
  String pancard_number = "";
  String aadhar_number = "";
  String account_number = "";
  String account_type = "";
  String ifsc_code = "";
  String holder_name = "";
  String bank_name = "";
  String country_code = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    language = PreferenceUtils.getString("language");
    Fname = PreferenceUtils.getString("Fname");
    Nname = PreferenceUtils.getString("Nname");
    Email = PreferenceUtils.getString("Email");
    number = PreferenceUtils.getString("number");
    ANumber = PreferenceUtils.getString("ANumber");
    Date = PreferenceUtils.getString("Date");
    Gender = PreferenceUtils.getString("Gender");
    Password = PreferenceUtils.getString("Password");
    category = PreferenceUtils.getString("category");
    skill = PreferenceUtils.getString("skill_id");
    slanguage = PreferenceUtils.getString("language_id");
    experience = PreferenceUtils.getString("experience");
    country = PreferenceUtils.getString("country");
    state = PreferenceUtils.getString("state");
    city = PreferenceUtils.getString("city");
    address = PreferenceUtils.getString("address");
    pincode = PreferenceUtils.getString("pincode");
    degree = PreferenceUtils.getString("degree");
    pancard_number = PreferenceUtils.getString("pancard_number");
    aadhar_number = PreferenceUtils.getString("aadhar_number");
    account_number = PreferenceUtils.getString("account_number");
    account_type = PreferenceUtils.getString("account_type");
    ifsc_code = PreferenceUtils.getString("ifsc_code");
    holder_name = PreferenceUtils.getString("holder_name");
    bank_name = PreferenceUtils.getString("bank_name");
    URLFile_proof = PreferenceUtils.getString("gov.proof");
    country_code = PreferenceUtils.getString("country_code");
    get();
  }

  get() async {
    final prefs = await SharedPreferences.getInstance();
  }



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: height * 0.9635,
        width: width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  Images.Splash_Screen,
                ),
                fit: BoxFit.fill)),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowGlow();
            return true;
          },
          child: ListView(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Container(
                      width: width,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                Images.Splash_Screen,
                              ),
                              fit: BoxFit.fill)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: height * 0.13,
                                child: Image.asset(Images.Astrobharat_logo),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // profile image
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return SimpleDialog(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: width * 0.05,
                                                        vertical: height * 0.015),
                                                children: [
                                                  Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            SimpleDialogOption(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10.0),
                                                                child: SizedBox(
                                                                  height: height * 0.06,
                                                                  width: width * 0.15,

                                                                  child: const Icon(Icons.camera_alt,size: 40,color: ColorResources.ORANGE,),
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                get_profile_image(ImageSource.camera);
                                                                Navigator.pop(context);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            SimpleDialogOption(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10.0),
                                                                child: SizedBox(
                                                                  height: height * 0.06,
                                                                  width: width * 0.15,
                                                                  child: const Icon(Icons.photo,size: 40,color: ColorResources.ORANGE,),
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                get_profile_image(
                                                                    ImageSource
                                                                        .gallery);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        });
                                      },
                                      child: imglod_profile
                                          ? const CircleAvatar(
                                              backgroundColor: ColorResources.WHITE,
                                              radius: 50.0,
                                              child: Icon(
                                                Icons.person,
                                                color: ColorResources.BLACK,
                                                size: 90,
                                              ),
                                            )
                                          : Stack(
                                              alignment:
                                                  AlignmentDirectional.bottomEnd,
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    AppConstants.IMAGE_VIEW +
                                                        URLFile_profile,
                                                  ),
                                                  radius: 50.0,
                                                ),
                                                const CircleAvatar(
                                                  backgroundColor:
                                                      ColorResources.BLACK,
                                                  radius: 15,
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.edit,
                                                    size: 15,
                                                    color: ColorResources.WHITE,
                                                  )),
                                                )
                                              ],
                                            ),
                                    ),
                                  ),
                                  Container(
                                    child: language == "English"
                                        ? Text(
                                            "Profile Pic",
                                            style: poppinsBold.copyWith(
                                                color: ColorResources.BLACK,
                                                fontSize: 17),
                                          )
                                        : Text(
                                            "प्रोफाइल चित्र",
                                            style: poppinsBold.copyWith(
                                                color: ColorResources.BLACK,
                                                fontSize: 17),
                                          ),
                                  )
                                ],
                              ),

                              // SizedBox(
                              //   width: width * 0.1,
                              // ),
                              //
                              // // Gov.proof image
                              // Column(
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.all(8.0),
                              //       child: InkWell(
                              //         onTap: () {
                              //           setState(() {
                              //             showDialog(
                              //               context: context,
                              //               builder: (context) {
                              //                 return SimpleDialog(
                              //                   contentPadding:
                              //                       EdgeInsets.symmetric(
                              //                           horizontal: width * 0.05,
                              //                           vertical: height * 0.015),
                              //                   children: [
                              //                     Center(
                              //                       child: Row(
                              //                         mainAxisAlignment:
                              //                             MainAxisAlignment.center,
                              //                         children: [
                              //                           Column(
                              //                             children: [
                              //                               SimpleDialogOption(
                              //                                 child: Padding(
                              //                                   padding:
                              //                                       const EdgeInsets
                              //                                           .all(10.0),
                              //                                   child: Container(
                              //                                     height: height * 0.06,
                              //                                     width: width * 0.15,
                              //                                     child: Icon(Icons.camera_alt,size: 40,color: ColorResources.ORANGE,),
                              //                                   ),
                              //                                 ),
                              //                                 onPressed: () {
                              //                                   get_proof_image(
                              //                                       ImageSource
                              //                                           .camera);
                              //                                   Navigator.pop(
                              //                                       context);
                              //                                 },
                              //                               ),
                              //                             ],
                              //                           ),
                              //                           Column(
                              //                             children: [
                              //                               SimpleDialogOption(
                              //                                 child: Padding(
                              //                                   padding:
                              //                                       const EdgeInsets
                              //                                           .all(10.0),
                              //                                   child: Container(
                              //                                     height: height * 0.06,
                              //                                     width: width * 0.15,
                              //                                     child: Icon(Icons.photo,size: 40,color: ColorResources.ORANGE,),
                              //                                   ),
                              //                                 ),
                              //                                 onPressed: () {
                              //                                   get_proof_image(
                              //                                       ImageSource
                              //                                           .gallery);
                              //                                   Navigator.pop(
                              //                                       context);
                              //                                 },
                              //                               ),
                              //                             ],
                              //                           )
                              //                         ],
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 );
                              //               },
                              //             );
                              //           });
                              //         },
                              //         child: imglod_proof
                              //             ? CircleAvatar(
                              //                 backgroundColor: ColorResources.WHITE,
                              //                 radius: 50.0,
                              //                 child: Image.asset(Images.card))
                              //             : Stack(
                              //                 alignment:
                              //                     AlignmentDirectional.bottomEnd,
                              //                 children: [
                              //                   CircleAvatar(
                              //                     backgroundImage:
                              //                         NetworkImage("${AppConstants.IMAGE_VIEW}"+URLFile_proof),
                              //                     radius: 50.0,
                              //                   ),
                              //                   CircleAvatar(
                              //                     backgroundColor:
                              //                         ColorResources.BLACK,
                              //                     radius: 15,
                              //                     child: Center(
                              //                         child: Icon(
                              //                       Icons.edit,
                              //                       size: 15,
                              //                       color: ColorResources.WHITE,
                              //                     )),
                              //                   )
                              //                 ],
                              //               ),
                              //       ),
                              //     ),
                              //     Container(
                              //       child: language == "English"
                              //           ? Text(
                              //               "Gov.Proof",
                              //               style: poppinsBold.copyWith(
                              //                   color: ColorResources.BLACK,
                              //                   fontSize: 17),
                              //             )
                              //           : Text(
                              //               "सरकारी सबूत",
                              //               style: poppinsBold.copyWith(
                              //                   color: ColorResources.BLACK,
                              //                   fontSize: 17),
                              //             ),
                              //     )
                              //   ],
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 3)
                                ],
                                borderRadius: BorderRadius.circular(5)),
                            margin: const EdgeInsets.only(left: 17, top: 15, right: 17),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.text,
                              maxLines: 6,
                              style: poppinsBold.copyWith(fontSize: 17),
                              controller: bio_controller,
                              // textCapitalization: capitalization,
                              focusNode: bio_focuse,
                              decoration: InputDecoration(
                                counterText: "",
                                hintText: "Long Bio",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10),
                                hintStyle: poppinsBold.copyWith(
                                    fontSize: 18, color: Colors.black38),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.transparent)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.transparent)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          InkWell(
                            onTap: () {
                              if (URLFile_profile.isEmpty) {
                                language == "English"
                                    ? AppConstants.show_toast(
                                        "Please Uplode Profile pic")
                                    : AppConstants.show_toast(
                                        "कृपया प्रोफ़ाइल चित्र अपलोड करें");
                              } /*else if (URLFile_proof.isEmpty) {
                                language == "English"
                                    ? AppConstants.show_toast(
                                        "Please Uplode Government proof.")
                                    : AppConstants.show_toast(
                                        "कृपया प्रोफ़ाइल चित्र अपलोड करें");
                              }*/ else if (bio_controller.text.isEmpty) {
                                language == "English"
                                    ? AppConstants.show_toast("Please Enter Bio")
                                    : AppConstants.show_toast(
                                        "कृपया जैव दर्ज करेंं");
                              } else {

                                EasyLoading.show();
                                print( language);
                                print(Fname);
                                print(Nname);
                                print(Email);
                                print(number);
                                print(ANumber);
                                print(Date);
                                print(Gender);
                                print(Password);
                                print(category);
                                print(skill);
                                print(slanguage);
                                print(experience);
                                print(country);
                                print(state);
                                print(city);
                                print(address);
                                print(pincode);
                                print(degree);
                                print(pancard_number);
                                print(aadhar_number);
                                print(account_number);
                                print(account_type);
                                print(ifsc_code);
                                print(holder_name);
                                print(bank_name);
                                print(URLFile_profile);
                                print(URLFile_proof);
                                print(bio_controller.text);
                                register_api();
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: height * 0.055,
                              width: width * 0.55,
                              decoration: BoxDecoration(
                                  color: ColorResources.ORANGE,
                                  borderRadius: BorderRadius.circular(5)),
                              child: language == "English"
                                  ? Text("Next",
                                      style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE))
                                  : Text("अगला",
                                      style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  // profile image croper
  Future get_profile_image(ImageSource sourcepath) async {
    ImagePicker imagePicker = ImagePicker();
    final XFile? pickedFile =
        await imagePicker.pickImage(source: sourcepath, imageQuality: 50);
    File? file = File(imageFile_profile.path);

    if (pickedFile != null) {
      CroppedFile? cropped = (await imagecropp_profile.cropImage(
          sourcePath: pickedFile.path,
          compressQuality: 40,
          compressFormat: ImageCompressFormat.jpg,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
          ],
          uiSettings: [
            IOSUiSettings(minimumAspectRatio: 1.0,),
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: ColorResources.GREY,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: false),
          ]));
      setState(() {
        if (cropped != null) {
          profile_file=File(cropped.path);
          print("Profile_Pic:::::::$profile_file");
          File_Upload_Profile(File(cropped.path));
        }
      });
    }
    return file;
  }

  File_Upload_Profile(File fileName) {
    file_upload(fileName).then((res) {
      print("1111111111111111111111$res");
      setState(() {
        if (res.statusCode == 200) {
          res.stream.transform(utf8.decoder).listen((value) {
            Map<String, dynamic> data = jsonDecode(value);
              URLFile_profile = data['image'];
            print('profile_url::::$URLFile_profile');
            imglod_profile = false;
          });
        } else {
          throw Exception('Failed to load post');
        }
      });
    }).catchError((error) {});
  }

  static file_upload(File imagename) async {
    var url = Uri.parse('${AppConstants.IMAGE}');
    print('file_upload::::$url');
    var request = http.MultipartRequest('POST', url);
    request.files
        .add(await http.MultipartFile.fromPath('image', imagename.path));
    var res = await request.send();
    print("22222$res");
    return res;
  }



  // proof image croper

  // Future get_proof_image(ImageSource sourcepath) async {
  //   final ImagePicker imagePicker = new ImagePicker();
  //   final XFile? pickedFile =
  //       await imagePicker.pickImage(source: sourcepath, imageQuality: 50);
  //   File? file = File(imageFile_proof.path);
  //   if (pickedFile != null) {
  //     CroppedFile? cropped = (await imagecropp_proof.cropImage(
  //         sourcePath: pickedFile.path,
  //         compressQuality: 40,
  //         compressFormat: ImageCompressFormat.jpg,
  //         aspectRatioPresets: [
  //           CropAspectRatioPreset.original,
  //         ],
  //         uiSettings: [
  //           IOSUiSettings(minimumAspectRatio: 1.0,),
  //           AndroidUiSettings(
  //               toolbarTitle: 'Cropper',
  //               toolbarColor: ColorResources.GREY,
  //               toolbarWidgetColor: Colors.white,
  //               initAspectRatio: CropAspectRatioPreset.square,
  //               lockAspectRatio: false),
  //         ]));
  //     setState(() {
  //       if (cropped != null) {
  //         profile_file=File(cropped.path);
  //         print("Profile_Pic:::::::$profile_file");
  //         File_Upload_proof(File(cropped.path));
  //       }
  //     });
  //   }
  //   return file;
  // }
  //
  // File_Upload_proof(File fileName) {
  //   file_upload_image(fileName).then((res) {
  //     setState(() {
  //       if (res.statusCode == 200) {
  //         res.stream.transform(utf8.decoder).listen((value) {
  //           Map<String, dynamic> data = jsonDecode(value);
  //           URLFile_proof = data['image'];
  //           print('profile_url::::$URLFile_proof');
  //           imglod_proof = false;
  //         });
  //       } else {
  //         throw Exception('Failed to load post');
  //       }
  //     });
  //   }).catchError((error) {});
  // }
  //
  // static file_upload_image(File imagename) async {
  //   var url = Uri.parse('${AppConstants.IMAGE}');
  //   print('file_upload::::$url');
  //   var request = http.MultipartRequest('POST', url);
  //   request.files
  //       .add(await http.MultipartFile.fromPath('image', imagename.path));
  //   var res = await request.send();
  //   return res;
  // }

  register_api() async {
    Map map = {
      "full_name": Fname,
      "nick_name": Nname,
      "email": Email,
      "mo_no": number,
      "alt_mo_no": ANumber,
      "dob": Date,
      "gender": Gender,
      "Password": Password,
      "category": category,
      "skill": skill,
      "language": slanguage,
      "experience": experience,
      "country": country,
      "state": state,
      "city": city,
      "address": address,
      "pincode": pincode,
      "highest_degree": degree,
      "pancard": pancard_number,
      "aadhar_card": aadhar_number,
      "bank_add_number": account_number,
      "acc_type": account_type,
      "IFSC_code": ifsc_code,
      "acc_holder_name": holder_name,
      "bank_name": bank_name,
      "image": URLFile_profile,
      "id_proof": URLFile_proof,
      "description_bio": bio_controller.text,
      "device_id": "123",
      "lang_type":language,
      "country_code":country_code
    };
    print(map);
    HttpService.register_api(
            Fname,
            Nname,
            Email,
            number,
            ANumber,
            Date,
            Gender,
            category,
            skill,
            slanguage,
            experience,
            country,
            state,
            city,
            address,
            pincode,
            degree,
            pancard_number,
            aadhar_number,
            account_number,
            account_type,
            ifsc_code,
            holder_name,
            bank_name,
            URLFile_profile,
            URLFile_proof,
            bio_controller.text,
            "123",language,Password,country_code)
        .then((value) {
      if (mounted) {
        setState(() {
          if (value['success'] == "true" || value['success'] == true) {
            PreferenceUtils.setString("token", value['token']);
            PreferenceUtils.setbool("login", true);
            print("sssssssssssssss${PreferenceUtils.getbool("login")}");
            // print("token::::::::::::${PreferenceUtils.getString("token")}");
            Navigator.pushReplacement(
                context,
             MaterialPageRoute(builder: (context) {
               return const home();
             },));

            EasyLoading.dismiss();

          } else {
            EasyLoading.dismiss();
            EasyLoading.showError("not register");
            EasyLoading.dismiss();
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const login_screen();
                },));
          }
        });
      }
    });
  }
}


