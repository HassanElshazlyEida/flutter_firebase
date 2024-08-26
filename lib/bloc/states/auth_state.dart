import 'package:equatable/equatable.dart';
import 'package:flutter_firebase/data/auth/models/user_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthUnAuthenticated extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserModel user;

  AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}
class AuthSentVerify extends  AuthState {}
class AuthSentResetPassword extends  AuthState {
  final String message;

  AuthSentResetPassword(this.message);

  @override
  List<Object> get props => [message];
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object> get props => [message];
}