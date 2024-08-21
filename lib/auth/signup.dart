import 'package:flutter/material.dart';
import 'package:flutter_firebase/component/custom_text_field.dart';
import 'package:flutter_firebase/component/custome_elevated_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      body: Column(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // create clip path with background blue
              ClipPath(
                clipper:  const MyClipper(),
                child: Container(
                  height: 250,
                  width: double.infinity,
                  color: const Color(0xff1F41BB),
                ),
              ),
              Image.asset('lib/images/logo.png',height: 100,width: 100,),
              Container(
                margin: const EdgeInsets.only(top: 10,bottom: 50),
                child: const  SizedBox(
                  width: 250,
                  child:  Text('Create an account to get all features',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
                ),

              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: CustomTextField(text: 'username',controller: emailController,),
              ),
                  Container(
                margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: CustomTextField(text: 'Email',controller: passwordController,),
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: CustomTextField(text: 'Password',controller: passwordController,),
              ),

              
               Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                 child: Column(
                   children: [
                     SizedBox(
                      width: double.infinity,
                     
                       child: CustomElevatedButton(
                        text: 'Sign Up',
                        backgroundColor:const  Color(0xff1F41BB),
                        onPressed: () {
                         
                        },
                        )
                     ),
                      
                   ],
                 ),
               ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Have an account?',style: TextStyle(color: Color(0xff1F41BB),fontWeight: FontWeight.bold),),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, '/login');

                    }, child: const Text('Sign in',style: TextStyle(color: Color(0xffC70039),fontWeight: FontWeight.bold),))
                     
                  ],
                )
                 
              
            ],
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
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}