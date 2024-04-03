// class QuestionHistoryModel  {
//   QuestionHistoryModel ({
//     required this.success,
//     required this.data,
//   });
//   late final bool success;
//   late final List<Data> data;
//
//   QuestionHistoryModel .fromJson(Map<String, dynamic> json){
//     success = json['success'];
//     data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['success'] = success;
//     _data['data'] = data.map((e)=>e.toJson()).toList();
//     return _data;
//   }
// }
//
// class Data {
//   Data({
//     required this.id,
//     required this.userId,
//     required this.question,
//     required this.created,
//     required this.userName,
//   });
//   late final int id;
//   late final int userId;
//   late final String question;
//   late final String created;
//   late final String userName;
//
//   Data.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     userId = json['user_id'];
//     question = json['question'];
//     created = json['created'];
//     userName = json['user_name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['user_id'] = userId;
//     _data['question'] = question;
//     _data['created'] = created;
//     _data['user_name'] = userName;
//     return _data;
//   }
// }
class QuestionHistoryModel {
  QuestionHistoryModel({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final List<Data> data;

  QuestionHistoryModel.fromJson(Map<String, dynamic> json){
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
    required this.question,
    required this.created,
    required this.userName,
    required this.ansCount,
    required this.freeQueAnswerList,
  });
  late final int id;
  late final int userId;
  late final String question;
  late final String created;
  late final String userName;
  late final int ansCount;
  late final List<FreeQueAnswerList> freeQueAnswerList;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = int.parse(json['user_id'].toString());
    question = json['question'];
    created = json['created'];
    userName = json['user_name'] ?? "No Name Found";
    ansCount = int.parse(json['ans_count'].toString());
    freeQueAnswerList = List.from(json['free_que_answer_list']).map((e)=>FreeQueAnswerList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['question'] = question;
    _data['created'] = created;
    _data['user_name'] = userName;
    _data['ans_count'] = ansCount;
    _data['free_que_answer_list'] = freeQueAnswerList.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class FreeQueAnswerList {
  FreeQueAnswerList({
    required this.id,
    required this.freeQuestionId,
    required this.astrologerId,
    required this.answer,
    required this.created,
    required this.astrologerName,
    required this.isMe,
  });
  late final int id;
  late final int freeQuestionId;
  late final int astrologerId;
  late final String answer;
  late final String created;
  late final String astrologerName;
  late final int isMe;

  FreeQueAnswerList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    freeQuestionId = int.parse(json['free_question_id'].toString());
    astrologerId = int.parse(json['astrologer_id'].toString());
    answer = json['answer'];
    created = json['created'];
    astrologerName = json['astrologer_name'] ?? "Undefined";
    isMe = int.parse(json['is_me'].toString());
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['free_question_id'] = freeQuestionId;
    _data['astrologer_id'] = astrologerId;
    _data['answer'] = answer;
    _data['created'] = created;
    _data['astrologer_name'] = astrologerName;
    _data['is_me'] = isMe;
    return _data;
  }
}