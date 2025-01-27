import 'package:flutter/material.dart';

class CTextFormField extends StatelessWidget {
  const CTextFormField({
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.initialValue,
    this.showCounter,
    this.controller,
    this.onSaved,
    this.validator,
    this.obscureText,
    this.autoValidate = false,
    this.autoValidateMode,
    this.autofillHints,
    this.isLastTextField = false,
    this.onChanged,
    this.maxLength,
    this.textAlign = TextAlign.left,
    this.keyboardType,
    this.multiLine = false,
    this.enabled = true,
    this.textString,
    this.minLines = 5,
    this.onEditingComplete,
    this.focusNode,
    this.onTap,
    this.paddingVertical,
    this.readOnly = false,
    this.trailingIcon,
    this.prefixIcon,
    super.key
  });

  final int? minLines;
  final int? maxLength;
  final bool? showCounter;
  final bool multiLine;
  final bool isLastTextField;
  final bool? obscureText;
  final bool autoValidate;
  final AutovalidateMode? autoValidateMode;
  final bool? enabled;
  final String? textString;
  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Function()? onTap;
  final TextAlign textAlign;
  final Iterable<String>? autofillHints;
  final Function? onEditingComplete;
  final FocusNode? focusNode;
  final double? paddingVertical;
  final bool readOnly;
  final Widget? trailingIcon;
   final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      enabled: enabled,
      style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black
      ),
      readOnly: readOnly,
      maxLength: maxLength,
      obscureText: obscureText ?? false,
      onTap: onTap,
      initialValue: initialValue,
      controller: controller,
      autovalidateMode: autoValidateMode ?? AutovalidateMode.disabled,
      autofillHints: autofillHints,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: keyboardType,
      textAlign: textAlign,
      minLines: multiLine ? minLines : 1,
      maxLines: multiLine ? minLines! * 2 : 1,
      textInputAction:
      isLastTextField ? TextInputAction.done : TextInputAction.next,
      onFieldSubmitted: (_) =>
      isLastTextField ? null : FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
        contentPadding:
        EdgeInsets.symmetric(vertical: paddingVertical ?? 0.0, horizontal: 20.0),
        hintText: hintText,
        isDense: true,
        hintStyle: hintStyle,
        filled: true,
        prefixIcon: prefixIcon,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 30,
          minHeight: 30,
        ),
        suffixIcon: trailingIcon ?? const SizedBox(),
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Colors.white,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Colors.white,
            )) ,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
                color: Colors.white
            )
        ),
      ),
    );
  }
}