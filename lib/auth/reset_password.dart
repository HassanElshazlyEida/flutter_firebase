import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/bloc/auth/auth_bloc.dart';
import 'package:flutter_firebase/bloc/events/auth_event.dart';
import 'package:flutter_firebase/bloc/states/auth_state.dart';
import 'package:flutter_firebase/component/custome_elevated_button.dart';
import 'package:flutter_firebase/component/helpers/form_helper.dart';
import 'package:flutter_firebase/component/helpers/helper.dart';
import 'package:flutter_firebase/component/navbar.dart';
import 'package:flutter_firebase/data/auth/source/auth_firebase_service.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();  
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset password'),
      ),
      body : BlocBuilder<AuthBloc, AuthState>(
       builder: (context, state) {
        return Form(
              key: _formKey,
              child:  Column(  
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Navbar(text: 'Reset your password'),
                Container(
                    margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: FormHelper.email(emailController),
                ),
                Container(
                  margin:  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SizedBox(
                    child: CustomElevatedButton(
                      text: 'Reset password',
                      backgroundColor: const Color(0xff1F41BB),
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                             try {
                              BlocProvider.of<AuthBloc>(context).emit(AuthLoading());

                              BlocProvider.of<AuthBloc>(context).add(ResetEmailRequested(email: emailController.text));

                              Navigator.pushNamed(context, '/login');

                            } catch (error) {
                              print('$error');
                              Helper.showMessage(context, 'Failed to send an email');
                            }
                        }
                      },
                    ),
                  ),
                ),
              ]
            )
        );
       
      }));
  }
}