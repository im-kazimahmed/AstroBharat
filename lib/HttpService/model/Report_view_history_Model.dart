class ReportViewHistoryModel {
  ReportViewHistoryModel({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final Data data;

  ReportViewHistoryModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.reportId,
    required this.userId,
    required this.astrologerId,
    required this.fname,
    required this.lname,
    required this.gender,
    required this.moNo,
    required this.bdayDate,
    required this.timeBday,
    required this.city,
    required this.email,
    required this.state,
    required this.country,
    required this.maritalStatus,
    required this.occupation,
    required this.isAddParter,
    required this.partnerName,
    required this.partnerBday,
    required this.partnerTimeBday,
    required this.pCity,
    required this.pState,
    required this.pCountry,
    required this.comment,
    required this.created,
    required this.name,
    required this.image,
  });
  late final int id;
  late final String reportId;
  late final String userId;
  late final String astrologerId;
  late final String fname;
  late final String lname;
  late final String gender;
  late final String moNo;
  late final String bdayDate;
  late final String timeBday;
  late final String city;
  late final String email;
  late final String state;
  late final String country;
  late final String maritalStatus;
  late final String occupation;
  late final int isAddParter;
  late final String partnerName;
  late final String partnerBday;
  late final String partnerTimeBday;
  late final String pCity;
  late final String pState;
  late final String pCountry;
  late final String comment;
  late final String created;
  late final String name;
  late final String image;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    reportId = json['report_id'];
    userId = json['user_id'];
    astrologerId = json['astrologer_id'];
    fname = json['fname'];
    lname = json['lname'];
    gender = json['gender'];
    moNo = json['mo_no'];
    bdayDate = json['bday_date'];
    timeBday = json['time_bday'];
    city = json['city'];
    email = json['email'];
    state = json['state'];
    country = json['country'];
    maritalStatus = json['marital_status'];
    occupation = json['occupation'];
    isAddParter = int.parse(json['is_add_parter'].toString());
    partnerName = json['partner_name'];
    partnerBday = json['partner_bday'];
    partnerTimeBday = json['partner_time_bday'];
    pCity = json['p_city'];
    pState = json['p_state'];
    pCountry = json['p_country'];
    comment = json['comment'];
    created = json['created'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['report_id'] = reportId;
    _data['user_id'] = userId;
    _data['astrologer_id'] = astrologerId;
    _data['fname'] = fname;
    _data['lname'] = lname;
    _data['gender'] = gender;
    _data['mo_no'] = moNo;
    _data['bday_date'] = bdayDate;
    _data['time_bday'] = timeBday;
    _data['city'] = city;
    _data['email'] = email;
    _data['state'] = state;
    _data['country'] = country;
    _data['marital_status'] = maritalStatus;
    _data['occupation'] = occupation;
    _data['is_add_parter'] = isAddParter;
    _data['partner_name'] = partnerName;
    _data['partner_bday'] = partnerBday;
    _data['partner_time_bday'] = partnerTimeBday;
    _data['p_city'] = pCity;
    _data['p_state'] = pState;
    _data['p_country'] = pCountry;
    _data['comment'] = comment;
    _data['created'] = created;
    _data['name'] = name;
    _data['image'] = image;
    return _data;
  }
}