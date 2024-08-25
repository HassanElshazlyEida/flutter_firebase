import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested({required this.email, required this.password});
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String username;
  final String password;

  SignUpRequested({ required this.username, required this.email, required this.password});
}
class VerifyEmailRequested extends AuthEvent {
  final String email;
  VerifyEmailRequested({required this.email});
}
class SignOutRequested extends AuthEvent {}