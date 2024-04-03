class GetTimeModel {
  GetTimeModel({
    required this.success,
    required this.data1,
  });
  late final bool success;
  late final Data1 data1;

  GetTimeModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data1 = Data1.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data1.toJson();
    return _data;
  }
}

class Data1 {
  Data1({
    required this.isView,
    required this.chatTotalTime,
    required this.todayChatTotalTime,
    required this.callTotalTime,
    required this.todayCallTotalTime,
    required this.isOnlineChat,
    required this.offDateChat,
    required this.offTimeChat,
    required this.isOnlineCall,
    required this.offDateCall,
    required this.offTimeCall,
  });
  late final int isView;
  late final String chatTotalTime;
  late final String todayChatTotalTime;
  late final String callTotalTime;
  late final String todayCallTotalTime;
  late final int isOnlineChat;
  late final String offDateChat;
  late final String offTimeChat;
  late final int isOnlineCall;
  late final String offDateCall;
  late final String offTimeCall;

  Data1.fromJson(Map<String, dynamic> json){
    isView = json['is_view'];
    chatTotalTime = json['chat_total_time'];
    todayChatTotalTime = json['today_chat_total_time'];
    callTotalTime = json['call_total_time'];
    todayCallTotalTime = json['today_call_total_time'];
    isOnlineChat = int.parse(json['is_online_chat'].toString());
    offDateChat = json['off_date_chat'];
    offTimeChat = json['off_time_chat'];
    isOnlineCall = int.parse(json['is_online_call'].toString());
    offDateCall = json['off_date_call'];
    offTimeCall = json['off_time_call'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['is_view'] = isView;
    _data['chat_total_time'] = chatTotalTime;
    _data['today_chat_total_time'] = todayChatTotalTime;
    _data['call_total_time'] = callTotalTime;
    _data['today_call_total_time'] = todayCallTotalTime;
    _data['is_online_chat'] = isOnlineChat;
    _data['off_date_chat'] = offDateChat;
    _data['off_time_chat'] = offTimeChat;
    _data['is_online_call'] = isOnlineCall;
    _data['off_date_call'] = offDateCall;
    _data['off_time_call'] = offTimeCall;
    return _data;
  }
}


// class GetTimeModel {
//   GetTimeModel({
//     required this.success,
//     required this.data1,
//   });
//   late final bool success;
//   late final Data1 data1;
//
//   GetTimeModel.fromJson(Map<String, dynamic> json){
//     success = json['success'];
//     data1 = Data1.fromJson(json['data']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['success'] = success;
//     _data['data'] = data1.toJson();
//     return _data;
//   }
// }
//
// class Data1 {
//   Data1({
//     required this.isView,
//     required this.chatTotalTime,
//     required this.todayChatTotalTime,
//     required this.callTotalTime,
//     required this.todayCallTotalTime,
//     required this.isOnlineChat,
//     required this.offDateChat,
//     required this.offTimeChat,
//     required this.isOnlineCall,
//     required this.offDateCall,
//     required this.offTimeCall,
//   });
//   late final int isView;
//   late final int chatTotalTime;
//   late final String todayChatTotalTime;
//   late final String callTotalTime;
//   late final String todayCallTotalTime;
//   late final int isOnlineChat;
//   late final String offDateChat;
//   late final String offTimeChat;
//   late final int isOnlineCall;
//   late final String offDateCall;
//   late final String offTimeCall;
//
//   Data1.fromJson(Map<String, dynamic> json){
//     isView = json['is_view'];
//     chatTotalTime = json['chat_total_time'];
//     todayChatTotalTime = json['today_chat_total_time'];
//     callTotalTime = json['call_total_time'];
//     todayCallTotalTime = json['today_call_total_time'];
//     isOnlineChat = json['is_online_chat'];
//     offDateChat = json['off_date_chat'];
//     offTimeChat = json['off_time_chat'];
//     isOnlineCall = json['is_online_call'];
//     offDateCall = json['off_date_call'];
//     offTimeCall = json['off_time_call'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['is_view'] = isView;
//     _data['chat_total_time'] = chatTotalTime;
//     _data['today_chat_total_time'] = todayChatTotalTime;
//     _data['call_total_time'] = callTotalTime;
//     _data['today_call_total_time'] = todayCallTotalTime;
//     _data['is_online_chat'] = isOnlineChat;
//     _data['off_date_chat'] = offDateChat;
//     _data['off_time_chat'] = offTimeChat;
//     _data['is_online_call'] = isOnlineCall;
//     _data['off_date_call'] = offDateCall;
//     _data['off_time_call'] = offTimeCall;
//     return _data;
//   }
// }