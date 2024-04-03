class StateModel {
  StateModel({
    required this.success,
    required this.data1,
    required this.message,
  });
  late final String success;
  late final List<Data1> data1;
  late final String message;

  StateModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data1 = List.from(json['data']).map((e)=>Data1.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data1.map((e)=>e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class Data1 {
  Data1({
    required this.id,
    required this.name,
    required this.countryId,
  });
  late final int id;
  late final String name;
  late final int countryId;

  Data1.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    countryId = int.parse(json['country_id'].toString());
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['country_id'] = countryId;
    return _data;
  }
}