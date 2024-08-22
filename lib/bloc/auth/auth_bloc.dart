import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/bloc/events/auth_event.dart';
import 'package:flutter_firebase/bloc/states/auth_state.dart';
import 'package:flutter_firebase/data/auth/models/user_model.dart';
import 'package:flutter_firebase/data/auth/source/auth_firebase_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthFirebaseServiceImp _authRepository;

  AuthBloc({required AuthFirebaseServiceImp authRepository})  : 
  _authRepository = authRepository,
   super(AuthInitial()) {
    
    // Register
    on<SignUpRequested>((event, emit) async {
      print(event);
      emit(AuthLoading());
      try {
        var userModel = UserModel(email: event.email, username: event.username);
        var authenticatedUser = await _authRepository.register(userModel, event.password);
        if(authenticatedUser.isRight()) {
          emit(AuthError(authenticatedUser.fold((l) => '', (r) => r)));
          print(authenticatedUser.fold((l) => '', (r) => r));
          return;
        }else {        
          authenticatedUser.leftMap((user) => emit(AuthAuthenticated(user)));
         
        }
        //   authenticatedUser.fold(
        //   (user) => emit(AuthAuthenticated(user)),
        //   (error) => emit(AuthError(error)),
        // );

      } catch (e) {
        print(e.toString());
        emit(AuthError(e.toString()));
      }
    });

  }
}