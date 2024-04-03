import 'package:astrobharat/Screen/home_screen/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../Chat/helper/helper_function.dart';
import '../../Chat/service/auth_service.dart';
import '../../HttpService/HttpService.dart';
import '../../HttpService/model/Country_code_Model.dart';
import '../../utill/app_constants.dart';
import '../../utill/color_resources.dart';
import '../../utill/images.dart';
import '../../utill/share_preferences.dart';
import '../../utill/styles.dart';
import '../register_screen/register_screen.dart';
import 'business_detail.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  List<Data> country_code_list = List.empty(growable: true);
  List<Data> temp_country_code_list = List.empty(growable: true);

  TextEditingController Mobile_Controller = TextEditingController();
  TextEditingController Password_controller = TextEditingController();
  TextEditingController Search_controller = TextEditingController();
  FocusNode password_focus = FocusNode();
  FocusNode Mobile_focus = FocusNode();
  bool passwoed_eye = true, islode = false, check = false;

  String device_id = "", _isselected = "English";
  AuthService authService = AuthService();

  int? selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    country_code_api();
    device_id = "123";
  }

  country_code_api() {
    HttpService.country_code().then(
      (value) {
        if (mounted) {
          setState(
            () {
              print(value['success']);
              if (value['success'] == true || value['success'] == "true") {
                var values = CountryCodeModel.fromJson(value).data;
                country_code_list.addAll(values);
                temp_country_code_list.addAll(values);
                print(country_code_list.length);
              }
              islode = true;
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final st = MediaQuery.of(context).padding.top;
    final tbody = height - st;

    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () => AppConstants.onWillPop(context, _isselected),
          child: Container(
            height: height * 0.9635,
            width: width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.Splash_Screen), fit: BoxFit.fill)),
            child: islode
                ? NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (notification) {
                      notification.disallowGlow();
                      return true;
                    },
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        Container(
                          // height: height * 0.9635,
                          width: width,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Images.Splash_Screen),
                                  fit: BoxFit.fill)),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: height * 0.030, left: width * 0.025),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    _isselected == "English"
                                        ? "\tLogin"
                                        : "\tलॉग इन",
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK,
                                        fontSize: 30)),
                              ),
                              SizedBox(
                                height: height * 0.090,
                              ),
                              Row(children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Radio(
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
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
                                        print(value); //selected value
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
                                      _isselected == "English"
                                          ? "English"
                                          : "अंग्रेज़ी",
                                      style: poppinsBold.copyWith(
                                          fontSize: 16,
                                          color: ColorResources.BLACK),
                                    ),
                                  ),
                                ),
                                Radio(
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
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
                                      print(value); //selected value
                                    }),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isselected = "Hindi";
                                      });
                                    },
                                    child: Text(
                                      _isselected == "English"
                                          ? "Hindi"
                                          : "हिंदी",
                                      style: poppinsBold.copyWith(
                                          fontSize: 16,
                                          color: ColorResources.BLACK),
                                    ),
                                  ),
                                ),
                              ]),
                              Container(
                                margin: EdgeInsets.only(
                                    top: height * 0.005, left: height * 0.025),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    _isselected == "English"
                                        ? '\tMobile No:'
                                        : "\tमोबाइल नंबर",
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK,
                                        fontSize: 20)),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 25, right: 15, top: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(width: 1),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        _showDialog(
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
                                                  fontSize: 15,
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.only(
                                          top: 5, right: 25),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        maxLines: 1,
                                        onFieldSubmitted: (v) {
                                          FocusScope.of(context)
                                              .requestFocus(password_focus);
                                        },
                                        style:
                                            poppinsBold.copyWith(fontSize: 14),
                                        controller: Mobile_Controller,
                                        focusNode: Mobile_focus,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 12.0,
                                                  horizontal: 15),
                                          hintStyle: poppinsBold.copyWith(
                                              fontSize: 16),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: ColorResources
                                                          .BLACK)),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: ColorResources
                                                          .BLACK)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 10, left: height * 0.025),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    _isselected == "English"
                                        ? '\tPassword:'
                                        : "\tपासवर्ड",
                                    style: poppinsMedium.copyWith(
                                        color: ColorResources.BLACK,
                                        fontSize: 20)),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10)),
                                margin: const EdgeInsets.only(
                                    left: 25, top: 5, right: 25),
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.text,
                                  // inputFormatters: <TextInputFormatter>[
                                  //   FilteringTextInputFormatter.digitsOnly
                                  // ],
                                  maxLines: 1,
                                  // onFieldSubmitted: (v) {
                                  //   FocusScope.of(context).requestFocus(conform_password_focus);
                                  // },
                                  obscureText: passwoed_eye,
                                  style: poppinsBold.copyWith(fontSize: 14),
                                  controller: Password_controller,
                                  focusNode: password_focus,
                                  textInputAction: TextInputAction.next,

                                  decoration: InputDecoration(
                                    counterText: "",
                                    // hintText:  _isselected == "English"?"Password":"पासवर्ड",
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
                                    hintStyle:
                                        poppinsBold.copyWith(fontSize: 16),
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
                              // Container(
                              //   margin: EdgeInsets.only(top: height * 0.030, left: width * 0.025),
                              //   alignment: Alignment.centerLeft,
                              //   child: Text(' Password:',
                              //       style: poppinsMedium.copyWith(
                              //           color: ColorResources.BLACK,
                              //           fontSize:20 )),
                              // ),
                              // TextFieldCustom(
                              //     Password_controller,
                              //     "",
                              //     TextInputType.text,
                              //     1,
                              //     password_focus,
                              //     null,
                              //     TextInputAction.done,
                              //     false,
                              //     100000,
                              //     null),
                              SizedBox(
                                height: height * 0.020,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    activeColor: ColorResources.ORANGE,
                                    side: const BorderSide(
                                      color: ColorResources.BLACK,
                                      // width: 2,
                                    ),
                                    value: check,
                                    onChanged: (value) {
                                      setState(() {
                                        check = value!;
                                      });
                                    },
                                  ),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      width: width * 0.8,
                                      // color: Colors.cyan,
                                      child: Text.rich(
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          TextSpan(
                                              text: _isselected == "English"
                                                  ? 'By Creating An Account, You Agree To Our '
                                                  : 'एक खाता बनाकर, आप हमारे लिए सहमति देते हैं',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: ColorResources.BLACK,
                                                  fontWeight: FontWeight.w600),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: _isselected ==
                                                            "English"
                                                        ? " Terms of use"
                                                        : ' उपयोग की शर्तें',
                                                    style: poppinsBold.copyWith(
                                                      fontSize: 14,
                                                      color:
                                                          ColorResources.ORANGE,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                                return business_detail(
                                                                    0,
                                                                    _isselected ==
                                                                            "English"
                                                                        ? " Terms and Condition"
                                                                        : ' उपयोग की शर्तें');
                                                              },
                                                            ));
                                                          }),
                                                TextSpan(
                                                    text:
                                                        _isselected == "English"
                                                            ? " and "
                                                            : ' और ',
                                                    style: poppinsBold.copyWith(
                                                        fontSize: 14,
                                                        color: ColorResources
                                                            .BLACK,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: _isselected ==
                                                                  "English"
                                                              ? "Privacy Policy"
                                                              : 'गोपनीयता',
                                                          style: poppinsBold
                                                              .copyWith(
                                                            fontSize: 14,
                                                            color:
                                                                ColorResources
                                                                    .ORANGE,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                          ),
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                                      return business_detail(
                                                                          1,
                                                                          _isselected == "English"
                                                                              ? "Privacy Policy"
                                                                              : 'गोपनीयता');
                                                                    },
                                                                  ));
                                                                })
                                                    ])
                                              ]))),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  AppConstants.closeKeyboard();
                                  if (Mobile_Controller.text.isEmpty) {
                                    AppConstants.show_toast(
                                        _isselected == "English"
                                            ? "Please Enter Mobile Number"
                                            : "कृपया मोबाइल नंबर दर्ज करें");
                                  } else if (Password_controller.text.isEmpty) {
                                    AppConstants.show_toast(
                                        _isselected == "English"
                                            ? "Please Enter Password"
                                            : "कृपया पासवर्ड दर्ज करें");
                                  } else if (check == false) {
                                    AppConstants.show_toast(_isselected ==
                                            "English"
                                        ? "Please Select Privacy Policy and Terms Of Use"
                                        : "कृपया गोपनीयता नीति और उपयोग की शर्तें चुनें");
                                  } else {
                                    if (selected == null || selected == "") {
                                      selected = 91;
                                      EasyLoading.show();
                                      check_number_api(Mobile_Controller.text);
                                    } else {
                                      EasyLoading.show();
                                      check_number_api(Mobile_Controller.text);
                                    }
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: height * 0.030,
                                      left: width * 0.24,
                                      right: width * 0.24),
                                  padding: EdgeInsets.only(
                                      top: height * 0.015,
                                      bottom: height * 0.015),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorResources.ORANGE,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                      _isselected == "English"
                                          ? "Login"
                                          : "लॉग इन",
                                      style: poppinsMedium.copyWith(
                                          color: ColorResources.WHITE,
                                          fontSize: 20)),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return const register_page();
                                          },
                                        ));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(20),
                                        height: height * 0.055,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: ColorResources.SKY_PINK,
                                                width: 2)),
                                        child: _isselected == "English"
                                            ? Text(
                                                "Don't have an account ? Sign up",
                                                style: poppinsBold.copyWith(
                                                    color: ColorResources.BLACK,
                                                    fontSize: 15.5),
                                              )
                                            : Text(
                                                "खाता नहीं है ? खाता बनाएं",
                                                style: poppinsBold.copyWith(
                                                    color: ColorResources.BLACK,
                                                    fontSize: 16.5),
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: height * 0.1,
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      ),
    );
  }

  check_number_api(String number) async {
    HttpService.check_numbar_api(number).then((value) {
      if (mounted) {
        setState(() {
          if (value['success'] == "true" || value['success'] == true) {
            PreferenceUtils.setString("language", _isselected);
            PreferenceUtils.setString("number", Mobile_Controller.text);
            // Navigator.push(
            //     context,
            //    MaterialPageRoute(builder: (context) => otp_page(true),));
            login_api();
            //
            // EasyLoading.dismiss();
          } else {
            EasyLoading.dismiss();
            _isselected == "English"
                ? AppConstants.show_toast("Mobile No Not Registered.")
                : AppConstants.show_toast("मोबाइल नंबर पंजीकृत नहीं है। ");
          }
        });
      }
    });
  }

  void login_api() {
    HttpService.login_api(Mobile_Controller.text, device_id,
            Password_controller.text, selected!)
        .then((value) {
      if (mounted) {
        setState(() {
          if (value['success'] == "true" || value['success'] == true) {
            PreferenceUtils.setbool("login", true);
            // PreferenceUtils.setString("country_code", "$selected");
            PreferenceUtils.setString("token", value['token']);
            PreferenceUtils.setString("mo_no", value['data']['mo_no']);
            print("mo_no::::::::::::${PreferenceUtils.getString("mo_no")}");
            PreferenceUtils.setString("pass", Password_controller.text);

            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const home();
              },
            ));
            //
            EasyLoading.dismiss();
          } else {
            EasyLoading.dismiss();
            _isselected == "English"
                ? AppConstants.show_toast(
                    "Check Number , Country Code And Password")
                : AppConstants.show_toast("चक नंबर और पासवर्ड");
          }
        });
      }
    });
  }

  _showDialog({required double width, height}) async {
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
                                  selected = country_code_list[index].phonecode;
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
                            Divider(color: Colors.black38),
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
}
