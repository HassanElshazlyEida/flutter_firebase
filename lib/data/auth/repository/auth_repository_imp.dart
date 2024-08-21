import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/data/auth/models/user_model.dart';
import 'package:flutter_firebase/data/auth/source/auth_firebase_service.dart';


abstract class AuthRepository {
  Future<Either<UserModel,String>> register(UserModel user,String password);
  Stream<User?> get authStateChanges;
}
class AuthRepositoryImp implements AuthRepository {
  final AuthFirebaseService _authFirebaseService;
  AuthRepositoryImp(this._authFirebaseService);
  
  @override
  Future<Either<UserModel,String>> register(UserModel user,String password) async {
    return  _authFirebaseService.register(user,password);
  }
   @override
  Stream<User?> get authStateChanges => _authFirebaseService.authStateChanges;
}