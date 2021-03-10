import 'package:flutter/material.dart';
import 'package:kayta/components/circular_progress/kayta_circular_progress.dart';
import 'package:kayta/utils/scale_on_tap.dart';

class KaytaButton extends StatelessWidget {
  final String text;
  final String? image;
  final Function()? onTap;
  final Function()? onLongPress;
  final Function()? onDoubleTap;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final double? iconSize;
  final double? width;
  final double? height;
  final double? outlineWidth;
  final Color? color;
  final Color? textColor;
  final bool? disabled;
  final bool? outline;
  final bool? invertColors;
  final bool? isLoading;
  final bool animate;

  KaytaButton(
    this.text, {
    required this.onTap,
    this.image,
    this.height = 45,
    this.color,
    this.width,
    this.iconSize = 24,
    this.onLongPress,
    this.onDoubleTap,
    this.borderRadius,
    this.disabled = false,
    this.outline = false,
    this.invertColors = false,
    this.isLoading = false,
    this.textColor,
    this.textStyle,
    this.outlineWidth = 2,
    this.animate = false,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleOnTap(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: Duration(seconds: animate == true ? 5 : 0),
        width: width,
        height: height,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: invertColors == true
              ? Colors.white
              : outline == true
                  ? Colors.transparent
                  : color != null
                      ? color
                      : onTap == null || disabled == true
                          ? Colors.grey[300]
                          : Theme.of(context).primaryColor,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          border: outline == true
              ? Border.all(
                  color: color ?? Theme.of(context).primaryColor,
                  width: outlineWidth ?? 1.0)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height,
              width: width,
              padding: EdgeInsets.zero,
              child: Center(
                child: Text(
                  text.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle ??
                      TextStyle(
                        color: setTextColor(context),
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                      ),
                ),
              ),
            ),
            SizedBox(width: isLoading == true ? 10 : 0),
            isLoading == true 
                ? KaytaCircularProgress(
                    color: Colors.white,
                    size: MediaQuery.of(context).size.height * 0.02,
                    lineWidth: 2)
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Color setTextColor(BuildContext context) {
    if (invertColors == true) return Theme.of(context).primaryColor;

    if (outline == true) return textColor ?? Theme.of(context).primaryColor;

    if (color == Colors.black) return Colors.white;

    return Colors.white;
  }

  Color setBackgroundColor(BuildContext context) {
    if (invertColors == true) return Colors.white;

    if (outline == true) return Colors.transparent;

    if (color != null) return color!;

    return onTap == null || disabled == true
        ? Colors.grey[300]!
        : Theme.of(context).primaryColor;
  }
}
