import 'package:flutter/material.dart';

class Helper {

  static showMessage(BuildContext context, String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        ),
      );
  }

}