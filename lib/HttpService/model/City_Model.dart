class CityModel {
  CityModel({
    required this.success,
    required this.City_data,
    required this.message,
  });
  late final String success;
  late final List<City_Data> City_data;
  late final String message;

  CityModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    City_data = List.from(json['data']).map((e)=>City_Data.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = City_data.map((e)=>e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class City_Data {
  City_Data({
    required this.id,
    required this.name,
    required this.stateId,
  });
  late final int id;
  late final String name;
  late final int stateId;

  City_Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    stateId = int.parse(json['state_id'].toString());
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['state_id'] = stateId;
    return _data;
  }
}