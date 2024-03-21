import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final IconData? suffixIconVisible;
  final IconData? suffixIconNull;
  final String? prefixText;
  final EdgeInsets? contentPadding;
  final bool obscureText;
  final TextEditingController? controller;
  final String? labelText;
  final TextInputType keyboardType;
  final bool enabled;
  final double? prefixIconsSize;
  final void Function(String)? onFieldSubmitted;
  final String? initialValue;
  void Function(String)? onChanged;

  CustomTextFormField({
    Key? key,
    this.hintText,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconVisible,
    this.suffixIconNull,
    this.prefixText,
    this.contentPadding,
    this.obscureText = false,
    this.controller,
    this.labelText,
    this.prefixIconsSize,
    this.onFieldSubmitted,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      controller: widget.controller,
      enabled: widget.enabled,
      onFieldSubmitted: widget.onFieldSubmitted,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                size: widget.prefixIconsSize,
              )
            : null,
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                icon: Icon(_obscureText
                    ? widget.suffixIcon
                    : widget.suffixIconVisible),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : (widget.keyboardType == TextInputType.visiblePassword
                ? IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : (widget.suffixIconNull != null
                    ? Icon(widget.suffixIconNull)
                    : null)),
        prefixText: widget.prefixText,
        contentPadding: widget.contentPadding,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
