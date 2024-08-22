import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/data/auth/models/user_model.dart';

abstract class AuthFirebaseService {
  Future<Either<UserModel,String>> register(UserModel user,String password);
  Future<Either<UserModel,String>> login(String email,String password);
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
      ).then((auth){
        auth.user!.updateDisplayName(user.username);
        return auth;
      });
      return left(
        user.copyWith(
        id: authenticatedUser.user!.uid,
        email: user.email,
        username: user.username,
        )
      );
    }
    on FirebaseAuthException catch (e) {
      return right(e.message.toString());
    }
     catch (e) {
      return right(e.toString());
    }
  }
  @override
  Future<Either<UserModel,String>> login(String email,String password) async {
    try {
      // login with firebase
      UserCredential authenticatedUser = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return left(
          UserModel(
          id: authenticatedUser.user!.uid,
          email: email,
        )
      );
    }  on FirebaseAuthException catch (e) {
      return right(e.message.toString());
    }
    catch (e) {
      print('catch error');
      return right(e.toString());
    }
  }

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}