// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';

// /// A material design checkbox.
// ///
// /// The checkbox itself does not maintain any state. Instead, when the state of
// /// the checkbox changes, the widget calls the [onChanged] callback. Most
// /// widgets that use a checkbox will listen for the [onChanged] callback and
// /// rebuild the checkbox with a new [value] to update the visual appearance of
// /// the checkbox.
// ///
// /// The checkbox can optionally display three values - true, false, and null -
// /// if [tristate] is true. When [value] is null a dash is displayed. By default
// /// [tristate] is false and the checkbox's [value] must be true or false.
// ///
// /// Requires one of its ancestors to be a [Material] widget.
// ///
// /// See also:
// ///
// ///  * [CheckboxListTile], which combines this widget with a [ListTile] so that
// ///    you can give the checkbox a label.
// ///  * [Switch], a widget with semantics similar to [KaytaCheckbox].
// ///  * [Radio], for selecting among a set of explicit values.
// ///  * [Slider], for selecting a value in a range.
// class KaytaCheckbox extends StatefulWidget {
//   const KaytaCheckbox({
//     Key? key,
//     required this.value,
//     required this.onChanged,
//     this.activeColor,
//     this.tristate = false,
//     this.materialTapTargetSize,
//     this.splashRadius = 35.0,
//   }) : super(key: key);
//   final bool value;
//   final ValueChanged<bool?>? onChanged;
//   final Color? activeColor;
//   final bool tristate;
//   final MaterialTapTargetSize? materialTapTargetSize;
//   final double splashRadius;
//   static const double width = 14.0;
//   @override
//   _KaytaCheckboxState createState() => _KaytaCheckboxState();
// }

// class _KaytaCheckboxState extends State<KaytaCheckbox>
//     with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     assert(debugCheckHasMaterial(context));
//     final ThemeData themeData = Theme.of(context);
//     Size size;
//     switch (widget.materialTapTargetSize ?? themeData.materialTapTargetSize) {
//       case MaterialTapTargetSize.padded:
//         size = const Size(
//             kRadialReactionRadius + 8.0, kRadialReactionRadius + 8.0);
//         break;
//       case MaterialTapTargetSize.shrinkWrap:
//         size = const Size(
//             16.0, 16.0); //ZSize(kRadialReactionRadius, kRadialReactionRadius);
//         break;
//     }
//     final BoxConstraints additionalConstraints = BoxConstraints.tight(size);
//     return _CheckboxRenderObjectWidget(
//       value: widget.value,
//       tristate: widget.tristate,
//       splashRadius: widget.splashRadius,
//       activeColor: widget.activeColor ?? themeData.toggleableActiveColor,
//       inactiveColor: widget.onChanged != null
//           ? themeData.unselectedWidgetColor
//           : themeData.disabledColor,
//       onChanged: widget.onChanged ?? (v) {},
//       additionalConstraints: additionalConstraints,
//       vsync: this,
//     );
//   }
// }

// class _CheckboxRenderObjectWidget extends LeafRenderObjectWidget {
//   const _CheckboxRenderObjectWidget({
//     Key? key,
//     required this.value,
//     required this.tristate,
//     required this.activeColor,
//     required this.inactiveColor,
//     required this.onChanged,
//     required this.vsync,
//     required this.additionalConstraints,
//     required this.splashRadius,
//   }) : super(key: key);
//   final bool value;
//   final bool tristate;
//   final Color activeColor;
//   final Color inactiveColor;
//   final ValueChanged<bool?> onChanged;
//   final TickerProvider vsync;
//   final BoxConstraints additionalConstraints;
//   final double splashRadius;
//   @override
//   _RenderCheckbox createRenderObject(BuildContext context) => _RenderCheckbox(
//         value: value,
//         tristate: tristate,
//         activeColor: activeColor,
//         inactiveColor: inactiveColor,
//         onChanged: onChanged,
//         vsync: vsync,
//         additionalConstraints: additionalConstraints,
//         splashRadius: splashRadius,
//       );
//   @override
//   void updateRenderObject(BuildContext context, _RenderCheckbox renderObject) {
//     renderObject
//       ..value = value
//       ..tristate = tristate
//       ..activeColor = activeColor
//       ..inactiveColor = inactiveColor
//       ..onChanged = onChanged
//       ..additionalConstraints = additionalConstraints
//       ..vsync = vsync;
//   }
// }

// const double _kEdgeSize = KaytaCheckbox.width + 2.0;
// const Radius _kEdgeRadius = Radius.circular(KaytaCheckbox.width);
// const double _kStrokeWidth = 2.0;

// class _RenderCheckbox extends RenderToggleable {
//   _RenderCheckbox({
//     required bool value,
//     required ValueChanged<bool?> onChanged,
//     required BoxConstraints additionalConstraints,
//     required bool tristate,
//     required Color activeColor,
//     required Color inactiveColor,
//     required TickerProvider vsync,
//     required double splashRadius,
//   })   : _oldValue = value,
//         super(
//           value: value,
//           tristate: tristate,
//           activeColor: activeColor,
//           inactiveColor: inactiveColor,
//           onChanged: onChanged,
//           additionalConstraints: additionalConstraints,
//           splashRadius: splashRadius,
//           vsync: vsync,
//         );
//   bool? _oldValue;
//   @override
//   set value(bool? newValue) {
//     if (newValue == value) return;
//     _oldValue = value;
//     super.value = newValue;
//   }

//   @override
//   void describeSemanticsConfiguration(SemanticsConfiguration config) {
//     super.describeSemanticsConfiguration(config);
//     config.isChecked = value == true;
//   }

//   // The square outer bounds of the checkbox at t, with the specified origin.
//   // At t == 0.0, the outer rect's size is _kEdgeSize (Checkbox.width)
//   // At t == 0.5, .. is _kEdgeSize - _kStrokeWidth
//   // At t == 1.0, .. is _kEdgeSize
//   RRect _outerRectAt(Offset origin, double t) {
//     final double inset = 1.0 - (t - 0.5).abs() * 2.0;
//     final double size = _kEdgeSize - inset * _kStrokeWidth;
//     final Rect rect =
//         Rect.fromLTWH(origin.dx + inset, origin.dy + inset, size, size);
//     return RRect.fromRectAndRadius(rect, _kEdgeRadius);
//   }

//   // The checkbox's border color if value == false, or its fill color when
//   // value == true or null.
//   Color? _colorAt(double t) {
//     // As t goes from 0.0 to 0.25, animate from the inactiveColor to activeColor.
//     return onChanged == null
//         ? inactiveColor
//         : (t >= 0.25
//             ? activeColor
//             : Color.lerp(inactiveColor, activeColor, t * 4.0));
//   }

//   // White stroke used to paint the check and dash.
//   void _initStrokePaint(Paint paint) {
//     paint
//       ..color = const Color(0xFFFFFFFF)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = _kStrokeWidth;
//   }

//   void _drawBorder(Canvas canvas, RRect outer, double t, Paint paint) {
//     assert(t >= 0.0 && t <= 0.5);
//     final double size = outer.width;
//     // As t goes from 0.0 to 1.0, gradually fill the outer RRect.
//     RRect inner = outer.deflate(math.min(size / 1.0, _kStrokeWidth + size * t));
// //    inner = RRect.fromRectAndRadius(inner.outerRect, Radius.circular(outer.width));
//     canvas.drawDRRect(outer, inner, paint);
//   }

//   void _drawCheck(Canvas canvas, Offset origin, double t, Paint paint) {
//     assert(t >= 0.0 && t <= 1.0);
//     // As t goes from 0.0 to 1.0, animate the two check mark strokes from the
//     // short side to the long side.
//     final Path path = Path();
//     const Offset? start = Offset(_kEdgeSize * 0.25, _kEdgeSize * 0.55);
//     const Offset? mid = Offset(_kEdgeSize * 0.4, _kEdgeSize * 0.7);
//     const Offset? end = Offset(_kEdgeSize * 0.75, _kEdgeSize * 0.35);
//     if (t < 0.5) {
//       final double strokeT = t * 2.0;
//       final Offset drawMid = Offset.lerp(start, mid, strokeT)!;
//       path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
//       path.lineTo(origin.dx + drawMid.dx, origin.dy + drawMid.dy);
//     } else {
//       final double strokeT = (t - 0.5) * 2.0;
//       final Offset drawEnd = Offset.lerp(mid, end, strokeT)!;
//       path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
//       path.lineTo(origin.dx + mid.dx, origin.dy + mid.dy);
//       path.lineTo(origin.dx + drawEnd.dx, origin.dy + drawEnd.dy);
//     }
//     canvas.drawPath(path, paint);
//   }

//   void _drawDash(Canvas canvas, Offset origin, double t, Paint paint) {
//     assert(t >= 0.0 && t <= 1.0);
//     // As t goes from 0.0 to 1.0, animate the horizontal line from the
//     // mid point outwards.
//     const Offset? start = Offset(_kEdgeSize * 0.2, _kEdgeSize * 0.5);
//     const Offset? mid = Offset(_kEdgeSize * 0.5, _kEdgeSize * 0.5);
//     const Offset? end = Offset(_kEdgeSize * 0.8, _kEdgeSize * 0.5);
//     final Offset drawStart = Offset.lerp(start, mid, 1.0 - t)!;
//     final Offset drawEnd = Offset.lerp(mid, end, t)!;
//     canvas.drawLine(origin + drawStart, origin + drawEnd, paint);
//   }

//   @override
//   void paint(PaintingContext context, Offset offset) {
//     final Canvas canvas = context.canvas;
//     paintRadialReaction(canvas, offset, size.center(Offset.zero));
//     final Offset origin =
//         offset + (size / 2.0 - const Size.square(_kEdgeSize) / 2.0);
//     final AnimationStatus status = position.status;
//     final double tNormalized =
//         status == AnimationStatus.forward || status == AnimationStatus.completed
//             ? position.value
//             : 1.0 - position.value;
//     // Four cases: false to null, false to true, null to false, true to false
//     if (_oldValue == false || value == false) {
//       final double t = value == false ? 1.0 - tNormalized : tNormalized;
//       final RRect outer = _outerRectAt(origin, t);
//       final Paint paint = Paint()..color = _colorAt(t) ?? Colors.red;
//       if (t <= 0.5) {
//         _drawBorder(canvas, outer, t, paint);
//       } else {
//         canvas.drawRRect(outer, paint);
//         _initStrokePaint(paint);
//         final double tShrink = (t - 0.5) * 2.0;
//         if (_oldValue == null)
//           _drawDash(canvas, origin, tShrink, paint);
//         else
//           _drawCheck(canvas, origin, tShrink, paint);
//       }
//     } else {
//       // Two cases: null to true, true to null
//       final RRect outer = _outerRectAt(origin, 1.0);
//       final Paint paint = Paint()..color = _colorAt(1.0) ?? Colors.red;
//       canvas.drawRRect(outer, paint);
//       _initStrokePaint(paint);
//       if (tNormalized <= 0.5) {
//         final double tShrink = 1.0 - tNormalized * 2.0;
//         if (_oldValue == true)
//           _drawCheck(canvas, origin, tShrink, paint);
//         else
//           _drawDash(canvas, origin, tShrink, paint);
//       } else {
//         final double tExpand = (tNormalized - 0.5) * 2.0;
//         if (value == true)
//           _drawCheck(canvas, origin, tExpand, paint);
//         else
//           _drawDash(canvas, origin, tExpand, paint);
//       }
//     }
//   }
// }
