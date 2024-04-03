class RedeemWithdrawalModel {
  RedeemWithdrawalModel({
    required this.success,
    required this.data1,
  });
  late final bool success;
  late final List<Data1> data1;

  RedeemWithdrawalModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data1 = List.from(json['data']).map((e)=>Data1.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data1.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data1 {
  Data1({
    required this.id,
    required this.bankDetailId,
    required this.requestAmt,
    required this.astrologerId,
    required this.transId,
    required this.status,
    required this.rejectionReason,
    required this.created,
    required this.accNo,
    required this.accName,
    required this.ifscCode,
    required this.type,
    required this.paytmMoNo,
    required this.googlePayNo,
    required this.create,
    required this.withdrawStatus,
    required this.typeMsg,
  });
  late final int id;
  late final String bankDetailId;
  late final String requestAmt;
  late final String astrologerId;
  late final String transId;
  late final int status;
  late final String rejectionReason;
  late final String created;
  late final String accNo;
  late final String accName;
  late final String ifscCode;
  late final String type;
  late final String paytmMoNo;
  late final String googlePayNo;
  late final String create;
  late final int withdrawStatus;
  late final String typeMsg;

  Data1.fromJson(Map<String, dynamic> json){
    id = json['id'];
    bankDetailId = json['bank_detail_id'];
    requestAmt = json['request_amt'];
    astrologerId = json['astrologer_id'];
    transId = json['trans_id'];
    status = int.parse(json['status'].toString());
    rejectionReason = json['rejection_reason'] ?? "";
    created = json['created'];
    accNo = json['acc_no'];
    accName = json['acc_name'];
    ifscCode = json['ifsc_code'];
    type = json['type'];
    paytmMoNo = json['paytm_mo_no'];
    googlePayNo = json['google_pay_no'];
    create = json['create'];
    withdrawStatus = int.parse(json['withdraw_status'].toString());
    typeMsg = json['type_msg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['bank_detail_id'] = bankDetailId;
    _data['request_amt'] = requestAmt;
    _data['astrologer_id'] = astrologerId;
    _data['trans_id'] = transId;
    _data['status'] = status;
    _data['rejection_reason'] = rejectionReason;
    _data['created'] = created;
    _data['acc_no'] = accNo;
    _data['acc_name'] = accName;
    _data['ifsc_code'] = ifscCode;
    _data['type'] = type;
    _data['paytm_mo_no'] = paytmMoNo;
    _data['google_pay_no'] = googlePayNo;
    _data['create'] = create;
    _data['withdraw_status'] = withdrawStatus;
    _data['type_msg'] = typeMsg;
    return _data;
  }
}