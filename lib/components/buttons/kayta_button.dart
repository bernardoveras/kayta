import 'package:flutter/material.dart';
import 'package:kayta/components/circular_progress/kayta_circular_progress.dart';
import 'package:kayta/utils/scale_on_tap.dart';

class KaytaButton extends StatelessWidget {
  final String text;
  final String image;
  final Function onTap;
  final Function onLongPress;
  final Function onDoubleTap;
  final BorderRadius borderRadius;
  final TextStyle textStyle;
  final double iconSize;
  final double width;
  final double height;
  final double outlineWidth;
  final Color color;
  final Color textColor;
  final bool disabled;
  final bool outline;
  final bool invertColors;
  final bool isLoading;

   KaytaButton(
    this.text, {
    @required this.onTap,
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
  }):assert(text != null, "O parâmetro text não pode ser nulo");

  @override
  Widget build(BuildContext context) {
    return ScaleOnTap(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: Duration(seconds: 5),
        width: width,
        height: height,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: invertColors ? Colors.white : outline ? Colors.transparent : color != null ? color : onTap == null || disabled ? Colors.grey[300]: Theme.of(context).primaryColor,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          border: outline
              ? Border.all(color: color ?? Theme.of(context).primaryColor, width: outlineWidth)
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
            SizedBox(width: isLoading ? 10 : 0),
            isLoading ? KaytaCircularProgress(color: Colors.white, size:  MediaQuery.of(context).size.height * 0.02, lineWidth: 2) :SizedBox(),
          ],
        ),
      ),
    );
  }

  Color setTextColor(BuildContext context) {
    if (invertColors) return Theme.of(context).primaryColor;

    if (outline) return textColor ?? Theme.of(context).primaryColor;

    if (color == Colors.black) return Colors.white;

    return Colors.white;
  }

  Color setBackgroundColor(BuildContext context) {
    if (invertColors) return Colors.white;

    if (outline) return Colors.transparent;

    if (color != null) return color;

    return onTap == null || disabled
        ? Colors.grey[300]
        : Theme.of(context).primaryColor;
  }
}
