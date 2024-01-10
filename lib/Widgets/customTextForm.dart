import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? prefixIcon;
  final bool obscureText;
  bool? expand;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.expand,
    this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: expand == null ? 1 : null,
      minLines: expand == null ? 1 : null,
      expands: expand ?? false,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
