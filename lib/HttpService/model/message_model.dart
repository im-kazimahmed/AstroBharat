// Dart imports:
import 'dart:convert';

class MessageModel {
  final String imageUrl;
  final String fullName;
  final String message;
  MessageModel({
    required this.imageUrl,
    required this.fullName,
    required this.message,
  });

  MessageModel copyWith({
    String? imageUrl,
    String? fullName,
    String? message,
  }) {
    return MessageModel(
      imageUrl: imageUrl ?? this.imageUrl,
      fullName: fullName ?? this.fullName,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'fullName': fullName,
      'message': message,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      imageUrl: map['imageUrl'] ?? '',
      fullName: map['fullName'] ?? '',
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'MessageModel(imageUrl: $imageUrl, fullName: $fullName, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.imageUrl == imageUrl &&
        other.fullName == fullName &&
        other.message == message;
  }

  @override
  int get hashCode => imageUrl.hashCode ^ fullName.hashCode ^ message.hashCode;
}

// MessageModel pinMessageFake = MessageModel(
//     imageUrl:
//         'https://my-test-11.slatic.net/p/96b9cce35f664d67479547587686742a.jpg',
//     fullName: 'Kazim Ahmed',
//     message: 'Hi');
List<MessageModel> listMessageFake = [
  // MessageModel(
  //     imageUrl:
  //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGdhbus9QU3FSl_cwnCX6tCcxpYN-Wj5NVLg&usqp=CAU',
  //     fullName: 'Hà Anh Tuấn',
  //     message: 'Hát gì đi bạn ei :>'),
  // MessageModel(
  //     imageUrl:
  //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTywaXYb5-6bjevxgw_cD3bu0vcyW3J45g_w&usqp=CAU',
  //     fullName: 'Tuấn 5 củ',
  //     message: 'Liên minh ko em!!! :))'),
  // MessageModel(
  //     imageUrl:
  //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFjg_69eVjIeli08uXE09Z2ddWue-GINy2qg&usqp=CAU',
  //     fullName: 'Trung Ly Đeng',
  //     message: 'Đấm nhau khum'),
  MessageModel(
      imageUrl:
          'assets/image/Rectangle 785.png',
      fullName: 'Ali',
      message: 'Hi Consultant :)'),
  MessageModel(
      imageUrl:
          'assets/image/Rectangle 785.png',
      fullName: 'Fayaz',
      message: 'Kya ho raha hai'),
  MessageModel(
      imageUrl:
          'assets/image/Rectangle 785.png',
      fullName: 'Talha',
      message: 'Mera ek sawal hai'),
  MessageModel(
      imageUrl:
      'assets/image/Rectangle 785.png',
      fullName: 'User',
      message: 'Hello'),
  MessageModel(
      imageUrl:
      'assets/image/Rectangle 785.png',
      fullName: 'User 2',
      message: 'Namashkaar'),

];
