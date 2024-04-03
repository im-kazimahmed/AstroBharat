class WaitingListModel {
  WaitingListModel({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final List<Data> data;

  WaitingListModel.fromJson(Map<String, dynamic> json){
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
    required this.isChat,
    required this.status,
    required this.created,
    required this.userName,
    required this.userImage,
  });
  late final int id;
  late final String userId;
  late final String astrologerId;
  late final int isChat;
  late final int status;
  late final String created;
  late final String userName;
  late final String userImage;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    astrologerId = json['astrologer_id'];
    isChat = int.parse(json['is_chat'].toString());
    status = int.parse(json['status'].toString());
    created = json['created'];
    userName = json['user_name'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['astrologer_id'] = astrologerId;
    _data['is_chat'] = isChat;
    _data['status'] = status;
    _data['created'] = created;
    _data['user_name'] = userName;
    _data['user_image'] = userImage;
    return _data;
  }
}