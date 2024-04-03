import 'package:astrobharat/Screen/stream/util/sizer_custom/sizer.dart';
import 'package:astrobharat/utill/app_constants.dart';
import 'package:flutter/material.dart';

import '../../Screen/stream/util/custom_image/custom_netword_image.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final String userImage;
  final bool sentByMe;

  const MessageTile(
      {Key? key,
      required this.message,
      required this.sender,
      required this.userImage,
      required this.sentByMe})
      : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.sp),
      padding:
          const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.sp),
        color: Colors.black.withOpacity(0.40),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImage(
            height: 32.sp,
            width: 32.sp,
            urlToImage: "${AppConstants.IMAGE_VIEW}${widget.userImage}",
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
                  widget.sentByMe ? "${widget.sender.toUpperCase()} (You)": widget.sender.toUpperCase(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 2.sp,
                ),
                Text(widget.message,
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
