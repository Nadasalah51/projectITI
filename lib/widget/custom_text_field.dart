import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key, this.hintText, this.onChange, this.obscure = false});
  final String? hintText;
  final Function(String)? onChange;
  @override
  final bool obscure;
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
      },
      style: const TextStyle(color: Colors.white70),
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: const TextStyle(color: Colors.white60),
        fillColor: Colors.white60,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
// TextField(
// decoration: InputDecoration(
// hintText: hintText,
// hintStyle: const TextStyle(color: Colors.white60),
// counterStyle: const TextStyle(color: Colors.white),
// enabledBorder: OutlineInputBorder(
// borderSide: const BorderSide(color: Colors.white),
// borderRadius: BorderRadius.circular(20),
// ),
// disabledBorder: const OutlineInputBorder(
// borderSide: BorderSide(color: Colors.white),
// ),
// border: OutlineInputBorder(
// // borderSide: const BorderSide(color: Colors.white),
// borderRadius: BorderRadius.circular(20),
// ),
// ),
// );
