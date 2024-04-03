import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../HttpService/HttpService.dart';
import '../../HttpService/model/Country_code_Model.dart';
import '../../utill/app_constants.dart';
import '../../utill/color_resources.dart';
import '../../utill/images.dart';
import '../../utill/share_preferences.dart';
import '../../utill/styles.dart';
import '../login/business_detail.dart';
import 'category_screen.dart';

class register_page extends StatefulWidget {
  const register_page({Key? key}) : super(key: key);

  @override
  State<register_page> createState() => _register_pageState();
}

class _register_pageState extends State<register_page> {
  TextEditingController Fname_controller = TextEditingController();
  TextEditingController Nname_controller = TextEditingController();
  TextEditingController Email_controller = TextEditingController();
  TextEditingController Number_controller = TextEditingController();
  TextEditingController Anumber_controller = TextEditingController();
  TextEditingController DateInput_controller = TextEditingController();
  TextEditingController Password_controller = TextEditingController();
  TextEditingController Conform_Password_controller = TextEditingController();

  bool islode = true;
  List<Data> country_code_list = List.empty(growable: true);
  List<Data> temp_country_code_list = List.empty(growable: true);
  int? selected;
  int? selected_alt;

  FocusNode Fname_focus = FocusNode();
  FocusNode Nname_focus = FocusNode();
  FocusNode Email_focus = FocusNode();
  FocusNode Number_focus = FocusNode();
  FocusNode Anumber_focus = FocusNode();
  FocusNode dateInput_focus = FocusNode();
  FocusNode password_focus = FocusNode();
  FocusNode conform_password_focus = FocusNode();
  bool passwoed_eye = true;
  bool conform_passwoed_eye = true;
  bool check = false;

  String _isselected = "English";
  String gender = "Male";

  // int? selected_alt;
  String select_city = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    country_code_api();
  }

  country_code_api() {
    HttpService.country_code().then((value) {
      if (mounted) {
        setState(() {
          print(value['success']);
          if (value['success'] == true || value['success'] == "true") {
            var values = CountryCodeModel.fromJson(value).data;
            country_code_list.addAll(values);
            temp_country_code_list.addAll(values);
            print(country_code_list.length);
          }
          islode = false;
        });
      }
    });
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
        height: height,
        width: width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images.Splash_Screen), fit: BoxFit.fill)),
        child: islode
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowGlow();
                  return true;
                },
                child: ListView(
                  children: [
                    Container(
                      width: width,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Images.Splash_Screen),
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
                          // Select language button
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Row(children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Radio(
                                  fillColor: MaterialStateProperty.resolveWith(
                                      (states) {
                                    return ColorResources.BLACK;
                                  }),
                                  activeColor: ColorResources.BLACK,
                                  value: "English",
                                  groupValue: _isselected,
                                  onChanged: (value) {
                                    setState(() {
                                      _isselected = "$value";
                                    });
                                  }),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _isselected = "English";
                                  });
                                },
                                child: Text(
                                  "English",
                                  style: poppinsBold.copyWith(
                                      fontSize: 16,
                                      color: ColorResources.BLACK),
                                ),
                              ),
                            ),
                            Radio(
                                fillColor: MaterialStateProperty.resolveWith(
                                    (states) {
                                  return ColorResources.BLACK;
                                }),
                                activeColor: ColorResources.BLACK,
                                value: "Hindi",
                                groupValue: _isselected,
                                onChanged: (value) {
                                  setState(() {
                                    _isselected = "$value";
                                  });
                                }),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _isselected = "Hindi";
                                  });
                                },
                                child: Text(
                                  "Hindi",
                                  style: poppinsBold.copyWith(
                                      fontSize: 16,
                                      color: ColorResources.BLACK),
                                ),
                              ),
                            ),
                          ]),
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
                              Number_focus,
                              TextInputAction.next,
                              false,
                              1000,
                              Icons.email),

                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 25, right: 15, top: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(width: 1),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    _showDialog(
                                      s: "PHONE",
                                      width: width,
                                      height: height,
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text(
                                          selected == null
                                              ? "+91"
                                              : "+${selected}",
                                          style: poppinsBold.copyWith(
                                              fontSize: 13,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                          size: 40,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.only(top: 15, right: 25),
                                  child: TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    maxLines: 1,

                                    // onFieldSubmitted: (v) {
                                    //   FocusScope.of(context).requestFocus(Anumber_focus);
                                    // },

                                    style: poppinsBold.copyWith(fontSize: 14),
                                    controller: Number_controller,
                                    focusNode: Number_focus,
                                    textInputAction: TextInputAction.next,

                                    decoration: InputDecoration(
                                      counterText: "",
                                      hintText: _isselected == "English"
                                          ? "Phone No"
                                          : "फोन नंबर",
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 15),
                                      hintStyle:
                                          poppinsBold.copyWith(fontSize: 13),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: ColorResources.BLACK)),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: ColorResources.BLACK)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 25, right: 15, top: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(width: 1),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    _showDialog(
                                      s: "ALT",
                                      width: width,
                                      height: height
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text(
                                          selected_alt == null
                                              ? "+91"
                                              : "+${selected_alt}",
                                          style: poppinsBold.copyWith(
                                              fontSize: 13,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                          size: 40,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: const EdgeInsets.only(top: 15, right: 25),
                                  child: TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    maxLines: 1,
                                    style: poppinsBold.copyWith(fontSize: 14),
                                    controller: Anumber_controller,
                                    focusNode: Anumber_focus,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      hintText: _isselected == "English"
                                          ? "Alternate Phone (Optional)"
                                          : "वैकल्पिक फोन नंबर (वैकल्पिक)",
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 15),
                                      hintStyle:
                                          poppinsBold.copyWith(fontSize: 13),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: ColorResources.BLACK)),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: ColorResources.BLACK)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10)),
                            margin:
                                const EdgeInsets.only(left: 25, top: 15, right: 25),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context)
                                    .requestFocus(conform_password_focus);
                              },
                              obscureText: passwoed_eye,
                              style: poppinsBold.copyWith(fontSize: 14),
                              controller: Password_controller,
                              focusNode: password_focus,
                              textInputAction: TextInputAction.next,

                              decoration: InputDecoration(
                                counterText: "",
                                hintText: _isselected == "English"
                                    ? "Password"
                                    : "पासवर्ड",
                                suffixIcon: InkWell(
                                    onTap: () {
                                      if (passwoed_eye) {
                                        setState(() {
                                          passwoed_eye = false;
                                        });
                                      } else {
                                        setState(() {
                                          passwoed_eye = true;
                                        });
                                      }
                                    },
                                    child: Icon(
                                      passwoed_eye
                                          ? Icons.remove_red_eye
                                          : Icons.remove_red_eye_outlined,
                                      color: ColorResources.BLACK,
                                    )),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 15),
                                hintStyle: poppinsBold.copyWith(fontSize: 14),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: ColorResources.BLACK)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: ColorResources.BLACK)),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10)),
                            margin:
                                const EdgeInsets.only(left: 25, top: 15, right: 25),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              obscureText: conform_passwoed_eye,
                              style: poppinsBold.copyWith(fontSize: 14),
                              controller: Conform_Password_controller,
                              focusNode: conform_password_focus,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                counterText: "",
                                hintText: _isselected == "English"
                                    ? "Confirm Password"
                                    : "पासवर्ड अनुरूप करें",
                                suffixIcon: InkWell(
                                    onTap: () {
                                      if (conform_passwoed_eye) {
                                        setState(() {
                                          conform_passwoed_eye = false;
                                        });
                                      } else {
                                        setState(() {
                                          conform_passwoed_eye = true;
                                        });
                                      }
                                    },
                                    child: Icon(
                                      conform_passwoed_eye
                                          ? Icons.remove_red_eye
                                          : Icons.remove_red_eye_outlined,
                                      color: ColorResources.BLACK,
                                    )),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 15),
                                hintStyle: poppinsBold.copyWith(fontSize: 14),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: ColorResources.BLACK)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: ColorResources.BLACK)),
                              ),
                            ),
                          ),
                          // Date select
                          Row(
                            children: [
                              Container(
                                height: height * 0.059,
                                width: width - 50,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                margin: const EdgeInsets.only(
                                    left: 25, top: 15, right: 25),
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
                                    FilteringTextInputFormatter.digitsOnly,
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
                                    prefixIcon: const Icon(
                                      Icons.date_range,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    counterText: "",
                                    hintText: _isselected == "English"
                                        ? "Date of Birth"
                                        : "जन्म की तारीख",
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0,
                                      horizontal: 15,
                                    ),
                                    hintStyle: poppinsBold.copyWith(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.transparent,
                                      ),
                                    ),
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
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Radio(
                                  fillColor: MaterialStateProperty.resolveWith(
                                      (states) {
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
                                      fontSize: 16,
                                      color: ColorResources.BLACK),
                                ),
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            Container(
                              child: Radio(
                                  fillColor: MaterialStateProperty.resolveWith(
                                      (states) {
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
                                      fontSize: 16,
                                      color: ColorResources.BLACK),
                                ),
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                          ]),

                          Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [

                            Checkbox(
                              activeColor: ColorResources.ORANGE,
                              side:  const BorderSide(
                                color: ColorResources.BLACK,
                                // width: 2,
                              ),
                              value: check,
                              onChanged:(value) {
                                setState(() {
                                  check=value!;
                                });
                              },
                            ),
                            Container(
                                alignment: Alignment.topLeft,
                                width: width*0.8,
                                // color: Colors.cyan,
                                child: Text.rich(
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    TextSpan(
                                        text: _isselected=="English"?'By Creating An Account, You Agree To Our ':'एक खाता बनाकर, आप हमारे लिए सहमति देते हैं', style: const TextStyle(
                                        fontSize: 14, color: ColorResources.BLACK,fontWeight: FontWeight.w600
                                    ),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: _isselected=="English"?" Terms of use":' उपयोग की शर्तें', style: poppinsBold.copyWith(
                                            fontSize: 14, color: ColorResources.ORANGE,fontWeight: FontWeight.w600,decoration: TextDecoration.underline,
                                          ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                    return business_detail(0, _isselected=="English"?" Terms and Condition":' उपयोग की शर्तें');
                                                  },));
                                                }
                                          ),
                                          TextSpan(
                                              text: _isselected=="English"?" and ":' और ', style: poppinsBold.copyWith(
                                              fontSize: 14, color: ColorResources.BLACK,fontWeight: FontWeight.w600
                                          ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: _isselected=="English"?"Privacy Policy":'गोपनीयता', style: poppinsBold.copyWith(
                                                  fontSize: 14, color: ColorResources.ORANGE,fontWeight: FontWeight.w600,decoration: TextDecoration.underline,
                                                ),
                                                    recognizer: TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                          return business_detail(1,_isselected=="English"?"Privacy Policy":'गोपनीयता');
                                                        },));


                                                      }
                                                )
                                              ]
                                          )
                                        ]
                                    )
                                )
                            ),
                          ],),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          // next button

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  String FNAME = Fname_controller.text;
                                  String NNMAE = Nname_controller.text;
                                  String EMAIL = Email_controller.text;
                                  String NUMBER = Number_controller.text;
                                  String ANUMBER = Anumber_controller.text;
                                  String DATE = DateInput_controller.text;
                                  String PASSWORD = Password_controller.text;
                                  String CONFORM_PASSWORD =
                                      Conform_Password_controller.text;

                                  if (FNAME.isEmpty) {
                                    _isselected == "English"
                                        ? AppConstants.show_toast(
                                            "Please Enter Full Name")
                                        : AppConstants.show_toast(
                                            "कृपया पूरा नाम दर्ज करें");
                                  } else if (NNMAE.isEmpty) {
                                    _isselected == "English"
                                        ? AppConstants.show_toast(
                                            "Please Enter Nick Name")
                                        : AppConstants.show_toast(
                                            "कृपया उपनाम दर्ज करें");
                                  } else if (EMAIL.isEmpty) {
                                    _isselected == "English"
                                        ? AppConstants.show_toast(
                                            "Please Enter Email")
                                        : AppConstants.show_toast(
                                            "कृपया ईमेल दर्ज करें");
                                  } else if (AppConstants.isNotValid(EMAIL)) {
                                    _isselected == "English"
                                        ? AppConstants.show_toast(
                                            "Please Enter Valid Email")
                                        : AppConstants.show_toast(
                                            "कृपया वैध ईमेल दर्ज़ करें");
                                  } else if (NUMBER.isEmpty) {
                                    _isselected == "English"
                                        ? AppConstants.show_toast(
                                            "Please Enter Phone Number")
                                        : AppConstants.show_toast(
                                            "कृपया फोन नंबर दर्ज करें");
                                  }
                                  // else if (ANUMBER.isEmpty) {
                                  //   _isselected == "English"
                                  //       ? AppConstants.show_toast(
                                  //           "Please Enter Alternate Phone Number")
                                  //       : AppConstants.show_toast(
                                  //           "कृपया वैकल्पिक फोन नंबर दर्ज करें");
                                  // }
                                  else if (PASSWORD.isEmpty) {
                                    _isselected == "English"
                                        ? AppConstants.show_toast(
                                            "Please Enter Password")
                                        : AppConstants.show_toast(
                                            "कृपया पासवर्ड दर्ज करें");
                                  } else if (CONFORM_PASSWORD.isEmpty) {
                                    _isselected == "English"
                                        ? AppConstants.show_toast(
                                            "Please Enter Confirm Password")
                                        : AppConstants.show_toast(
                                            "कृपया अनुरूप पासवर्ड दर्ज करें");
                                  } else if (PASSWORD != CONFORM_PASSWORD) {
                                    _isselected == "English"
                                        ? AppConstants.show_toast(
                                            "Please Enter Sem Password And Confirm Password")
                                        : AppConstants.show_toast(
                                            "कृपया सेम पासवर्ड दर्ज करें और पासवर्ड की पुष्टि करें");
                                  } else if (DATE.isEmpty) {
                                    _isselected == "English"
                                        ? AppConstants.show_toast(
                                            "Please Enter Date Of Birth")
                                        : AppConstants.show_toast(
                                            "कृपया जन्म तिथि दर्ज करें");
                                  }


                                /*  else if (selected == "" ||
                                      selected == null) {
                                    _isselected == "English"
                                        ? AppConstants.show_toast(
                                            "please enter country code")
                                        : AppConstants.show_toast(
                                            "कृपया देश कोड दर्ज करें");
                                  }*/   else if (check == false) {
                                    AppConstants.show_toast(
                                        _isselected == "English"
                                            ? "Please Select Privacy Policy and Terms Of Use":"कृपया गोपनीयता नीति और उपयोग की शर्तें चुनें");
                                  }
                                  else {
                                    if(selected==null)
                                      {
                                        setState(() {
                                          selected=91;
                                        });
                                        EasyLoading.show();
                                        check_number_api(NUMBER);
                                      }
                                    else if(selected_alt==null){
                                      setState(() {
                                        selected_alt=91;
                                      });
                                      EasyLoading.show();
                                      check_number_api(NUMBER);
                                    }
                                    else {
                                      EasyLoading.show();
                                      check_number_api(NUMBER);
                                    }

                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: height * 0.055,
                                  width: width * 0.55,
                                  decoration: BoxDecoration(
                                      color: ColorResources.ORANGE,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: _isselected == "English"
                                      ? Text("Next",
                                          style: poppinsBold.copyWith(
                                              fontSize: 17,
                                              color: ColorResources.WHITE))
                                      : Text("अगला",
                                          style: poppinsBold.copyWith(
                                              fontSize: 17,
                                              color: ColorResources.WHITE)),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  width: width,
                                  child: Text.rich(
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      TextSpan(
                                          text: _isselected=="English"?"Already have an account ? ":'क्या आपके पास पहले से एक खाता मौजूद है ?', style: const TextStyle(
                                          fontSize: 14, color: ColorResources.BLACK,fontWeight: FontWeight.w600
                                      ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: _isselected=="English"?"Sign in":'दाखिल करना', style: poppinsBold.copyWith(
                                              fontSize: 14, color: ColorResources.ORANGE,fontWeight: FontWeight.w600,decoration: TextDecoration.underline,
                                            ),
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = () {
                                                    Navigator.pop(context);
                                                  }
                                            ),
                                          ]
                                      )
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    ));
  }

  check_number_api(String number) async {
    HttpService.check_numbar_api(number).then((value) {
      if (mounted) {
        setState(() {
          if (value['success'] == "true" || value['success'] == true) {
            EasyLoading.dismiss();
            _isselected == "English"
                ? AppConstants.show_toast("Number Already Exists")
                : AppConstants.show_toast("फ़ोन नंबर पहले से मौजूद है");
          } else {
            setState(() {
              PreferenceUtils.setString("language", _isselected);
              PreferenceUtils.setString("Fname", Fname_controller.text);
              PreferenceUtils.setString("Nname", Nname_controller.text);
              PreferenceUtils.setString("Email", Email_controller.text);
              PreferenceUtils.setString("number", Number_controller.text);
              PreferenceUtils.setString("ANumber", Anumber_controller.text);
              PreferenceUtils.setString("Date", DateInput_controller.text);
              PreferenceUtils.setString("Gender", gender);
              PreferenceUtils.setString("Password", Password_controller.text);
              PreferenceUtils.setString("country_code", "$selected");

              print(PreferenceUtils.getString("language"));
              print(PreferenceUtils.getString("Fname"));
              print(PreferenceUtils.getString("Nname"));
              print(PreferenceUtils.getString("Email"));
              print(PreferenceUtils.getString("number"));
              print(PreferenceUtils.getString("ANumber"));
              print(PreferenceUtils.getString("Date"));
              print(PreferenceUtils.getString("Gender"));
              print(PreferenceUtils.getString("Password"));
              print(PreferenceUtils.getString("country_code"));
            });
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const category_screen();
            }));

            EasyLoading.dismiss();
          }
        });
      }
    });
  }


  _showDialog({required String s, required double width, height}) async {
    await showDialog<String>(
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: StatefulBuilder(
          builder: (context, setstate) {
            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Center(
                        child: Text(
                          _isselected == "English"
                              ? "Select country code"
                              : "देश कोड चुनें",
                          textAlign: TextAlign.center,
                          style: poppinsBold.copyWith(fontSize: 22),
                        ),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: Search_controller,
                  autofocus: true,
                  onChanged: (value) {
                    setstate(() {
                      setState(() {
                        List<Data> results = [];
                        if (value.isEmpty) {
                          results = temp_country_code_list;
                        } else {
                          results = country_code_list
                              .where((artist) =>
                          artist.name
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                              artist.phonecode
                                  .toString()
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        }
                        country_code_list = results;
                      });
                    });
                  },
                  decoration: InputDecoration(
                      labelText: _isselected == "English"
                          ? 'Full Country Search'
                          : 'पूरा देश खोज',
                      hintText: _isselected == "English" ? 'Search' : 'खोज'),
                ),
                Flexible(
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: ListView.builder(
                      itemCount: country_code_list.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  s=="PHONE"   ? selected = country_code_list[index].phonecode:selected_alt= country_code_list[index].phonecode;
                                  print("city_id::::::::::$selected");
                                  Navigator.pop(context);
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 4, bottom: 4),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "+${country_code_list[index].phonecode}  ${country_code_list[index].name}",
                                        textAlign: TextAlign.center,
                                        style: poppinsBold.copyWith(fontSize: 14),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider(color: Colors.black38),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 3)
                          ],
                          borderRadius: BorderRadius.circular(3)),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 10, bottom: 10, top: 10),
                      child: Text(
                          _isselected == "English" ? "CLOSE" : 'बंद करना',
                          style: poppinsBold.copyWith(
                              fontSize: 18, color: Colors.white)),
                    )),
              ],
            );
          },
        ),
      ),
      context: context,
    );
  }

  TextEditingController Search_controller = TextEditingController();
}
