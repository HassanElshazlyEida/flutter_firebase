import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase/component/helpers/helper.dart';
import 'package:flutter_firebase/data/auth/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthFirebaseService {
  Future<Either<bool,String>> register(UserModel user,String password);
  Future<Either<UserModel,String>> login(String email,String password);
  Future<Either<bool,String>> sendVerify(String email);
  Stream<User?> get authStateChanges;
  User? get user;
  UserModel? get userModel;
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
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  @override
  User? get user => _firebaseAuth.currentUser;
  @override 
  UserModel? get userModel {
    User? currentUser = _firebaseAuth.currentUser;
    if(currentUser != null){
      return UserModel.copyWith(email: currentUser.email as String ,id: _firebaseAuth.currentUser!.uid);
    }else {
      return null;
    }
  }

  
}