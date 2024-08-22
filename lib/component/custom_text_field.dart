import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final bool isPassword;
  const CustomTextField({
    Key? key,
    required this.text,
    required this.controller,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return   TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          fillColor: const Color(0xffF1F4FF),
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
          labelText: widget.text,
          
          suffixIcon: widget.isPassword
          ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
          : null,
       
        ),
        obscureText: widget.isPassword ? _obscureText : false,
      );
  }
}