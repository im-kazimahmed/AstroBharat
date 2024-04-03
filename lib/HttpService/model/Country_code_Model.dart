class CountryCodeModel {
  CountryCodeModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final String success;
  late final List<Data> data;
  late final String message;

  CountryCodeModel.fromJson(Map<String, dynamic> json){
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
    required this.name,
    required this.phonecode,
  });
  late final String name;
  late final int phonecode;

  Data.fromJson(Map<String, dynamic> json){
    name = json['name'];
    phonecode = int.parse(json['phonecode'].toString());
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['phonecode'] = phonecode;
    return _data;
  }
}