import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kayta/constants/colors.dart';
import 'package:kayta/utils/scale_on_tap.dart';

// ignore: must_be_immutable
class KaytaTextField extends StatefulWidget {
  final String? hintText;
  final String? errorText;
  final String? initialValue;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Color? iconColor;
  final bool? autocorrect;
  final bool? enableSuggestions;
  final bool obscure;
  final Function(String?)? onChanged;
  final Function(String?)? onFieldSubmitted;
  final IconData? leftIcon;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final TextAlign textAlign;

  KaytaTextField({
    this.controller,
    this.onChanged,
    this.hintText,
    this.leftIcon,
    this.hintStyle,
    this.style,
    this.inputFormatters,
    this.keyboardType,
    this.focusNode,
    this.textInputAction,
    this.autocorrect = false,
    this.enableSuggestions = false,
    this.obscure = false,
    this.iconColor,
    this.onFieldSubmitted,
    this.errorText,
    this.initialValue,
    this.textAlign = TextAlign.start,
  });

  @override
  _KaytaTextFieldState createState() => _KaytaTextFieldState();
}

class _KaytaTextFieldState extends State<KaytaTextField> {
  late bool showPass;

  @override
  void initState() {
    super.initState();
    showPass = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomLeft,
      children: [
        widget.errorText != null
            ? Positioned(
                child: Text(
                  widget.errorText ?? '',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                bottom: -20,
              )
            : SizedBox(),
        TextFormField(
          onChanged: widget.onChanged,
          style: widget.style,
          controller: widget.controller,
          textAlign: widget.textAlign,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: Theme.of(context).primaryColor,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          focusNode: widget.focusNode,
          obscureText: showPass,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          initialValue: widget.initialValue,
          scrollPhysics: BouncingScrollPhysics(),
          decoration: InputDecoration(
            suffixIcon: widget.errorText != null
                ? Icon(Icons.error_rounded, color: errorColor)
                : widget.obscure
                    ? ScaleOnTap(
                        child: Icon(showPass
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded),
                        onTap: () => setState(() => showPass = !showPass),
                      )
                    : null,
            hintText: widget.hintText,
            contentPadding: EdgeInsets.only(left: 15, right: 0),
            prefixIcon: widget.leftIcon != null
                ? Icon(widget.leftIcon,
                    color: widget.errorText != null
                        ? errorColor
                        : widget.iconColor ?? Colors.grey[500])
                : null,
            hintStyle: widget.hintStyle ?? TextStyle(color: Colors.grey[500]),
            alignLabelWithHint: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: widget.errorText != null ? Colors.red : Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: widget.errorText != null ? Colors.red : Colors.grey),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: widget.errorText != null ? Colors.red : Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: widget.errorText != null ? Colors.red : Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
