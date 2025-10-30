import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  // Controlador
  final TextEditingController? controller;

  // Texto
  final String? hintText;
  final String? labelText;
  final String? initialValue;

  // Estilo
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;

  // Borda
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;

  // Ícones
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  // Comportamento
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final bool enabled;
  final bool autofocus;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  // Validação
  final String? Function(String?)? validator;
  final bool required;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;

  // Preenchimento
  final bool? filled;
  final Color? fillColor;

  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    Key? key,
    this.controller,
    this.hintText,
    this.labelText,
    this.initialValue,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.enabled = true,
    this.autofocus = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.validator,
    this.required = false,
    this.onChanged,
    this.onFieldSubmitted,
    this.filled,
    this.fillColor,
    this.inputFormatters,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      style: textStyle,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      enabled: enabled,
      autofocus: autofocus,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator ?? (required ? _defaultValidator : null),
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: hintStyle,
        labelStyle: labelStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: border??UnderlineInputBorder(),
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        errorBorder: errorBorder,
        isDense: true,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        filled: filled,
        fillColor: fillColor,
      ),
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '${labelText ?? "Campo"} é obrigatório';
    }
    return null;
  }
}
