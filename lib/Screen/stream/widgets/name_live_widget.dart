// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../util/common/touchable_opacity.dart';
import '../util/sizer_custom/sizer.dart';
import '../util/custom_image/custom_netword_image.dart';

class FullnameLiveWidget extends StatelessWidget {
  const FullnameLiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 4.sp,
        ),
        CustomNetworkImage(
          height: 45.sp,
          width: 45.sp,
          urlToImage:
              'assets/image/Rectangle 785.png',
          shape: BoxShape.circle,
        ),
        SizedBox(
          width: 10.sp,
        ),
        Expanded(
          child: SizedBox(
            height: 48.sp,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Consultant Name',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                // Text(
                //   '159K Followers',
                //   overflow: TextOverflow.ellipsis,
                //   style: TextStyle(
                //       fontSize: 10.sp,
                //       fontWeight: FontWeight.w400,
                //       color: Colors.white),
                // ),
              ],
            ),
          ),
        ),
        // TouchableOpacity(
        //   child: Container(
        //     margin: EdgeInsets.only(right: 8.sp),
        //     padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.8.sp),
        //     decoration: BoxDecoration(
        //       color: Colors.blue.shade700,
        //       borderRadius: BorderRadius.circular(20.sp),
        //     ),
        //     child: Text(
        //       'Follow',
        //       style: TextStyle(fontSize: 10.sp, color: Colors.white),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
