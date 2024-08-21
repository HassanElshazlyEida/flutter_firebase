import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/data/auth/models/user_model.dart';

abstract class AuthFirebaseService {
  Future<Either<UserModel,String>> register(UserModel user,String password);
  Stream<User?> get authStateChanges;
}

class AuthFirebaseServiceImp implements AuthFirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Either<UserModel,String>> register(UserModel user,String password) async {
    try {
      // register with firebase
      UserCredential authenticatedUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      return left(
        user.copyWith(
        id: authenticatedUser.user!.uid,
        email: user.email,
        username: user.username,
      )
      );
    } catch (e) {
      return right(e.toString());
    }
  }
  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}