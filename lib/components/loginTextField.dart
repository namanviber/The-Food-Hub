import 'package:flutter/material.dart';
import 'package:thefoodhub/controllers/auth_controllers.dart';

class ReusableTextField extends StatelessWidget {
  ReusableTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    required String? Function(dynamic value) validator,
    required bool obscureText,
  }) : super(key: key);
  final String labelText;
  final TextEditingController controller;
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (labelText == 'Email') {
          // Email validation
          if (authController.validateEmail(value!) != null) {
            return 'Please enter a valid email address';
          }
        } else if (labelText == 'Password') {
          // Password validation
          if (value!.isEmpty) {
            return 'Please enter a password';
          } else if (value.length < 6) {
            return 'Password must be at least 6 characters';
          }
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.deepOrange,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.deepOrange,
          ),
        ),
      ),
    );
  }
}
