class ViewHistoryModel  {
  ViewHistoryModel ({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final List<Data> data;

  ViewHistoryModel .fromJson(Map<String, dynamic> json){
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
    required this.isAdmin,
    required this.userId,
    required this.astroId,
    required this.reviewDate,
    required this.comments,
    required this.reviewRating,
    required this.reviewName,
    required this.created,
    required this.userName,
    required this.userImage,
  });
  late final int id;
  late final int isAdmin;
  late final String userId;
  late final String astroId;
  late final String reviewDate;
  late final String comments;
  late final String reviewRating;
  late final String reviewName;
  late final String created;
  late final String userName;
  late final String userImage;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    isAdmin = json['is_admin'];
    userId = json['user_id'];
    astroId = json['astro_id'];
    reviewDate = json['review_date'];
    comments = json['comments'];
    reviewRating = json['review_rating'];
    reviewName = json['review_name'];
    created = json['created'];
    userName = json['user_name'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['is_admin'] = isAdmin;
    _data['user_id'] = userId;
    _data['astro_id'] = astroId;
    _data['review_date'] = reviewDate;
    _data['comments'] = comments;
    _data['review_rating'] = reviewRating;
    _data['review_name'] = reviewName;
    _data['created'] = created;
    _data['user_name'] = userName;
    _data['user_image'] = userImage;
    return _data;
  }
}