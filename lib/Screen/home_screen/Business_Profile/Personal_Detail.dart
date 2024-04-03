import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../HttpService/HttpService.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../home_screen.dart';

class personal_detail extends StatefulWidget {
  List user_detali;
  String langType;
  personal_detail(this.user_detali, this.langType);



  @override
  State<personal_detail> createState() => _personal_detailState();
}

class _personal_detailState extends State<personal_detail>{
  TextEditingController Fname_controller = TextEditingController();
  TextEditingController Nname_controller = TextEditingController();
  TextEditingController Email_controller = TextEditingController();
  TextEditingController Anumber_controller = TextEditingController();
  TextEditingController DateInput_controller = TextEditingController();


  FocusNode Fname_focus = FocusNode();
  FocusNode Nname_focus = FocusNode();
  FocusNode Email_focus = FocusNode();
  FocusNode Anumber_focus = FocusNode();
  FocusNode dateInput_focus = FocusNode();


  File imageFile_profile = File("");
  ImageCropper imagecropp_profile = new ImageCropper();
  File profile_file = File("");
  String URLFile_profile = '';
  bool imglod_profile = true;

  String   _isselected  = "English";
  String gender = "Male";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Fname_controller.text=widget.user_detali[0].fullName;
    Nname_controller.text=widget.user_detali[0].nickName;
    Email_controller.text=widget.user_detali[0].email;
    Anumber_controller.text=widget.user_detali[0].altMoNo;
    DateInput_controller.text=widget.user_detali[0].dob;
    gender=widget.user_detali[0].gender;
    URLFile_profile=widget.user_detali[0].image;



    _isselected=widget.langType;
    if(URLFile_profile!="")
      {
        imglod_profile = false;
      }


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
          title: _isselected=="English"?Text('Personal Detail',
              style: poppinsMedium.copyWith(
                  color: ColorResources.BLACK, fontSize: width*0.055)):Text('व्यक्तिगत जानकारी',
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
        body:  Container(
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
          child: ListView(
            children: [
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
                                                  child: Container(
                                                    height: height * 0.06,
                                                    width: width * 0.15,
                                                    child: Icon(Icons.camera_alt,size: 40,color: ColorResources.ORANGE,),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  get_profile_image(
                                                      ImageSource
                                                          .camera);
                                                  Navigator.pop(
                                                      context);
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
                                                  child: Container(
                                                    height: height * 0.06,
                                                    width: width * 0.15,
                                                    child: Icon(Icons.photo,size: 40,color: ColorResources.ORANGE,),
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
                            ? CircleAvatar(
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
                            CircleAvatar(
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
                      child: _isselected=="English"? Text(
                        "Profile Pic",
                        style: poppinsBold.copyWith(
                            color: ColorResources.BLACK,
                            fontSize: 17),
                      ):Text(
                        "प्रोफाइल चित्र",
                        style: poppinsBold.copyWith(
                            color: ColorResources.BLACK,
                            fontSize: 17),
                      )
                    )
                  ],
                ),
              TextFieldCustom(
                  Fname_controller,
                  _isselected == "English"
                      ? "Full Name"
                      : "वास्तविक नाम",
                  TextInputType.name,
                  1,
                  Fname_focus,
                  Nname_focus,
                  TextInputAction.next,
                  false,
                  1000,
                  Icons.person),
              TextFieldCustom(
                  Nname_controller,
                  _isselected == "English"
                      ? "Nick Name"
                      : "प्रदर्शित होने वाला नाम",
                  TextInputType.name,
                  1,
                  Nname_focus,
                  Email_focus,
                  TextInputAction.next,
                  false,
                  1000,
                  Icons.person),
              TextFieldCustom(
                  Email_controller,
                  _isselected == "English"
                      ? "Email Address"
                      : "ईमेल पता",
                  TextInputType.emailAddress,
                  1,
                  Email_focus,
                  Anumber_focus,
                  TextInputAction.next,
                  false,
                  1000,
                  Icons.email),
              TextFieldCustom(
                  Anumber_controller,
                  _isselected == "English"
                      ? "Alternate Phone No"
                      : "वैकल्पिक फोन नंबर",
                  TextInputType.number,
                  1,
                  Anumber_focus,
                  null,
                  TextInputAction.done,
                  true,
                  10,
                  Icons.call),
              // Date select
              Row(
                children: [
                  Container(
                    height: height * 0.059,
                    width: width * 0.91,
                    decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 3)
                        ],
                        borderRadius: BorderRadius.circular(5)),
                    margin:
                    EdgeInsets.only(left: 15, top: 15, right: 15),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.now());

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                          DateFormat('yyyy-MM-dd')
                              .format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            DateInput_controller.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      maxLines: 1,
                      maxLength: 10,
                      style: poppinsBold.copyWith(fontSize: 16),
                      controller: DateInput_controller,
                      // textCapitalization: capitalization,
                      focusNode: dateInput_focus,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {
                        if (value.length == 10) {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.date_range,
                          color: Colors.black,
                          size: 30,
                        ),
                        counterText: "",
                        hintText: _isselected == "English"
                            ? "Date of Birth"
                            : "जन्म की तारीख",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 15),
                        hintStyle: poppinsBold.copyWith(
                            fontSize: 17, color: Colors.black38),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.transparent)),
                      ),
                    ),
                  )
                ],
              ),

              // Gender Select
              SizedBox(
                height: height * 0.01,
              ),
              Row(children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Radio(
                      fillColor:
                      MaterialStateProperty.resolveWith((states) {
                        return ColorResources.BLACK;
                      }),
                      activeColor: ColorResources.BLACK,
                      value: "Male",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = "$value";
                        });
                        print(value); //selected value
                      }),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      gender = "Male";
                    });
                  },
                  child: Container(
                    child: Text(
                      _isselected == "English" ? "Male" : "पुरुष",
                      style: poppinsBold.copyWith(
                          fontSize: 16, color: ColorResources.BLACK),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                Container(
                  child: Radio(
                      fillColor:
                      MaterialStateProperty.resolveWith((states) {
                        return ColorResources.BLACK;
                      }),
                      activeColor: ColorResources.BLACK,
                      value: "Female",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = "$value";
                        });
                        print(value); //selected value
                      }),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      gender = "Female";
                    });
                  },
                  child: Container(
                    child: Text(
                      _isselected == "English" ? "Female" : "महिला",
                      style: poppinsBold.copyWith(
                          fontSize: 16, color: ColorResources.BLACK),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
              ]),

              // next button
              SizedBox(
                height: height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {


                      String FNAME = Fname_controller.text;
                      String NNMAE = Nname_controller.text;
                      String EMAIL = Email_controller.text;
                      String ANUMBER = Anumber_controller.text;
                      String DATE = DateInput_controller.text;

                      if (FNAME.isEmpty ||
                          NNMAE.isEmpty ||
                          EMAIL.isEmpty ||
                          ANUMBER.isEmpty ||
                          DATE.isEmpty||URLFile_profile.isEmpty) {
                        _isselected == "English"
                            ? AppConstants.show_toast("please fill your details")
                            : AppConstants.show_toast("कृपया अपना विवरण भरें");
                      } else if (ANUMBER.length < 10) {
                        _isselected == "English"
                            ? AppConstants.show_toast("please Enter valid 10 Digits Mobaile No.")
                            : AppConstants.show_toast("कृपया मान्य 10 अंकों का मोबाइल नंबर दर्ज करें।");
                      } else {
                        EasyLoading.show();
                        edit_profile_api(FNAME,NNMAE,EMAIL,ANUMBER,DATE,gender,URLFile_profile);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: height * 0.055,
                      width:  width * 0.55,
                      decoration: BoxDecoration(
                          color: ColorResources.ORANGE,
                          borderRadius: BorderRadius.circular(5)),
                      child: _isselected == "English"
                          ? Text("UPDATE",
                          style:
                          poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE))
                          : Text("अपडेट करें",
                          style:
                          poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE)),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ),
    );
  }

  void edit_profile_api(String fname, String nnmae, String email, String anumber, String date, String gender, String urlFile_profile) {
    HttpService.edit_profil_api(fname,nnmae,email,anumber,date,gender,urlFile_profile).then((value) {
      if (mounted) {
        setState(() {
          if (value['success'] == "true" || value['success'] == true) {
            EasyLoading.dismiss();

          } else {
            setState(() {
            });
            Navigator.push(
                context,
           MaterialPageRoute(builder: (context) {
             return home();
           },));

            EasyLoading.dismiss();
          }
        });
      }
    });
  }



  Future get_profile_image(ImageSource sourcepath) async {
    final ImagePicker imagePicker = new ImagePicker();
    final XFile? pickedFile =
    await imagePicker.pickImage(source: sourcepath, imageQuality: 50);
    File? file = File(imageFile_profile.path);
    if (pickedFile != null) {
    CroppedFile? cropped = (await imagecropp_profile.cropImage(
        sourcePath: pickedFile!.path,
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
          profile_file = File(cropped.path);
          File_Upload_Profile(File(cropped.path));
          print(profile_file);
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
}
