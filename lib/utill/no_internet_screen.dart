import 'package:astrobharat/utill/styles.dart';
import 'package:flutter/material.dart';
import 'app_constants.dart';
import 'color_resources.dart';
import 'dimensions.dart';
import 'images.dart';

class NoInternetOrDataScreen extends StatelessWidget {
  final bool isNoInternet;
  final Widget? child;
  NoInternetOrDataScreen({required this.isNoInternet, this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppConstants.itemHeight*0.025,vertical: AppConstants.itemHeight*0.1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.025),
          color: ColorResources.WHITE,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(isNoInternet ? Images.opps_internet : Images.no_data, width: 160, height: 160),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              DefaultTextStyle(
                style: poppinsBold.copyWith(
                  fontSize: 30,
                  color: isNoInternet ? Theme.of(context).textTheme.bodyText1?.color : ColorResources.BLACK,
                ),
                child: Text(isNoInternet ? "Oops!" : "Sorry!",),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              DefaultTextStyle(
                textAlign: TextAlign.center,
                style: poppinsRegular, child: Text(isNoInternet ? "No internet connection" : 'No data found',),
              ),
              SizedBox(height: 40),
              isNoInternet ? Container(
                height: 45,
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(// borderRadius: BorderRadius.circular(5.0)
                    borderRadius: BorderRadius.circular(0.0), color: ColorResources.COLOR_PRIMERY),
                child: TextButton(
                  onPressed: () async {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text("Try again", style: poppinsMedium.copyWith(color: Theme.of(context).highlightColor, fontSize: Dimensions.FONT_SIZE_16)),
                  ),
                ),
              ) : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

// class DataNotFoundScreen extends StatelessWidget {
//   DataNotFoundScreen();
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.015),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(Images.no_data, width: 150, height: 150),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class BannerNotFoundScreen extends StatelessWidget {
//   String title;
//   BannerNotFoundScreen(this.title);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.025),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: 20),
//             Text("માફ કરશો !", style: poppinsBold.copyWith(
//               fontSize: 30,
//               color: ColorResources.getBlack(context),
//             )),
//             SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: poppinsRegular,
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
