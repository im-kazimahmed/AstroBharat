// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:

// Project imports:
import 'package:astrobharat/Screen/stream/util/custom_image/custom_netword_image.dart';
import 'package:astrobharat/Screen/stream/util/sizer_custom/sizer.dart';
import 'package:astrobharat/HttpService/model/message_model.dart';

class AuthorMessageCard extends StatefulWidget {
  final MessageModel messageModel;
  final bool pin;
  const AuthorMessageCard(
      {Key? key, required this.messageModel, required this.pin})
      : super(key: key);

  @override
  State<AuthorMessageCard> createState() => _AuthorMessageCardState();
}

class _AuthorMessageCardState extends State<AuthorMessageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.sp),
      margin: EdgeInsets.only(bottom: 5.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.sp),
        color: Colors.white.withOpacity(0.10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomNetworkImage(
            height: 32.sp,
            width: 32.sp,
            urlToImage: widget.messageModel.imageUrl,
            shape: BoxShape.circle,
          ),
          SizedBox(
            width: 10.sp,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.messageModel.fullName,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 2.sp,
                ),
                Text(
                  widget.messageModel.message,
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          widget.pin
              ? Container(
                  margin: EdgeInsets.only(left: 4.sp),
                  height: 30.sp,
                  width: 30.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.sp),
                    color: Colors.grey.withOpacity(0.28),
                  ),
                  child: Icon(
                    Icons.pin,
                    size: 16.0.sp,
                  ))
              : const SizedBox(),
        ],
      ),
    );
  }
}
