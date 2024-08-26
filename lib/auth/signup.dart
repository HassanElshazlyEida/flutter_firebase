import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/bloc/auth/auth_bloc.dart';
import 'package:flutter_firebase/bloc/events/auth_event.dart';
import 'package:flutter_firebase/bloc/states/auth_state.dart';
import 'package:flutter_firebase/component/custom_text_field.dart';
import 'package:flutter_firebase/component/custome_elevated_button.dart';
import 'package:flutter_firebase/component/helpers/form_helper.dart';
import 'package:flutter_firebase/component/helpers/helper.dart';
import 'package:flutter_firebase/component/navbar.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
    body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
          if (state is AuthError) {
            Helper.showMessage(context, state.message);
          } else if (state is AuthSentVerify) {
            Helper.showMessage(context, 'An verification link has been sent to your email');
            Navigator.pushNamed(context, '/login');
          }else {
            print(state);
          }
        },
        builder: (context, state) {         
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Form(
              key: _formKey,
              child: Column(  
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // create clip path with background blue
                const Navbar(text: 'Create an account to get all features'),

                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: CustomTextField(
                    text: 'username',
                    controller: usernameController,
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: FormHelper.email(emailController),
                ),
              
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: FormHelper.password(passwordController),
                ),
              
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                            text: 'Sign Up',
                            backgroundColor: const Color(0xff1F41BB),
                            onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                BlocProvider.of<AuthBloc>(context).add(
                                  SignUpRequested(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    username: usernameController.text,
                                  ),
                                );
                              }
                              
                            },
                          )),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Have an account?',
                      style: TextStyle(
                          color: Color(0xff1F41BB), fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                              color: Color(0xffC70039),
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
                        ),
            );

          
            }
      ),
    );
  }
}

