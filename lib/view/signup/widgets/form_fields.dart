import 'package:flutter/material.dart';

class SignUpFormFields extends StatelessWidget {
  const SignUpFormFields({
    super.key,
    required this.controller,
    required this.hint,
    required this.obscure,
    required this.keyboardType,
    required this.action,
    required this.icon,
    required this.validator,
  });
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final TextInputType keyboardType;
  final TextInputAction action;
  final IconData icon;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      keyboardType: keyboardType,
      textInputAction: action,
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
