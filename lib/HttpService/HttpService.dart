import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Controllers/time_slot_controller.dart';
import '../utill/app_constants.dart';
import '../utill/share_preferences.dart';
import 'model/Consultant_Availability.dart';

class HttpService {
  static Future<dynamic> check_numbar_api(String number) async {
    var map = new Map<String, dynamic>();
    map['mo_no'] = number;

    var response =
        await http.post(Uri.parse(AppConstants.CHAK_NUMBER), body: map);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error(
          'http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> select_category_api() async {
    var response = await http.get(Uri.parse('${AppConstants.CATEGORY}'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error(
          'http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> addParticipantIntoSession(int consultantId) async {
    var response = await http.get(Uri.parse('${AppConstants.addParticipantIntoSession}?consultantId=$consultantId'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error(
          'http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> removeParticipantFromSession(int consultantId) async {
    var response = await http.get(Uri.parse('${AppConstants.removeParticipantFromSession}?consultantId=$consultantId'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error(
          'http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> select_skill_api() async {
    var response = await http.get(Uri.parse('${AppConstants.SKILL}'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error(
          'http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> select_language_api() async {
    var response = await http.get(Uri.parse('${AppConstants.LANGUGE}'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error(
          'http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> select_country_api() async {
    var response = await http.get(Uri.parse('${AppConstants.COUNTRY}'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error(
          'http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> select_state_api(int country_id) async {
    var response =
        await http.get(Uri.parse('${AppConstants.STATE}/$country_id'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error(
          'http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> getAgoraTokenApi(String channelName) async {
    var response = await http.get(Uri.parse('https://agora-token-server--kazim-ahmed.repl.co/access_token?channelName=$channelName'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error(
          'http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> sendNotificationToUser({
    required String body,
    required String title,
    required int userId,
  }) async {
    var response = await http.get(Uri.parse('${AppConstants.BASE_URL}send-notification-by-user-id?user_id=$userId&title=$title&body=$body'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error(
          'http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> createChatRoomApi(String groupName, String groupId, int consultantId) async {
    var response =
    await http.get(Uri.parse('${AppConstants.createChatRoom}?groupName=$groupName&groupId=$groupId&consultant_id=$consultantId'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error(
          'http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> deleteChatRoomApi(int consultantId) async {
    var response =
    await http.get(Uri.parse('${AppConstants.deleteChatRoom}?consultant_id=$consultantId'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error(
          'http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> select_city_api(int state_id) async {
    var response = await http.get(Uri.parse('${AppConstants.CITY}/$state_id'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error(
          'http error code:: ${response.statusCode.toString()}');
    }
  }

  static register_api(
      String fname,
      String nname,
      String email,
      String number,
      String aNumber,
      String date,
      String gender,
      String category,
      String skill,
      String slanguage,
      String experience,
      String country,
      String state,
      String city,
      String address,
      String pincode,
      String degree,
      String pancard_number,
      String aadhar_number,
      String account_number,
      String account_type,
      String ifsc_code,
      String holder_name,
      String bank_name,
      String urlFile_profile,
      String urlFile_proof,
      String bio,
      String device_id,
      String language,
      String password, String country_code
      ) async {
    var map = new Map<String, dynamic>();
    map['full_name'] = fname;
    map['nick_name'] = nname;
    map['email'] = email;
    map['mo_no'] = number;
    map['alt_mo_no'] = aNumber;
    map['dob'] = date;
    map['gender'] = gender;
    map['password'] = password;
    map['experience'] = experience;
    map['address'] = address;
    map['city'] = city;
    map['state'] = state;
    map['country'] = country;
    map['pincode'] = pincode;
    map['highest_degree'] = degree;
    map['pancard'] = pancard_number;
    map['aadhar_card'] = aadhar_number;
    map['bank_add_number'] = account_number;
    map['acc_type'] = account_type;
    map['IFSC_code'] = ifsc_code;
    map['acc_holder_name'] = holder_name;
    map['bank_name'] = bank_name;
    map['image'] = urlFile_profile;
    map['id_proof'] = urlFile_proof;
    map['description_bio'] =bio ;
    map['device_id'] =device_id ;
    map['skill'] =skill;
    map['category'] =category;
    map['language'] =slanguage;
    map['lang_type'] =language;
    map['country_code'] =country_code;

    var response = await http.post(Uri.parse('${AppConstants.REGISTER}'),body: map);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }

  }

  static Future<dynamic> login_api(String number,String device_id, String password, int selected) async {
  var map = new Map<String, dynamic>();
  map['mo_no'] = number;
  map['device_id'] = device_id;
  map['password'] = password;
  map['country_code'] = "$selected";

  var response = await http.post(Uri.parse('${AppConstants.LOGIN}'),body: map);
  if (response.statusCode == 200) {
    Map<String, dynamic> body = jsonDecode(response.body);
    return body;
  } else {
    return Future.error('http error code:: ${response.statusCode.toString()} & body:${response.body}');
  }
}

  static Future<dynamic> send_otp_api(String number, String otp,) async {
    var map = new Map<String, dynamic>();
    map['mobile'] = number;
    map['otp'] = otp;

    var response = await http.post(Uri.parse('${AppConstants.SEND_OTP}'),body: map);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> edit_profil_api(
      String fname,
      String nname,
      String email,
      String anumber,
      String date,
      String gender,
      String urlFile_profile) async {
    final body = {
      'full_name' : fname,
      'nick_name' : nname,
      'email' : email,
      'alt_mo_no' : anumber,
      'dob' : date,
      'gender' : gender,
      'image' : urlFile_profile,
    };
    // var response = await http.post(Uri.parse('${AppConstants.EDIT_PROFILE}'),body: map);
    var url = Uri.parse('${AppConstants.EDIT_PROFILE}');
    final response = await http.post(url,body: jsonEncode(body) ,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> get_uesr_detali_api() async {
    var url = Uri.parse('${AppConstants.GET_UESR_DETAIL}');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> check_user_status_api() async {
    var url = Uri.parse('${AppConstants.CHECK_USER_STATUS}');
    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> edit_skill_api(String skill,) async {
    final body = {
      'skill' : skill,
    };

    var url = Uri.parse('${AppConstants.EDIT_SKILL}');
    final response = await http.post(url,body: jsonEncode(body) ,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> editFeesApi(
      {
        required int userId,
        liveFees,
        appointmentFees,
      }) async {
    final body = {
      'live_stream_fees' : liveFees,
      'oppointment_fees' : appointmentFees,
    };

    var url = Uri.parse('${AppConstants.EDIT_FEES}/$userId');
    final response = await http.post(url,body: jsonEncode(body) ,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> editTimeAvailabilityApi(
      {
        required int userId,
        // hourlyFees,
        required String time, date, sessionType,
      }) async {
    final body = {
      'time' : time,
      'date' : date,
      'session_type' : sessionType,
    };

    var url = Uri.parse('${AppConstants.EDIT_TIME_AVAILABILITY}/$userId');
    final response = await http.post(url,body: jsonEncode(body) ,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> appointmentNotAttendedApi(int appointmentId) async {
    var url = Uri.parse('${AppConstants.editAppointmentNotAttended}/$appointmentId');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> editAppointmentMarkAttendedApi(int appointmentId) async {
    var url = Uri.parse('${AppConstants.editAppointmentMarkAttended}/$appointmentId');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> allowUserToJoinSessionApi(int appointmentId) async {
    var url = Uri.parse('${AppConstants.allowUserToJoinSession}/$appointmentId');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> editAppointmentMarkApprovedApi(int appointmentId, int consultantId) async {
    var url = Uri.parse('${AppConstants.editAppointmentMarkApproved}/$appointmentId?consultant_id=$consultantId');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> editAppointmentMarkCancelApi(int appointmentId) async {
    var url = Uri.parse('${AppConstants.editAppointmentMarkCancel}/$appointmentId');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> edit_Category_api(String category,) async {
    final body = {
      'category' : category,
    };
    var url = Uri.parse(AppConstants.EDIT_CATEGORY);
    final response = await http.post(url,body: jsonEncode(body) ,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> edit_language_api(String language,) async {
    final body = {
      'language' : language,
    };
    var url = Uri.parse('${AppConstants.EDIT_LANGYAGE}');
    final response = await http.post(url,body: jsonEncode(body) ,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> edit_address_api(
      String select_year,
      int country_id,
      int state_id,
      int city_id,
      String address,
      String pincode,
      String digree) async {
    final body = {
      'experience' : select_year,
      'address' : address,
      'pincode' : pincode,
      'highest_degree' : digree,
      'country' : country_id,
      'state' : state_id,
      'city' : city_id,
    };

    var url = Uri.parse('${AppConstants.EDIT_ADDRESS}');
    final response = await http.post(url,body: jsonEncode(body) ,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> edit_bank_detail_api(
      String pancard,
      String aadhar,
      String account_number,
      String selected,
      String ifsc,
      String holder_name,
      String bank) async {
    final body = {
      'pancard' : pancard,
      'aadhar_card' : aadhar,
      'bank_add_number' : account_number,
      'acc_type' : selected,
      'IFSC_code' : ifsc,
      'acc_holder_name' : holder_name,
      'bank_name' : bank,
    };

    var url = Uri.parse('${AppConstants.EDIT_BANK}');
    final response = await http.post(url,body: jsonEncode(body) ,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> add_details_api(String selectedItem, String google, String patym, String bank_name, String bank_number , String ifsc_code) async {
    final body = {
      'acc_no':bank_number,
      'acc_name': bank_name,
      'ifsc_code': ifsc_code,
      'type': selectedItem,
      'paytm_mo_no': patym,
      'google_pay_no': google,
    };

    final response = await http.post(Uri.parse('${AppConstants.ADD_BANK_DETAIL}'),body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> get_bank_detail_api() async {
    var url = Uri.parse('${AppConstants.GET_BANK_DETAIL}');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> withdrawal_api(String Amount, String bank_id) async {
    final body = {
      'bank_detail_id':int.parse(bank_id.toString()),
      'request_amt': int.parse(Amount.toString())
    };

    final response = await http.post(Uri.parse('${AppConstants.WITHRAWAK_DATEIL}'),body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> redeem_withdrawal_api() async {
    var url = Uri.parse('${AppConstants.GET_REDEEM_WITHDRAEAL}');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> report_view_history_api(int id) async {

    final body = {
      'id' : id,
    };
    var url = Uri.parse('${AppConstants.USER_REPORT_VIEW}?id=$id');
    final response = await http.post(url,body: jsonEncode(body) , headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> update_chat_status(int chat_st, String datemsg, String timemsg,) async {
    final body = {
      'is_online_chat' : "$chat_st",
      'date' : "$datemsg",
      'time' : "$timemsg",
    };

    var url = Uri.parse('${AppConstants.UPDATA_CHAT_STATUS}');
    final response = await http.post(url,body: jsonEncode(body) ,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<ConsultantAvailability> fetchConsultantAvailability(int consultantId) async {
    TimeSlotController controller = Get.find<TimeSlotController>();
    final response = await http.get(
        Uri.parse('${AppConstants.consultantGetAvailableTimings}/$consultantId'));
    if (response.statusCode == 200) {
      controller.appointments = ConsultantAvailability.fromJson(jsonDecode(response.body));
      if(controller.appointments?.appointments != {}) {
        for(var item in controller.appointments!.appointments!.values) {
          print(item);
          print("ok hogaya");
        }
      } else {
        print("empty hain nahi hua ok");
      }
      return ConsultantAvailability.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch consultant availability');
    }
  }


  static Future<dynamic> update_call_status(int chat_st, String datecall, String timecall,) async {
    final body = {
      'is_online_call' : "$chat_st",
      'date' : "$datecall",
      'time' : "$timecall",
    };

    var url = Uri.parse('${AppConstants.UPDATA_CALL_STATUS}');
    final response = await http.post(url,body: jsonEncode(body) ,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> question_history_api() async {
    var url = Uri.parse('${AppConstants.QUESTION_HISTORY}');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> report_history_api() async {
    var url = Uri.parse('${AppConstants.REPORT_HISTORY}');
    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> waiting_list_api() async {
    var url = Uri.parse('${AppConstants.WATITNG_LIST}');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> view_history_api() async {
    var url = Uri.parse('${AppConstants.VIEW_HISTORY}');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> wallet_api() async {
    var url = Uri.parse('${AppConstants.WALLET}');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> updateDeviceToken({required String newId, required int userId}) async {
    var url = Uri.parse(AppConstants.updateDeviceToken);
    final body = {
      'device_id' : newId,
      'consultant_id': userId,
    };
    final response = await http.post(url, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()} ${response.body}');
    }
  }


  static Future<dynamic> change_language(String lang_type,) async {
    final body = {
      'lang_type' : lang_type,
    };

    var url = Uri.parse('${AppConstants.CHANGE_LANGUAGE}');
    final response = await http.post(url,body: jsonEncode(body) ,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> time_api() async {
    var url = Uri.parse('${AppConstants.GET_TIME}');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> get_answer_api(int Id, String text,) async {
    final body = {
      'free_question_id' :Id,
      'answer' : text,
    };

    var url = Uri.parse('${AppConstants.MY_ANSWER}');
    final response = await http.post(url,body: jsonEncode(body) ,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }


  static Future<dynamic> get_answer_delete_api(int Id )async {
    var url = Uri.parse('${AppConstants.MY_ANSWER_DELETE}?free_que_answer_id=$Id');
    final response = await http.get(url ,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static file_upload_image(File imagename) async {
    var url = Uri.parse('${AppConstants.IMAGE}');
    var request = http.MultipartRequest('POST', url);
    request.files
        .add(await http.MultipartFile.fromPath('image', imagename.path));
    var res = await request.send();
    return res;
  }

  static Future<dynamic> country_code()async {


    var url = Uri.parse('${AppConstants.COUNTRY_CODE}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> terme_use_api()async {
    var url = Uri.parse('${AppConstants.TERMS_USE}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }

  static Future<dynamic> privacy_policy_api()async {
    var url = Uri.parse('${AppConstants.PRIVACY_POLICY}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }


  static Future<dynamic> update_live_status(int Id)async {
    final body = {
      'is_live' :Id,
    };
    var url = Uri.parse('${AppConstants.UPDATE_LIVE_STATUS}');
    final response = await http.post(url,body: jsonEncode(body) ,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      return Future.error('http error code:: ${response.statusCode.toString()}');
    }
  }


//   static Future<dynamic> call_history_api() async {
//     var url = Uri.parse('${AppConstants.CALL_HISTORY}');
//     final response = await http.get(url, headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
//     });
//     if (response.statusCode == 200) {
//       Map<String, dynamic> body = jsonDecode(response.body);
//       return body;
//     } else {
//       return Future.error('http error code:: ${response.statusCode.toString()}');
//     }
//   }
//
//   static Future<dynamic> chat_history_api() async {
//     var url = Uri.parse('${AppConstants.CHAT_HISTORY}');
//     final response = await http.get(url, headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
//     });
//     if (response.statusCode == 200) {
//       Map<String, dynamic> body = jsonDecode(response.body);
//       return body;
//     } else {
//       return Future.error('http error code:: ${response.statusCode.toString()}');
//     }
//   }
//
//   static Future<dynamic> user_chat_view_api(int id) async {
//     print(id);
//     var url = Uri.parse('${AppConstants.USER_CHAT_VIEW}?user_id=$id');
//     final response = await http.get(url, headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
//     });
//     if (response.statusCode == 200) {
//       Map<String, dynamic> body = jsonDecode(response.body);
//       return body;
//     } else {
//       return Future.error('http error code:: ${response.statusCode.toString()}');
//     }
//   }
//
//   static Future<dynamic> get_send_msg_api(String msg, int id) async {
//     final body = {
//       'user_id':id,
//       'message': msg
//     };
//     final response = await http.post(Uri.parse('${AppConstants.SEND_MSG}'),body: jsonEncode(body), headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ${PreferenceUtils.getString('token')}',
//     });
//     if (response.statusCode == 200) {
//       Map<String, dynamic> body = jsonDecode(response.body);
//       return body;
//     } else {
//       return Future.error('http error code:: ${response.statusCode.toString()}');
//     }
//   }
//
//
}