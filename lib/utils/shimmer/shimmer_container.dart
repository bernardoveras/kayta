import 'package:flutter/material.dart';
import 'package:kayta/utils/shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final double radius;

  const ShimmerContainer({this.height, this.width, this.color, this.radius = 3});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
