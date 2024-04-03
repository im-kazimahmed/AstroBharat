import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
import '../profile_proof_screen/profile_proof_screen.dart';

class account_detaile_page extends StatefulWidget {
  bool st;
  List<dynamic> user_detali;
  account_detaile_page(this.st,this.user_detali);


  @override
  State<account_detaile_page> createState() => _account_detaile_pageState();
}

class _account_detaile_pageState extends State<account_detaile_page> {

  TextEditingController pancard_controller = TextEditingController();
  TextEditingController aadhar_controller = TextEditingController();
  TextEditingController account_number_controller = TextEditingController();
  TextEditingController ifsc_controller = TextEditingController();
  TextEditingController holder_name_controller = TextEditingController();
  TextEditingController bank_controller = TextEditingController();

  FocusNode pancard_focus = FocusNode();
  FocusNode aadhar_focus = FocusNode();
  FocusNode account_number_focus = FocusNode();
  FocusNode ifsc_focus = FocusNode();
  FocusNode holder_name_focus = FocusNode();
  FocusNode bank_focus = FocusNode();

  // GOV proof  image piker

  File imageFile_proof = File("");
  ImageCropper imagecropp_proof = ImageCropper();
  File proof_file = File("");
  String URLFile_proof = '';
  bool imglod_proof = true;


  late List payment = language == "English" ? ["Current Account", "Saving Account"] : ["चालू खाता","बचत खाता"];
  // late String selected =  language == "English" ? "Select Account" : "खाता चुनें ";
  String ? selected ;

  String language = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    language = PreferenceUtils.getString("language");
    if(widget.st==true)
      {

      }
    else{
      pancard_controller.text=widget.user_detali[0].pancard;
      aadhar_controller.text=widget.user_detali[0].aadharCard;
      account_number_controller.text=widget.user_detali[0].bankAddNumber;
      account_number_controller.text=widget.user_detali[0].bankAddNumber;
      selected=widget.user_detali[0].accType;
      // language=widget.user_detali[0].accType;
      ifsc_controller.text=widget.user_detali[0].IFSCCode;
      holder_name_controller.text=widget.user_detali[0].accHolderName;
      bank_controller.text=widget.user_detali[0].bankName;
    }
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
              image: DecorationImage(image: AssetImage(Images.Splash_Screen,),fit: BoxFit.fill)
            ),
            child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowGlow();
                  return true;
                },
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Container(
                    width: width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage(Images.Splash_Screen,),fit: BoxFit.fill)
                    ),
                    child: Column(children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * 0.13,
                          child: Image.asset(
                              Images.Astrobharat_logo),
                        )
                      ],
                    ),

                    // Gov.proof image
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
                                                      get_proof_image(
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
                                                      child: SizedBox(
                                                        height: height * 0.06,
                                                        width: width * 0.15,
                                                        child: const Icon(Icons.photo,size: 40,color: ColorResources.ORANGE,),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      get_proof_image(
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
                            child: imglod_proof
                                ? CircleAvatar(
                                backgroundColor: ColorResources.WHITE,
                                radius: 50.0,
                                child: Image.asset(Images.card))
                                : Stack(
                              alignment:
                              AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                  NetworkImage("${AppConstants.IMAGE_VIEW}"+URLFile_proof),
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
                            "Gov.Proof",
                            style: poppinsBold.copyWith(
                                color: ColorResources.BLACK,
                                fontSize: 17),
                          )
                              : Text(
                            "सरकारी सबूत",
                            style: poppinsBold.copyWith(
                                color: ColorResources.BLACK,
                                fontSize: 17),
                          ),
                        )
                      ],
                    ),

                    //pan card filed

                    SizedBox(
                      height: height * 0.04,
                    ),
                    Container(
                      height: 52,
                      width: width-50,
                      margin: const EdgeInsets.only(left: 25,right: 25,top: 15),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(5)),

                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        maxLength: 10,
                        style:
                        poppinsBold.copyWith(fontSize: 17),
                        controller: pancard_controller,
                        // textCapitalization: capitalization,
                        focusNode: pancard_focus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context)
                              .requestFocus(aadhar_focus);
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Image(image: AssetImage(Images.card)),
                          counterText: "",
                          hintText: language == "English"
                              ? "Pan Card Number (Optional)"
                              : "पैन कार्ड नंबर (वैकल्पिक)",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          hintStyle: poppinsBold.copyWith(
                              fontSize: 16, color: Colors.black38),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.transparent)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.transparent)),
                        ),
                      ),
                    ),

                    //aadharcard filed

                    Container(
                      height: 52,
                      width: width-50,
                      margin: const EdgeInsets.only(left: 25,right: 25,top: 15),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        maxLength: 12,
                        style:
                        poppinsBold.copyWith(fontSize: 17),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: aadhar_controller,
                        // textCapitalization: capitalization,
                        focusNode: aadhar_focus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context)
                              .requestFocus(account_number_focus);
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Image(image: AssetImage(Images.card)),
                          counterText: "",
                          hintText: language == "English"
                              ? "Aadhar Number (Optional)"
                              : "आधार नंबर (वैकल्पिक)",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          hintStyle: poppinsBold.copyWith(
                              fontSize: 16, color: Colors.black38),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.transparent)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.transparent)),
                        ),
                      ),
                    ),

                    //account number filed

                    Container(
                      height: 50,
                      width: width-50,
                      margin: const EdgeInsets.only(left: 25,right: 25,top: 15),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(5)),

                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        style: poppinsBold.copyWith(fontSize: 17),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: account_number_controller,
                        // textCapitalization: capitalization,
                        focusNode: account_number_focus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context)
                              .requestFocus(ifsc_focus);
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Image(image: AssetImage(Images.aadhar_card_icon)),
                          counterText: "",
                          hintText: language == "English"
                              ? "Bank Account number"
                              : "बैंक खाता संख्या",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          hintStyle: poppinsBold.copyWith(
                              fontSize: 18, color: Colors.black38),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.transparent)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.transparent)),
                        ),
                      ),
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            width: width-50,
                            margin: const EdgeInsets.only(left: 25,right: 25,top: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1),

                            ),
                            child: DropdownButtonHideUnderline(
                              child: Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: DropdownButton(
                                  hint: Text(
                                    language == "English" ? "Select Account" : "खाता चुनें ",
                                    style: poppinsBold.copyWith(
                                        color: Colors.black),
                                  ),
                                  // Not necessary for Option 1
                                  value: selected,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selected = newValue as String;
                                    });
                                  },
                                  items: payment.map((location) {
                                    return DropdownMenuItem(
                                      value: location,
                                      child: Text(
                                        location,
                                        style: poppinsBold.copyWith(fontSize: 17,
                                            color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //IFSC code filed

                    TextFieldCustom(ifsc_controller,language == "English" ? "IFSC Code" : "आईएफएससी कोड", TextInputType.text, 1, ifsc_focus, holder_name_focus, TextInputAction.next, false, null, Icons.lock),

                    // Account holder name

                    TextFieldCustom(holder_name_controller, language == "English" ? "Account Holder Name" : "खाता धारक का नाम", TextInputType.text, 1, holder_name_focus, bank_focus, TextInputAction.next, false, 1000, Icons.person),

                    // Bank Name

                    TextFieldCustom(bank_controller, language == "English" ? "Bank Name" : "बैंक का नाम", TextInputType.text, 1, bank_focus, null, TextInputAction.done, false, 1000, Icons.account_balance),

                    SizedBox(height: height * 0.03,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            print(selected);
                            if(URLFile_proof.isEmpty) {
                              language == "English" ?  AppConstants.show_toast("Enter Gov.Proof") : AppConstants.show_toast("सरकारी सबूत दर्ज करें");
                            }
                            // else if(pancard_controller.text.isEmpty){
                            //   language == "English" ?  AppConstants.show_toast("Enter Pancard Number") : AppConstants.show_toast("पैनकार्ड नंबर दर्ज करें");
                            // }
                            else if(pancard_controller.text.isNotEmpty && pancard_controller.text.length < 10) {
                              language == "English" ?  AppConstants.show_toast("Please Enter Valid Pan card Number") : AppConstants.show_toast("कृपया मान्य पैनकार्ड नंबर दर्ज करें");
                            }
                            // else if( aadhar_controller.text.isEmpty){
                            //   language == "English" ?  AppConstants.show_toast("Enter Aadhaar card Number") : AppConstants.show_toast("आधार कार्ड संख्या दर्ज करें");
                            // }
                            else if(aadhar_controller.text.isNotEmpty && aadhar_controller.text.length < 12) {
                              language == "English" ?  AppConstants.show_toast("Please Enter Valid 12 Digit Aadhaar card Number") : AppConstants.show_toast("कृपया मान्य आधार कार्ड नंबर दर्ज करें");
                            }
                            else if(account_number_controller.text.isEmpty){
                              language == "English" ?  AppConstants.show_toast("Enter Account Number") : AppConstants.show_toast("खाता संख्या दर्ज करें");
                            }
                            else if(selected==null){
                              language == "English" ?  AppConstants.show_toast("Please Select Account") : AppConstants.show_toast("कृपया खाता चुनेंं");
                            }
                            else if( ifsc_controller.text.isEmpty ){
                              language == "English" ?  AppConstants.show_toast("Enter IFSC COD") : AppConstants.show_toast("आईएफ़एससी कोड दर्ज करें");
                            }
                            else if( holder_name_controller.text.isEmpty){
                              language == "English" ?  AppConstants.show_toast("Enter Account Holder Name") : AppConstants.show_toast("खाता धारक का नाम दर्ज करें");
                            }
                            else if(bank_controller.text.isEmpty){
                              language == "English" ?  AppConstants.show_toast("Enter Bank Name") : AppConstants.show_toast("बैंक का नाम दर्ज करें");
                            }
                            else{
                              if(widget.st==true){

                                PreferenceUtils.setString("pancard_number", pancard_controller.text);
                                PreferenceUtils.setString("aadhar_number", aadhar_controller.text);
                                PreferenceUtils.setString("account_number", account_number_controller.text);
                                PreferenceUtils.setString("account_type", selected!);
                                PreferenceUtils.setString("ifsc_code", ifsc_controller.text);
                                PreferenceUtils.setString("holder_name", holder_name_controller.text);
                                PreferenceUtils.setString("bank_name", bank_controller.text);
                                PreferenceUtils.setString("gov.proof", URLFile_proof);




                                print("------------------------${  PreferenceUtils.getString("pancard_number")}");
                                print("------------------------${  PreferenceUtils.getString("aadhar_number")}");
                                print("------------------------${  PreferenceUtils.getString("account_number")}");
                                print("------------------------${  PreferenceUtils.getString("account_type")}");
                                print("------------------------${  PreferenceUtils.getString("ifsc_code")}");
                                print("------------------------${  PreferenceUtils.getString("holder_name")}");
                                print("------------------------${  PreferenceUtils.getString("bank_name")}");

                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return const profile_proof_page();
                                },));
                              }
                              else{

                                EasyLoading.show();
                                HttpService.edit_bank_detail_api( pancard_controller.text, aadhar_controller.text,account_number_controller.text,selected!,ifsc_controller.text,holder_name_controller.text,bank_controller.text).then((value) {
                                  if (mounted) {
                                    setState(() {
                                      print(value['success']);
                                      if (value['success'] ==
                                          "true") {
                                        EasyLoading.dismiss();
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return const home();
                                              },
                                            ));
                                      }
                                    });
                                  }
                                });
                              }


                            }

                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: height * 0.055,
                            width: width * 0.55,
                            decoration: BoxDecoration(
                                color: ColorResources.ORANGE,
                                borderRadius:
                                BorderRadius.circular(5)),
                            child: language == "English"
                                ?widget.st==true? Text("Next",
                                style: poppinsBold.copyWith(
                                    fontSize: 17,color: ColorResources.WHITE)): Text("Update",
                                style: poppinsBold.copyWith(
                                    fontSize: 17,color: ColorResources.WHITE))
                                : Text("अगला",
                                style: poppinsBold.copyWith(
                                    fontSize: 17,color: ColorResources.WHITE)),
                          ),
                        )
                      ],
                    ),
                  ],),),


                ],
              ),
            ),
          ),
        )
    );
  }

  // proof image croper
  Future get_proof_image(ImageSource sourcepath) async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? pickedFile =
    await imagePicker.pickImage(source: sourcepath, imageQuality: 50);
    File? file = File(imageFile_proof.path);
    if (pickedFile != null) {
      CroppedFile? cropped = (await imagecropp_proof.cropImage(
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
          proof_file=File(cropped.path);
          print("Profile_Pic:::::::$proof_file");
          EasyLoading.show();
          File_Upload_proof(File(cropped.path));
        }
      });
    }
    return file;
  }

  File_Upload_proof(File fileName) {
    HttpService.file_upload_image(fileName).then((res) {
      setState(() {
        if (res.statusCode == 200) {
          res.stream.transform(utf8.decoder).listen((value) {
            Map<String, dynamic> data = jsonDecode(value);
            URLFile_proof = data['image'];
            print('profile_url::::$URLFile_proof');
            imglod_proof = false;
            EasyLoading.dismiss();
          });
        } else {
          throw Exception('Failed to load post');
        }
      });
    }).catchError((error) {});
  }
}
