import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color? color;
  final BorderRadiusGeometry? radius;

  const ShimmerContainer({
    required this.height,
    required this.width,
    this.color = Colors.white,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.white,
      // loop: 3,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: radius ?? BorderRadius.circular(3),
        ),
      ),
    );
  }
}
