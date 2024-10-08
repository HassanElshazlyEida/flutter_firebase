import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/auth/login.dart';
import 'package:flutter_firebase/auth/reset_password.dart';
import 'package:flutter_firebase/auth/signup.dart';
import 'package:flutter_firebase/bloc/auth/auth_bloc.dart';
import 'package:flutter_firebase/bloc/observers/global_observer.dart';
import 'package:flutter_firebase/data/auth/source/auth_firebase_service.dart';
import 'package:flutter_firebase/data/category/source/category_firestore_service.dart';
import 'package:flutter_firebase/pages/create_category.dart';
import 'package:flutter_firebase/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );

  Bloc.observer = GlobalObserver();

  final authenticationRepository = AuthFirebaseServiceImp();

  runApp(MainApp(authenticationRepository: authenticationRepository));
}

class MainApp extends StatelessWidget {
  final AuthFirebaseServiceImp _authenticationRepository;

  const MainApp({
    required AuthFirebaseServiceImp authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;


  @override
   Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthBloc>(
            create:(context) => AuthBloc(authRepository: _authenticationRepository),
          ),
          RepositoryProvider<AuthFirebaseServiceImp>(
            create:(context) => AuthFirebaseServiceImp(),
          ),
          RepositoryProvider<CategoryService>(
            create: (context) => CategoryService(),
          )
        ],
        child: const AppView(),
      ),
    );
  }
  
}
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
 Widget build(BuildContext context) {
    return   MaterialApp(
      home: const Login(),
      routes: {
        '/login': (context) => const Login(),
        '/signup': (context) =>  const SignUp(),
        '/home': (context) => const Home(),
        '/reset-password':(context) => const  ResetPassword(),
        '/create-category':(context) => const CreateCategory()
      },
    );
  }
}
