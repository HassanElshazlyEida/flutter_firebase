import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/bloc/events/auth_event.dart';
import 'package:flutter_firebase/bloc/states/auth_state.dart';
import 'package:flutter_firebase/data/auth/models/user_model.dart';
import 'package:flutter_firebase/data/auth/repository/auth_repository_imp.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        var userModel = UserModel(email: event.email, username: event.username);
        var authenticatedUser = await _authRepository.register(userModel, event.password);
        if(authenticatedUser.isRight()) {
          emit(AuthError(authenticatedUser.fold((l) => '', (r) => r)));
          print(authenticatedUser.fold((l) => '', (r) => r));
          return;
        }else {
          emit(AuthAuthenticated(authenticatedUser as UserModel));
          print('Authenticated');
        }

      } catch (e) {
        print(e.toString());
        emit(AuthError(e.toString()));
      }
    });

  }
}