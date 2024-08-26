
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase/component/main_clipper.dart';

class Navbar extends StatelessWidget {
  final String text;

  const Navbar({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         const MainClipper(),
          Image.asset(
            'lib/images/logo.png',
            height: 100,
            width: 100,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 50),
            child:  SizedBox(
              width: 250,
              child: Text(text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
      ]
    );
  }
}