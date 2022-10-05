import 'package:flutter/material.dart';

class UserFormFields extends StatelessWidget {
  const UserFormFields({
    super.key,
    required this.controller,
    required this.hint,
    required this.keyboardType,
    required this.action,
    required this.icon,
  });
  final TextEditingController controller;
  final String hint;

  final TextInputType keyboardType;
  final TextInputAction action;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      keyboardType: keyboardType,
      textInputAction: action,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
