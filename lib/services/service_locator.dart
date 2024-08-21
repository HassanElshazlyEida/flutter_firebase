import 'package:flutter_firebase/data/auth/repository/auth_repository_imp.dart';
import 'package:flutter_firebase/data/auth/source/auth_firebase_service.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {

  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImp());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImp(sl<AuthFirebaseService>()));



}