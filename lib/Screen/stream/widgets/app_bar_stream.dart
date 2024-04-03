// Flutter imports:
import 'package:astrobharat/utill/app_constants.dart';
import 'package:flutter/material.dart';

// Project imports:
import '../../../utill/color_resources.dart';
import '../../../utill/styles.dart';
import '../util/custom_image/custom_netword_image.dart';
import '../util/sizer_custom/sizer.dart';
import './name_live_widget.dart';
import './viewer_widget.dart';
import '../../../HttpService/model/Get_uesr_detali_model.dart';

class AppBarStream extends StatelessWidget {
  final Data consultantDetails;
  final Function onLeave;
  final bool isJoined;
  const AppBarStream({Key? key, required this.consultantDetails, required this.onLeave, required this.isJoined}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // const Expanded(
          //   child: FullnameLiveWidget(),
          // ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 4.sp,
                ),
                CustomNetworkImage(
                  height: 45.sp,
                  width: 45.sp,
                  urlToImage: "${AppConstants.IMAGE_VIEW}${consultantDetails.image}",
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
                          consultantDetails.fullName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
          SizedBox(
            width: 6.sp,
          ),
          if(isJoined)
            Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.055,
              width:  MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                color: ColorResources.ORANGE,
                borderRadius: BorderRadius.circular(5)),
              child: InkWell(
                onTap: () => onLeave(),
                child: FittedBox(
                  child: Text(
                    "Stop",
                    style: poppinsBold.copyWith(fontSize: 17,color: ColorResources.WHITE)),
                ),
              ),
            ),
          //Live count widget
          const ViewerWidget(),
        ],
      ),
    );
  }
}
