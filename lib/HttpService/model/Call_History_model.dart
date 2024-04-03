class CallHistoryModel  {
  CallHistoryModel ({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final List<Data> data;

  CallHistoryModel .fromJson(Map<String, dynamic> json){
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
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.totalTime,
    required this.chatDate,
  });
  late final int userId;
  late final String userName;
  late final String userImage;
  late final String totalTime;
  late final String chatDate;

  Data.fromJson(Map<String, dynamic> json){
    userId = json['user_id'];
    userName = json['user_name'];
    userImage = json['user_image'];
    totalTime = json['total_time'];
    chatDate = json['chat_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId;
    _data['user_name'] = userName;
    _data['user_image'] = userImage;
    _data['total_time'] = totalTime;
    _data['chat_date'] = chatDate;
    return _data;
  }
}