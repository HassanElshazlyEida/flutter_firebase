import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/bloc/auth/auth_bloc.dart';
import 'package:flutter_firebase/bloc/states/auth_state.dart';
import 'package:flutter_firebase/component/helpers/helper.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // bloc consumer with user details

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        print('home');
        print(state.toString());
        if (state is AuthError) {
          Helper.showMessage(context, state.message);
        }else if (state is AuthUnAuthenticated) {
          Navigator.of(context).pushReplacementNamed('/login');
        }else if (state is AuthAuthenticated) {
          print(state.user.username);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthAuthenticated) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome ${state.user.email}'),
                
                ],
              ),
            ),
          );

        } 
        return  Center(child: Text(state.toString()));
        
      },
    );

  }
}