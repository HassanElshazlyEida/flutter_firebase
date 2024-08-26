import 'package:flutter/material.dart';

class MainClipper extends StatelessWidget {
  const MainClipper({super.key});

  @override
  Widget build(BuildContext context) {
    return   ClipPath(
      clipper: const MyClipper(),
      child: Container(
        height: 250,
        width: double.infinity,
        color: const Color(0xff1F41BB),
      ),
    );
  }
}
class MyClipper extends CustomClipper<Path> {
  const MyClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
