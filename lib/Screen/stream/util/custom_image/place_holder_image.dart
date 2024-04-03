// Flutter imports:
import 'package:astrobharat/utill/color_resources.dart';
import 'package:flutter/material.dart';

import '../shimmer/fade_shimmer.dart';

// Project imports:


class PlaceHolderImage extends StatelessWidget {
  final double height;
  final double width;
  final BoxShape shape;
  final BorderRadiusGeometry? borderRadius;
  const PlaceHolderImage({
    Key? key,
    required this.height,
    required this.width,
    required this.shape,
    required this.borderRadius,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return shape == BoxShape.circle
        ? FadeShimmer.round(
            size: height,
            highlightColor: ColorResources.SKY_PINK,
            baseColor: ColorResources.ORANGE,
          )
        : FadeShimmer(
            width: width,
            height: height,
            highlightColor: ColorResources.SKY_PINK,
            baseColor: ColorResources.ORANGE,
            borderRadius: borderRadius,
          );
  }
}
