// Flutter imports:
// ignore_for_file: depend_on_referenced_packages

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../util/sizer_custom/sizer.dart';
import '../provider/hearts_provider.dart';

class FloatingHeartsWidget extends StatelessWidget {
  const FloatingHeartsWidget({super.key});
  @override
  Widget build(BuildContext context) {
    FloatingHeartsProvider floatingHeartsProvider =
        context.watch<FloatingHeartsProvider>();

    return Padding(
      padding: EdgeInsets.only(bottom: 8.sp),
      child: Align(
        alignment: Alignment.bottomRight,
        child: SizedBox(
          width: 40.sp,
          child: Stack(children: floatingHeartsProvider.hearts),
        ),
      ),
    );
  }
}
