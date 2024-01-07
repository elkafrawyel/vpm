import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmerEffectUI extends StatelessWidget {
  final double width;
  final double height;
  final Color? baseColor;
  final Color? highlightColor;
  final BoxShape shapeShape;
  final int? seconds;

  const MyShimmerEffectUI.rectangular({
    Key? key,
    required this.height,
    this.baseColor,
    this.highlightColor,
    this.seconds,
    this.width = double.infinity,
  })  : shapeShape = BoxShape.rectangle,
        super(key: key);

  const MyShimmerEffectUI.circular({
    Key? key,
    required this.height,
    this.baseColor,
    this.highlightColor,
    this.seconds,
    this.width = double.infinity,
  })  : shapeShape = BoxShape.circle,
        super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey[300]!,
        highlightColor: highlightColor ?? Colors.white,
        period: Duration(seconds: seconds ?? 2),
        child: Container(
          padding: EdgeInsets.zero,
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey,
            shape: shapeShape,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
}
