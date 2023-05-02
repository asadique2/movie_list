import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final int? maxLength;
  final int? maxLines;
  final TextInputType textInputType;
  final TextEditingController wrapper;
  final bool isEnabled;
  final bool obscureText;
  final bool isMandatory;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final onTap;
  final Function(String)? onChanged;
  final validator;
  final TextCapitalization? textCapitalization;

  const CommonTextField({
    Key? key,
    required this.wrapper,
    this.label,
    this.hint,
    this.maxLength,
    this.textInputType = TextInputType.text,
    this.isEnabled = true,
    this.obscureText = false,
    this.isMandatory = false,
    this.suffixIcon,
    this.textInputAction,
    this.validator,
    this.onTap,
    this.maxLines = 1,
    this.textCapitalization,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: wrapper,
      maxLength: maxLength,
      keyboardType: textInputType,
      enabled: isEnabled,
      obscureText: obscureText,
      validator: validator,
      maxLines: maxLines,
      onChanged: onChanged,
      readOnly: onTap != null ? true : false,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
        errorMaxLines: null,
        isDense: true,
        counterText: '',
        hintText: hint ?? label,
        enabled: isEnabled,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(8.0),
        ),
        border: border,
        enabledBorder: border,
        disabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}

final OutlineInputBorder border = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.black),
  borderRadius: BorderRadius.circular(8.0),
);
