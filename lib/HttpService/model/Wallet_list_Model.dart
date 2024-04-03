class WalletListModel  {
  WalletListModel ({
    required this.success,
    required this.data,
    required this.totalAmt,
    required this.walletLimit,
  });
  late final bool success;
  late final List<Data> data;
  late final int totalAmt;
  late final String walletLimit;

  WalletListModel .fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    totalAmt = int.parse(json['total_amt'].toString());
    walletLimit = json['wallet_limit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['total_amt'] = totalAmt;
    _data['wallet_limit'] = walletLimit;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.astrologerId,
    required this.astrologerName,
    required this.moNo,
    required this.transStatus,
    required this.transactionid,
    required this.trannsactionType,
    required this.amount,
    required this.created,
  });
  late final int id;
  late final int astrologerId;
  late final String astrologerName;
  late final String moNo;
  late final int transStatus;
  late final String transactionid;
  late final String trannsactionType;
  late final String amount;
  late final String created;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    astrologerId = int.parse(json['astrologer_id'].toString());
    astrologerName = json['astrologer_name'];
    moNo = json['mo_no'];
    transStatus = int.parse(json['trans_status'].toString());
    transactionid = json['transactionid'];
    trannsactionType = json['trannsaction_type'];
    amount = json['amount'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['astrologer_id'] = astrologerId;
    _data['astrologer_name'] = astrologerName;
    _data['mo_no'] = moNo;
    _data['trans_status'] = transStatus;
    _data['transactionid'] = transactionid;
    _data['trannsaction_type'] = trannsactionType;
    _data['amount'] = amount;
    _data['created'] = created;
    return _data;
  }
}