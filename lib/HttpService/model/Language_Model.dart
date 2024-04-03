
class LanguageModel {
  LanguageModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final String success;
  late final List<Data> data;
  late final String message;

  LanguageModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.languageName,
    required this.is_check,
  });
  late final int id;
  late final String languageName;
  bool is_check = false;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    languageName = json['language_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['language_name'] = languageName;

    return _data;
  }
}
