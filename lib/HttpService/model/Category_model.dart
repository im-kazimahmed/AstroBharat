

class CategoryModel {
  CategoryModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final String success;
  late final List<Data> data;
  late final String message;

  CategoryModel.fromJson(Map<String, dynamic> json){
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
    required this.categoryName,
    required this.image,
    required this.is_check,
  });
  late final int id;
  late final String categoryName;
  late final String image;
  late final int parentId;
  bool is_check=false;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    categoryName = json['category_name'];
    image = json['image'];
    parentId = json['parent_id'] != null ? int.parse(json['parent_id'].toString()): 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['category_name'] = categoryName;
    _data['image'] = image;
    _data['parent_id'] = parentId;
    return _data;
  }
}