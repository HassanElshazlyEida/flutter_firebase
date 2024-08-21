import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.text,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   TextField(
        decoration: InputDecoration(
          fillColor: Color(0xffF1F4FF),
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide.none
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide(
              color: Color(0xff1F41BB), // Color when focused
            ),
          ),
          labelText: text,
        ),
      );
  }
}