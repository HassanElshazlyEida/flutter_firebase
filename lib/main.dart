import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/auth/login.dart';
import 'package:flutter_firebase/auth/signup.dart';
import 'package:flutter_firebase/bloc/auth/auth_bloc.dart';
import 'package:flutter_firebase/data/auth/repository/auth_repository_imp.dart';
import 'package:flutter_firebase/data/auth/source/auth_firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => AuthBloc(AuthRepositoryImp(AuthFirebaseServiceImp())),
        child: const SignUp(),
      ),
      routes: {
        '/login': (context) => const Login(),
        '/signup': (context) =>  const SignUp(),
      },
    );
  }
}
