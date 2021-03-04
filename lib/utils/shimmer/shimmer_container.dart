import 'package:flutter/material.dart';
import 'package:kayta/utils/shimmer/shimmer.dart';

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
    return Shimmer(
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
