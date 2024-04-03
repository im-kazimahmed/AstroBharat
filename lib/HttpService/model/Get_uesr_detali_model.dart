class GetUesrDetaliModel {
  GetUesrDetaliModel({
    required this.success,
    required this.message,
    required this.data,
  });
  late final bool success;
  late final String message;
  late final Data data;

  GetUesrDetaliModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.uniqueCode,
    required this.sortId,
    required this.isLearn,
    required this.isVerified,
    required this.astroCode,
    required this.langType,
    required this.onlineCount,
    required this.fullName,
    required this.nickName,
    required this.email,
    required this.authToken,
    required this.countryCode,
    required this.moNo,
    required this.altMoNo,
    required this.dob,
    required this.gender,
    required this.skill,
    required this.category,
    required this.experience,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.pincode,
    required this.highestDegree,
    required this.pancard,
    required this.aadharCard,
    required this.bankAddNumber,
    required this.accType,
    required this.IFSCCode,
    required this.accHolderName,
    required this.bankName,
    required this.image,
    required this.idProof,
    required this.descriptionBio,
    required this.language,
    required this.deviceId,
    required this.status,
    required this.reportAmount,
    required this.chatMin,
    required this.chatMinAmount,
    required this.callMin,
    required this.callMinAmount,
    required this.isOnlineChat,
    required this.offDateChat,
    required this.offTimeChat,
    required this.isOnlineCall,
    required this.offDateCall,
    required this.offTimeCall,
    required this.isVerifyTag,
    required this.isNew,
    required this.created,
    required this.isLive,
    required this.countryName,
    required this.stateName,
    required this.cityName,
  });
  late final int id;
  late final String uniqueCode;
  late final String sortId;
  late final int isLearn;
  late final int isVerified;
  late final String astroCode;
  late final String langType;
  late final String onlineCount;
  late final String fullName;
  late final String nickName;
  late final String email;
  late final String authToken;
  late final int countryCode;
  late final String moNo;
  late final String altMoNo;
  late final String dob;
  late final String gender;
  late final List<int> skill;
  late final List<int> category;
  late final String experience;
  late final String address;
  late final String city;
  late final String state;
  late final String country;
  late final String pincode;
  late final String highestDegree;
  late final String pancard;
  late final String aadharCard;
  late final String bankAddNumber;
  late final String accType;
  late final String IFSCCode;
  late final String accHolderName;
  late final String bankName;
  late final String image;
  late final String idProof;
  late final String descriptionBio;
  late final List<int> language;
  late final String deviceId;
  late final int status;
  late final String reportAmount;
  late final String chatMin;
  late final String chatMinAmount;
  late final String callMin;
  late final String callMinAmount;
  late final int isOnlineChat;
  late final String offDateChat;
  late final String offTimeChat;
  late final int isOnlineCall;
  late final String offDateCall;
  late final String offTimeCall;
  late final int isVerifyTag;
  late final int isNew;
  late final String created;
  late final int isLive;
  late final String countryName;
  late final String stateName;
  late final String cityName;
  late final int liveStreamFees;
  late final int appointmentFees;
  late final int hourlyFees;
  late final dynamic availableFrom;
  late final dynamic availableTill;
  late final List<Availability>? availability;
  late final int sessionUsersLimit;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    uniqueCode = json['unique_code'];
    sortId = json['sort_id'];
    isLearn = int.parse(json['is_learn'].toString());
    isVerified = int.parse(json['is_verified'].toString());
    astroCode = json['astro_code'];
    langType = json['lang_type'];
    onlineCount = json['online_count'];
    fullName = json['full_name'];
    nickName = json['nick_name'];
    email = json['email'];
    authToken = json['auth_token'];
    countryCode = int.parse(json['country_code'].toString());
    moNo = json['mo_no'];
    altMoNo = json['alt_mo_no'];
    dob = json['dob'];
    gender = json['gender'];
    skill = List.castFrom<dynamic, int>(json['skill']);
    category = List.castFrom<dynamic, int>(json['category']);
    experience = json['experience'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    highestDegree = json['highest_degree'];
    pancard = json['pancard'];
    aadharCard = json['aadhar_card'];
    bankAddNumber = json['bank_add_number'];
    accType = json['acc_type'];
    IFSCCode = json['IFSC_code'];
    accHolderName = json['acc_holder_name'];
    bankName = json['bank_name'];
    image = json['image'];
    idProof = json['id_proof'];
    descriptionBio = json['description_bio'];
    language = List.castFrom<dynamic, int>(json['language']);
    deviceId = json['device_id'];
    status = int.parse(json['status'].toString());
    reportAmount = json['report_amount'];
    chatMin = json['chat_min'];
    chatMinAmount = json['chat_min_amount'];
    callMin = json['call_min'];
    callMinAmount = json['call_min_amount'];
    isOnlineChat = int.parse(json['is_online_chat'].toString());
    offDateChat = json['off_date_chat'];
    offTimeChat = json['off_time_chat'];
    isOnlineCall = int.parse(json['is_online_call'].toString());
    offDateCall = json['off_date_call'];
    offTimeCall = json['off_time_call'];
    isVerifyTag = int.parse(json['is_verify_tag'].toString());
    isNew = int.parse(json['is_new'].toString());
    created = json['created'];
    isLive = int.parse(json['is_live'].toString());
    countryName = json['country_name'];
    stateName = json['state_name'];
    cityName = json['city_name'];
    liveStreamFees = int.parse(json['live_stream_fees'].toString());
    appointmentFees = int.parse(json['oppointment_fees'].toString());
    hourlyFees = int.parse(json['hourly_fees'].toString());
    availableFrom = json['available_from'].toString();
    availableTill = json['available_till'].toString();
    availability = json['availability'] != null ? List.from(json['availability']).map((e)=>Availability.fromJson(e)).toList(): [];
    sessionUsersLimit = int.parse(json['limit_session_users'].toString());
  }


  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['unique_code'] = uniqueCode;
    _data['sort_id'] = sortId;
    _data['is_learn'] = isLearn;
    _data['is_verified'] = isVerified;
    _data['astro_code'] = astroCode;
    _data['lang_type'] = langType;
    _data['online_count'] = onlineCount;
    _data['full_name'] = fullName;
    _data['nick_name'] = nickName;
    _data['email'] = email;
    _data['auth_token'] = authToken;
    _data['country_code'] = countryCode;
    _data['mo_no'] = moNo;
    _data['alt_mo_no'] = altMoNo;
    _data['dob'] = dob;
    _data['gender'] = gender;
    _data['skill'] = skill;
    _data['category'] = category;
    _data['experience'] = experience;
    _data['address'] = address;
    _data['city'] = city;
    _data['state'] = state;
    _data['country'] = country;
    _data['pincode'] = pincode;
    _data['highest_degree'] = highestDegree;
    _data['pancard'] = pancard;
    _data['aadhar_card'] = aadharCard;
    _data['bank_add_number'] = bankAddNumber;
    _data['acc_type'] = accType;
    _data['IFSC_code'] = IFSCCode;
    _data['acc_holder_name'] = accHolderName;
    _data['bank_name'] = bankName;
    _data['image'] = image;
    _data['id_proof'] = idProof;
    _data['description_bio'] = descriptionBio;
    _data['language'] = language;
    _data['device_id'] = deviceId;
    _data['status'] = status;
    _data['report_amount'] = reportAmount;
    _data['chat_min'] = chatMin;
    _data['chat_min_amount'] = chatMinAmount;
    _data['call_min'] = callMin;
    _data['call_min_amount'] = callMinAmount;
    _data['is_online_chat'] = isOnlineChat;
    _data['off_date_chat'] = offDateChat;
    _data['off_time_chat'] = offTimeChat;
    _data['is_online_call'] = isOnlineCall;
    _data['off_date_call'] = offDateCall;
    _data['off_time_call'] = offTimeCall;
    _data['is_verify_tag'] = isVerifyTag;
    _data['is_new'] = isNew;
    _data['created'] = created;
    _data['is_live'] = isLive;
    _data['country_name'] = countryName;
    _data['state_name'] = stateName;
    _data['city_name'] = cityName;
    _data['availability'] = availability;
    _data['limit_session_users'] = sessionUsersLimit;
    return _data;
  }
}


class Availability {
  Availability({
    required this.id,
    required this.consultantId,
    required this.time,
    required this.date,
    required this.sessionType,
    required this.isBooked,
  });
  late final int id;
  late final int consultantId;
  late final String time;
  late final String date;
  late final String sessionType;
  late final int isBooked;

  Availability.fromJson(Map<String, dynamic> json){
    id = json['id'];
    consultantId = int.parse(json['consultant_id'].toString());
    time = json['time'];
    date = json['date'];
    sessionType = json['session_type'];
    isBooked = int.parse(json['isBooked'].toString());
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['consultant_id'] = consultantId;
    _data['time'] = time;
    _data['date'] = date;
    _data['session_type'] = sessionType;
    _data['isBooked'] = isBooked;
    return _data;
  }
}



class NotAvailable {
  NotAvailable({
    required this.id,
    required this.consultantId,
    required this.startTime,
    required this.endTime,
    required this.day,
  });
  late final int id;
  late final int consultantId;
  late final String startTime;
  late final String endTime;
  late final String day;

  NotAvailable.fromJson(Map<String, dynamic> json){
    id = 0;
    consultantId = 0;
    startTime = "Not Available";
    endTime = "Not Available";
    day = "Not Available";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['0'] = id;
    _data['0'] = consultantId;
    _data["Not Available"] = startTime;
    _data["Not Available"] = endTime;
    _data["Not Available"] = day;
    return _data;
  }
}