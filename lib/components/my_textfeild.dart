import 'package:flutter/material.dart';

class MyTextfeild extends StatelessWidget {
  final String hintText;
  final Icon? icon;
  final bool obscureText;
  final TextEditingController controller; // Added controller

  const MyTextfeild({
    super.key,
    required this.hintText,
    this.icon,
    required this.obscureText,
    required this.controller, // Required controller
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller, // Assign controller here
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          prefixIcon: icon,
        ),
      ),
    );
  }
}
