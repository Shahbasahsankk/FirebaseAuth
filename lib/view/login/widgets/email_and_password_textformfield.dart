import 'package:flutter/material.dart';

class EmailAndPasswordFormfield extends StatelessWidget {
  const EmailAndPasswordFormfield({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.action,
    required this.icon,
    required this.hint,
    required this.obscure,
    required this.validator,
  });
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction action;
  final IconData icon;
  final String hint;
  final bool obscure;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: action,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: obscure,
    );
  }
}
