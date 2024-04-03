class CountryModel {
  CountryModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final String success;
  late final List<Data> data;
  late final String message;

  CountryModel.fromJson(Map<String, dynamic> json){
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
    required this.sortname,
    required this.name,
  });
  late final int id;
  late final String sortname;
  late final String name;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    sortname = json['sortname'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['sortname'] = sortname;
    _data['name'] = name;
    return _data;
  }
}