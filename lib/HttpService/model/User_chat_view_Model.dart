class UserChatViewModel {
  UserChatViewModel({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final List<Data> data;

  UserChatViewModel.fromJson(Map<String, dynamic> json){
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
    required this.userId,
    required this.astrologerId,
    required this.msg,
    required this.userType,
    required this.status,
    required this.created,
    required this.isView,
    required this.userName,
    required this.astrologerName,
    required this.astrologerImage,
  });
  late final int id;
  late final String userId;
  late final String astrologerId;
  late final String msg;
  late final int userType;
  late final String status;
  late final String created;
  late final int isView;
  late final String userName;
  late final String astrologerName;
  late final String astrologerImage;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    astrologerId = json['astrologer_id'];
    msg = json['msg'];
    userType = int.parse(json['user_type'].toString());
    status = json['status'];
    created = json['created'];
    isView = int.parse(json['is_view'].toString());
    userName = json['user_name'];
    astrologerName = json['astrologer_name'];
    astrologerImage = json['astrologer_image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['astrologer_id'] = astrologerId;
    _data['msg'] = msg;
    _data['user_type'] = userType;
    _data['status'] = status;
    _data['created'] = created;
    _data['is_view'] = isView;
    _data['user_name'] = userName;
    _data['astrologer_name'] = astrologerName;
    _data['astrologer_image'] = astrologerImage;
    return _data;
  }
}