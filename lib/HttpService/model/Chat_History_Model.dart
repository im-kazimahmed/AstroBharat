class ChatHistoryModel  {
  ChatHistoryModel ({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final List<Data> data;

  ChatHistoryModel .fromJson(Map<String, dynamic> json){
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
    required this.name,
    required this.image,
    required this.status,
  });
  late final int id;
  late final String name;
  late final String image;
  late final String status;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    _data['status'] = status;
    return _data;
  }
}