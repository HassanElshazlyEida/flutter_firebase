import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/component/helpers/helper.dart';
import 'package:flutter_firebase/data/auth/models/user_model.dart';

abstract class AuthFirebaseService {
  Future<Either<bool,String>> register(UserModel user,String password);
  Future<Either<UserModel,String>> login(String email,String password);
  Future<Either<bool,String>> sendVerify(String email);
  Stream<User?> get authStateChanges;
}

class AuthFirebaseServiceImp implements AuthFirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Either<bool,String>> register(UserModel user,String password) async {
    try {
      // register with firebase
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      return left(true);
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
      
      if (_firebaseAuth.currentUser!.emailVerified) {
        return left(
          UserModel(
            id: authenticatedUser.user!.uid,
            email: email,
          )
        );
      }else {
        return right('Please verify your email address');
      }
      
    }  on FirebaseAuthException catch (e) {
      return right(e.message.toString());
    }
    catch (e) {
      print('catch error');
      return right(e.toString());
    }
  }
   @override
  Future<Either<bool,String>> sendVerify(String email) async {
    try {
      // login with firebase
      return await _firebaseAuth.currentUser!.sendEmailVerification()
      .catchError((onError) =>  right('Error sending email verification $onError'))
      .then((value) => left(true));
      
    }  on FirebaseAuthException catch (e) {
      return right(e.message.toString());
    }
    catch (e) {
      print(e.toString());
      return right('Error sending email verification ${e.toString()}');
    }
  }
  
  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}