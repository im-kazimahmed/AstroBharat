import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../HttpService/HttpService.dart';
import '../../HttpService/model/City_Model.dart';
import '../../HttpService/model/Country_Model.dart';
import '../../HttpService/model/State_Model.dart';
import '../../utill/app_constants.dart';
import '../../utill/images.dart';
import '../../utill/share_preferences.dart';
import '../../utill/color_resources.dart';
import '../../utill/styles.dart';
import '../account_detaile_screen/account_detaile_screen.dart';
import '../home_screen/home_screen.dart';
import '../profile_proof_screen/profile_proof_screen.dart';

class address_page extends StatefulWidget {
  bool st;
  List<dynamic> user_detali;
  address_page(this.st, this.user_detali);


  @override
  State<address_page> createState() => _address_pageState();
}

class _address_pageState extends State<address_page> {
  bool dailog_status = true;

  TextEditingController address_controller = TextEditingController();
  TextEditingController pincode_controller = TextEditingController();
  TextEditingController digree_controller = TextEditingController();

  FocusNode address_focusNode = FocusNode();
  FocusNode pincode_focusNode = FocusNode();
  FocusNode digree_focusNode = FocusNode();

  List year = [
    "0-1",
    "1-2",
    "2-3",
    "3-4",
    "4-5",
    "5-6",
    "6-7",
    "7-8",
    "8-9",
    "10-11",
    "11-12",
    "12-13",
    "13-14",
    "14-15",
    "15-16",
    "16-17",
    "17-18",
    "18-19",
    "19-20",
    "20-21",
    "21-22",
    "23-24",
    "24-25",
    "25-26",
    "26-27",
    "27-28",
    "28-29",
    "29-30",
  ];

  late String select_year = language == "English" ? "Select Experience" : "अनुभव का चयन करें";
  late String select_country = language == "English" ? "Select Country" : "देश चुनें";
  late String select_state = language == "English" ? "Select State" : "राज्य चुनें";
  late String select_city = language == "English" ? "Select City" : "शहर चुनें";

  String language = "";


  int ? country_id;
  int ?  state_id;
  int ?  city_id;

  bool select_year_color = false;
  bool select_country_color = false;
  bool select_state_color = false;
  bool select_city_color = false;

  bool islode = true;

  List<Data> country_list = List.empty(growable: true);
  List<Data1> state_list = List.empty(growable: true);
  List<City_Data> City_list = List.empty(growable: true);

  // Select_Country_data? country_data;
  // Select_State_data? state_data;
  // Select_city_data? city_data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.st==true){

    }else{
      setState(() {
        select_year=widget.user_detali[0].experience;
        country_id=int.parse(widget.user_detali[0].country);
        state_id=int.parse(widget.user_detali[0].state);
        city_id=int.parse(widget.user_detali[0].city);
        select_country=widget.user_detali[0].countryName;
        select_state=widget.user_detali[0].stateName;
        select_city=widget.user_detali[0].cityName;
        address_controller.text=widget.user_detali[0].address;
        pincode_controller.text=widget.user_detali[0].pincode;
        digree_controller.text=widget.user_detali[0].highestDegree;
      });
    }




    lode_api();
    language = PreferenceUtils.getString("language");
     print("language::::::::::$language");
     print("language::::::::::${PreferenceUtils.getString("country_code")}");
  }

  lode_api() async {

    get() async {
      final prefs = await SharedPreferences.getInstance();
    }


    Select_Country_api();
    await Select_State_api(1);
    await Select_City_api(1);
  }
  Select_Country_api() async {
    EasyLoading.show();
    setState(() {
      country_list = List.empty(growable: true);
    });
    HttpService.select_country_api().then((value) {
      if (mounted) {
        setState(() {
          //  print(value['success']);
          if (value['success'] == "true") {
            var values = CountryModel
                .fromJson(value)
                .data;

            country_list.addAll(values);
            islode = true;
            //  print("//////////$country_list");
          }
          EasyLoading.dismiss();
        });
      }
    });
  }

  Select_State_api(int country_id) async {
    setState(() {
      state_list = List.empty(growable: true);
    });
    // Map map = {"country_id": country_id == null ? 1 : country_id};
    //  print(country_id);

    HttpService.select_state_api(country_id).then((value) {
      if (mounted) {
        setState(() {
          //  print(value['success']);
          if (value['success'] == "true") {
            var values = StateModel.fromJson(value).data1;

            state_list.addAll(values);
            //  print(state_list.length);
            islode = true;
            //  print(state_list);
          }
          EasyLoading.dismiss();
        });
      }
    });
  }

  Select_City_api(int state_id) async {
    // Map map = {"country_id": country_id == null ? 1 : country_id};
    //  print(state_id);
    setState(() {
      City_list = List.empty(growable: true);
    });
    HttpService.select_city_api(state_id).then((value) {
      if (mounted) {
        setState(() {
          //  print(value['success']);
          if (value['success'] == "true") {
            var values = CityModel.fromJson(value).City_data;
            City_list.addAll(values);
            //  print(state_list.length);
            islode = true;
            //  print(state_list);
          }
          EasyLoading.dismiss();
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return islode
        ? Scaffold(

       appBar: widget.st==true?null:AppBar(
         centerTitle: true,
         leading:IconButton(onPressed: () {
           Navigator.pop(context);
         }, icon: const Icon(Icons.arrow_back_sharp,color: ColorResources.BLACK,)),
         title: Text('Update Location',
             style: poppinsMedium.copyWith(
                 color: ColorResources.BLACK, fontSize: width*0.055)),
         backgroundColor: ColorResources.ORANGE_WHITE,
         elevation: 2,
         shape: const RoundedRectangleBorder(
           borderRadius: BorderRadius.vertical(
             bottom: Radius.circular(15),
           ),
         ),
       ),
      extendBodyBehindAppBar: true,
            body: SafeArea(
              child: Container(
                height: height * 0.9635,
                width: width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Images.Splash_Screen),
                        fit: BoxFit.fill)),
                child: NotificationListener<
                    OverscrollIndicatorNotification>(
                  onNotification: (notification) {
                notification.disallowGlow();
                return true;
                  },
                  child: ListView(
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Container(
                    width: width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Images.Splash_Screen),
                            fit: BoxFit.fill)),
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
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              _experienceshowDialog(
                                width: width,
                                height: height,
                              );
                            },
                            child: Container(
                              height: height * 0.06,
                              width: width-50,
                              margin: const EdgeInsets.only(left: 25,right: 25),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(width: 1),
                                  borderRadius:
                                  BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      size: 32,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, bottom: 2),
                                    child: Text(
                                      "${select_year}",
                                      style: poppinsBold.copyWith(
                                          color: select_year_color
                                              ? Colors.black
                                              : Colors.black38,
                                          fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Select_Country

                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              _CountryshowDialog(height, width);
                            },
                            child: Container(
                              height: height * 0.06,
                              width: width-50,
                              margin: const EdgeInsets.only(left: 25,right: 25),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(width: 1),
                                  borderRadius:
                                  BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Container(
                                      height: height * 0.04,
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Image.asset(
                                          Images.removebg)),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, bottom: 2),
                                    child: Text(
                                      "${select_country}",
                                      style: poppinsBold.copyWith(
                                          color: select_country_color
                                              ? Colors.black
                                              : Colors.black38,
                                          fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Select_State

                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              _StateshowDialog(height, width);
                            },
                            child: Container(
                              height: height * 0.06,
                              width: width-50,
                              margin: const EdgeInsets.only(left: 25,right: 25),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(width: 1),
                                  borderRadius:
                                  BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Container(
                                    height: height * 0.04,
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Icon(
                                      Icons.my_location,
                                      size: 32,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, bottom: 2),
                                    child: Text(
                                      "${select_state}",
                                      style: poppinsBold.copyWith(
                                          color: select_state_color
                                              ? Colors.black
                                              : Colors.black38,
                                          fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Select_city

                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              _CityshowDialog(height, width);
                            },
                            child: Container(
                              height: height * 0.06,
                              width: width -50,
                              margin: const EdgeInsets.only(left: 25,right: 25),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(width: 1),
                                  borderRadius:
                                  BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Container(
                                    height: height * 0.04,
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Icon(
                                      Icons.location_on,
                                      size: 32,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, bottom: 2),
                                    child: Text(
                                      "${select_city}",
                                      style: poppinsBold.copyWith(
                                          color: select_city_color
                                              ? Colors.black
                                              : Colors.black38,
                                          fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // address filed
                      TextFieldCustom(
                          address_controller,
                          language == "English" ? "Address" : "पता",
                          TextInputType.name,
                          1,
                          address_focusNode,
                          pincode_focusNode,
                          TextInputAction.next,
                          false,
                          1000,
                          Icons.location_on_outlined),
                      Container(
                        height: 52,
                        width: width-50,
                        margin: const EdgeInsets.only(left: 25,right: 25,top: 15),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(5)),

                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLines: 1,
                          maxLength: 6,
                          style:
                          poppinsBold.copyWith(fontSize: 17),
                          controller: pincode_controller,
                          // textCapitalization: capitalization,
                          focusNode: pincode_focusNode,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context)
                                .requestFocus(digree_focusNode);
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.add_location,
                              color: Colors.black,
                              size: 35,
                            ),
                            counterText: "",
                            hintText: language == "English"
                                ? "Pincode"
                                : "पिन कोड",
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
                      TextFieldCustom(
                          digree_controller,
                          language == "English"
                              ? "Highest Degree"
                              : "उच्चतम डिग्री",
                          TextInputType.name,
                          1,
                          digree_focusNode,
                          null,
                          TextInputAction.done,
                          false,
                          1000,
                          Icons.edit_note_rounded),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (select_year == "Select Experience" ||
                                  select_year == "अनुभव का चयन करें") {
                                language == "English"
                                    ? AppConstants.show_toast(
                                    "Please Select Experience")
                                    : AppConstants.show_toast(
                                    "कृपया अनुभव का चयन करें");
                              } else if (select_country ==
                                  "Select Country" ||
                                  select_country == "देश चुनें") {
                                language == "English"
                                    ? AppConstants.show_toast(
                                    "Please Select country")
                                    : AppConstants.show_toast(
                                    "कृपया देश चुनेंं");
                              } else if (select_state ==
                                  "Select State" ||
                                  select_state == "राज्य चुनें") {
                                language == "English"
                                    ? AppConstants.show_toast(
                                    "Please Select State")
                                    : AppConstants.show_toast(
                                    "कृपया राज्य चुनें");
                              }else if (select_city ==
                                  "Select City" ||
                                  select_city == "शहर चुनें") {
                                language == "English"
                                    ? AppConstants.show_toast(
                                    "Please Select City")
                                    : AppConstants.show_toast(
                                    "कृपया शहर चुनें");
                              }else if (address_controller.text.isEmpty) {
                                language == "English" ? AppConstants.show_toast("Please Enter Address") : AppConstants.show_toast("कृपया पता दर्ज करें");
                              }else if (pincode_controller.text.isEmpty) {
                                language == "English" ? AppConstants.show_toast("Please Enter Pincode") : AppConstants.show_toast("कृपया पिनकोड दर्ज करें");
                              }else if (pincode_controller.text.length < 6) {
                                language == "English" ? AppConstants.show_toast("Please Enter valid Pincode") : AppConstants.show_toast("कृपया मान्य पिनकोड दर्ज करें");
                              }else if (digree_controller.text.isEmpty) {
                                language == "English" ? AppConstants.show_toast("Please Enter digree") : AppConstants.show_toast("कृपया डिग्री दर्ज करें");
                              }
                              else{
                                if(widget.st==true){
                                  PreferenceUtils.setString("experience", select_year);
                                  PreferenceUtils.setString("country", "$country_id");
                                  PreferenceUtils.setString("state", "$state_id");
                                  PreferenceUtils.setString("city", "$city_id");
                                  PreferenceUtils.setString("address", address_controller.text);
                                  PreferenceUtils.setString("pincode", pincode_controller.text);
                                  PreferenceUtils.setString("degree", digree_controller.text);


                                  print("------------------------${  PreferenceUtils.getString("experience")}");
                                  print("------------------------${  PreferenceUtils.getString("country")}");
                                  print("------------------------${  PreferenceUtils.getString("state")}");
                                  print("------------------------${  PreferenceUtils.getString("city")}");
                                  print("------------------------${  PreferenceUtils.getString("address")}");
                                  print("------------------------${  PreferenceUtils.getString("pincode")}");
                                  print("------------------------${  PreferenceUtils.getString("degree")}");


                                  if(PreferenceUtils.getString("country_code") == "91")
                                    {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return account_detaile_page(true,[]);
                                      },));
                                    }
                                  else{
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return profile_proof_page();
                                    },));
                                  }
                                }
                                else{
                                  EasyLoading.show();
                                  HttpService.edit_address_api(select_year,country_id!,state_id!,city_id!,address_controller.text,pincode_controller.text,digree_controller.text).then((value) {
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
                                                  return home();
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
                                  color: ColorResources.ORANGE  ,
                                  borderRadius:
                                  BorderRadius.circular(5)),
                              child: widget.st==true
                                  ? Text("Next",
                                  style: poppinsBold.copyWith(
                                      fontSize: 17,color: ColorResources.WHITE))
                                  : Text("update",
                                  style: poppinsBold.copyWith(
                                      fontSize: 17,color:ColorResources.WHITE)),
                            ),
                          )
                        ],
                      ),
                    ],),
                  ),

                ],
                  ),
                ),
              ),
            ),
          )
        : Container(
            height: height,
            width: width,
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()));
  }

  _experienceshowDialog({required double width, height}) async {
    await showDialog<String>(
      builder: (context) =>  AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: StatefulBuilder(builder: (context, setstate) {
          return Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .center,
                children: [
                  language ==
                      "English"
                      ? Text(
                    "Select Experience",
                    style:
                    poppinsBold.copyWith(fontSize: 22),
                  )
                      : Text(
                    "अनुभव चुनें",
                    style:
                    poppinsBold.copyWith(fontSize: 22),
                  ),
                ],
              ),
              Flexible(
                child: SizedBox(
                  height: height,
                  width: width,
                  child: ListView.builder(
                    itemCount: year.length,
                    itemBuilder: (context, index) {return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              dailog_status = true;
                              select_year = year[index];
                              select_year_color = true;
                              Navigator.pop(context);
                            });
                          },
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: height * 0.05,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${year[index]}",
                                    style: poppinsBold.copyWith(fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          width: width,
                          color: Colors.black38,
                        )
                      ],
                    );
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(
                          () {
                        dailog_status =
                        true;
                        Navigator.pop(
                            context);
                      });
                },
                child:
                Container(
                  height: height * 0.05,
                  width: width * 0.5,
                  decoration: BoxDecoration(
                      color: Colors
                          .black,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 3)
                      ],
                      borderRadius:
                      BorderRadius.circular(3)),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 10,bottom: 10,top: 10),
                  child: Text(  language ==
                      "English"? "CLOSE":"बंद करना", style: poppinsBold.copyWith(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },),
      ), context: context,
    );
  }
  _CountryshowDialog(height,width) async {
    await showDialog<String>(
      builder: (context) =>  AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: StatefulBuilder(builder: (context, setstate) {
          return Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .center,
                children: [
                  Text(
                    language ==
                        "English"
                        ? "Select Country"
                        : "देश चुनें",
                    style: poppinsBold.copyWith(
                        fontSize:
                        22),
                  ),
                ],
              ),
              Flexible(
                child: country_list.length==0?Center(
                    child: Container(
                      height: height * 0.2,
                      width: width*0.5,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Images.no_data))),
                    )
                ): SizedBox(
                  width: width,
                  height: height,
                  child: ListView
                      .builder(
                    itemCount: country_list.length,
                    itemBuilder:
                        (context,
                        index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap:
                                () {
                              setState(() {
                                dailog_status = true;
                                select_country = country_list[index].name;
                                country_id = country_list[index].id;
                                print("language::::::::::$country_id");
                                select_country_color = true;
                                EasyLoading.show();
                                Select_State_api(country_id!);
                                Navigator.pop(context);
                              });
                            },
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${country_list[index].name}",textAlign: TextAlign.center,
                                      style: poppinsBold.copyWith(fontSize: 19),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height:
                            1,
                            width:
                            width,
                            color:
                            Colors.black38,
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    setState(
                            () {
                          dailog_status =
                          true;
                          Navigator.pop(
                              context);
                        });
                  },
                  child:
                  Container(
                    height: height *
                        0.05,
                    width: width *
                        0.5,
                    decoration: BoxDecoration(
                        color: Colors
                            .black,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 3)
                        ],
                        borderRadius:
                        BorderRadius.circular(3)),
                    alignment:
                    Alignment
                        .center,
                    margin: const EdgeInsets.only(
                        right:
                        10,
                        bottom:
                        20,
                        top:
                        10),
                    child: Text(
                        language ==
                            "English"?"CLOSE":'बंद करना',
                        style: poppinsBold.copyWith(
                            fontSize: 18,
                            color: Colors.white)),
                  )),
            ],
          );
        },),
      ), context: context,
    );
  }
  _StateshowDialog(height,width) async {
    await showDialog<String>(
      builder: (context) =>  AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: StatefulBuilder(builder: (context, setstate) {
          return  Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .center,
                children: [
                  Text(
                    language ==
                        "English"
                        ? "Select State"
                        : "राज्य चुनें",
                    style: poppinsBold.copyWith(
                        fontSize:
                        22),
                  ),
                ],
              ),
              Flexible(
                child: state_list.length==0?Center(
          child: Container(
          height: height * 0.2,
          width: width*0.5,
          decoration: const BoxDecoration(
          image: DecorationImage(
          image: AssetImage(Images.no_data))),
          )
          ):SizedBox(
            width: width,
            height: height,
            child: ListView
                      .builder(
                    itemCount:state_list.length,
                    itemBuilder:
                        (context,
                        index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap:
                                () {
                              setState(() {
                                dailog_status = true;
                                select_state = state_list[index].name;
                                state_id = state_list[index].id;
                                print("State Id:::::::::::${state_id}");
                                select_state_color = true;
                                EasyLoading.show();
                                Select_City_api(state_id!);
                                Navigator.pop(context);
                              });
                            },
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${state_list[index].name}",
                                      style: poppinsBold.copyWith(fontSize: 17),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height:
                            1,
                            width:
                            width,
                            color:
                            Colors.black38,
                          )
                        ],
                      );
                    },
                  ),
          ),
              ),
              InkWell(
                  onTap: () {
                    setState(
                            () {
                          dailog_status =
                          true;
                          Navigator.pop(
                              context);
                        });
                  },
                  child:
                  Container(
                    height: height *
                        0.05,
                    width: width *
                        0.5,
                    decoration: BoxDecoration(
                        color: Colors
                            .black,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 3)
                        ],
                        borderRadius:
                        BorderRadius.circular(3)),
                    alignment:
                    Alignment
                        .center,
                    margin: const EdgeInsets.only(
                        right:
                        10,
                        bottom:
                        20,
                        top:
                        10),
                    child: Text(
                        language == "English"?   "CLOSE":'बंद करना',
                        style: poppinsBold.copyWith(
                            fontSize: 18,
                            color: Colors.white)),
                  )),
            ],
          );
        },),
      ), context: context,
    );
  }
  _CityshowDialog(height,width) async {
    await showDialog<String>(
      builder: (context) =>  AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: StatefulBuilder(builder: (context, setstate) {
          return  Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .center,
                children: [
                  Text(
                    language ==
                        "English"
                        ? "Select City"
                        : "शहर चुनें",
                    style: poppinsBold.copyWith(
                        fontSize:
                        22),
                  ),
                ],
              ),
              Flexible(
                child:City_list.length==0?
                Center(
                    child: Container(
                      height: height * 0.2,
                      width: width*0.5,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Images.no_data))),
                    )
                ): SizedBox(
                  height: height,
                  width: width,
                  child: ListView
                      .builder(
                    itemCount: City_list.length,
                    itemBuilder:
                        (context,
                        index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap:
                                () {
                              setState(() {
                                dailog_status = true;
                                select_city = City_list[index].name;
                                city_id=City_list[index].id;
                                print("city_id::::::::::$city_id");
                                select_city_color = true;
                                Navigator.pop(context);
                              });
                            },
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${City_list[index].name}",textAlign: TextAlign.center,
                                      style: poppinsBold.copyWith(fontSize: 17),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height:
                            1,
                            width:
                            width,
                            color:
                            Colors.black38,
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    setState(
                            () {
                          dailog_status =
                          true;
                          Navigator.pop(
                              context);
                        });
                  },
                  child:
                  Container(
                    height: height *
                        0.05,
                    width: width *
                        0.5,
                    decoration: BoxDecoration(
                        color: Colors
                            .black,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 3)
                        ],
                        borderRadius:
                        BorderRadius.circular(3)),
                    alignment:
                    Alignment
                        .center,
                    margin: const EdgeInsets.only(
                        right:
                        10,
                        bottom:
                        20,
                        top:
                        10),
                    child: Text(
                        language == "English"?  "CLOSE":'बंद करना',
                        style: poppinsBold.copyWith(
                            fontSize: 18,
                            color: Colors.white)),
                  )),
            ],
          );
        },),
      ), context: context,
    );
  }
}

