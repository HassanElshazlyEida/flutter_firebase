import 'package:flutter/material.dart';
import 'package:flutter_firebase/component/custom_text_field.dart';

class FormHelper {
  static CustomTextField  email(TextEditingController controller){
    return CustomTextField(
          text: 'Email',
          controller: controller,
          validator: (value) {
            if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)) {
              return 'Please enter a valid email';
            }
            return null;
          },
    );
  }
  static CustomTextField password(TextEditingController controller){
    return CustomTextField(
        text: 'Password',
        controller: controller,
        isPassword: true,
        validator: (value) {
          if (value!.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
    );
  }
}