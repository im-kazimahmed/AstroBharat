// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../Controllers/stream_controller.dart';
import '../util/sizer_custom/sizer.dart';
import '../util/numeral/numeral.dart';

class ViewerWidget extends StatefulWidget {
  const ViewerWidget({Key? key}) : super(key: key);

  @override
  State<ViewerWidget> createState() => _ViewerWidgetState();
}

class _ViewerWidgetState extends State<ViewerWidget> {
  final LiveStreamController streamController = Get.find<LiveStreamController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 4),
      height: 30.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.sp),
        color: Colors.white.withOpacity(0.25),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.remove_red_eye_outlined,
              color: Colors.white,
              size: 14.sp,
            ),
            SizedBox(
              width: 2.sp,
            ),
            Obx(() =>
              Text(
                streamController.participantCount.toString(),
                style: TextStyle(fontSize: 11.sp, color: Colors.white),
              )
            ),
            SizedBox(
              width: 2.6.sp,
            ),
            Container(
              height: 16.sp,
              padding: EdgeInsets.symmetric(horizontal: 4.8.sp),
              decoration: BoxDecoration(
                color: Colors.red.shade700,
                borderRadius: BorderRadius.circular(18.sp),
              ),
              child: Center(
                child: Text(
                  'Live',
                  style: TextStyle(fontSize: 10.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
