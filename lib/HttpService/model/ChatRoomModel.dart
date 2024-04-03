class ChatRoomModel {
  ChatRoomModel({
    required this.success,
    required this.chatRoomDetails,
    required this.message,
  });
  late final String success;
  late final List<ChatRoomDetails> chatRoomDetails;
  late final String message;

  ChatRoomModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    chatRoomDetails = List.from(json['data']).map((e)=>ChatRoomDetails.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = chatRoomDetails.map((e)=>e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class ChatRoomDetails {
  ChatRoomDetails({
    required this.id,
    required this.groupName,
    required this.groupId,
    required this.consultantId,
  });
  late final int id;
  late final String groupName;
  late final String groupId;
  late final int consultantId;

  ChatRoomDetails.fromJson(Map<String, dynamic> json){
    id = json['id'];
    groupName = json['groupName'];
    groupId = json['groupId'];
    consultantId = int.parse(json['consultant_id'].toString());
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['groupName'] = groupName;
    _data['groupId'] = groupId;
    _data['country_id'] = consultantId;
    return _data;
  }
}