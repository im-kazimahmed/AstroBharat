class GetBankDetailModel {
  GetBankDetailModel({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final List<Data> data;

  GetBankDetailModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.accNo,
    required this.accName,
    required this.ifscCode,
    required this.astrologerId,
    required this.type,
    required this.paytmMoNo,
    required this.status,
    required this.googlePayNo,
    required this.created,
  });
  late final int id;
  late final String accNo;
  late final String accName;
  late final String ifscCode;
  late final String astrologerId;
  late final String type;
  late final String paytmMoNo;
  late final int status;
  late final String googlePayNo;
  late final String created;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    accNo = json['acc_no'];
    accName = json['acc_name'];
    ifscCode = json['ifsc_code'];
    astrologerId = json['astrologer_id'];
    type = json['type'];
    paytmMoNo = json['paytm_mo_no'];
    status = int.parse(json['status'].toString());
    googlePayNo = json['google_pay_no'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['acc_no'] = accNo;
    _data['acc_name'] = accName;
    _data['ifsc_code'] = ifscCode;
    _data['astrologer_id'] = astrologerId;
    _data['type'] = type;
    _data['paytm_mo_no'] = paytmMoNo;
    _data['status'] = status;
    _data['google_pay_no'] = googlePayNo;
    _data['created'] = created;
    return _data;
  }
}