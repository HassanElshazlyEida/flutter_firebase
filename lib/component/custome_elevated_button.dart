import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? appendedWidget;
  final Color backgroundColor;
  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    this.appendedWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: backgroundColor,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            if (appendedWidget != null)
              const SizedBox(width: 8.0),
            if (appendedWidget != null)
              appendedWidget!,
          ],
        ),
      ),
    );
  }
}