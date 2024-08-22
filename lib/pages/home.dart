import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/bloc/auth/auth_bloc.dart';
import 'package:flutter_firebase/bloc/states/auth_state.dart';

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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
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
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome ${state.user.username}'),
                
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