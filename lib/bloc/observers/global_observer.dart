import 'package:bloc/bloc.dart';

class GlobalObserver extends BlocObserver {


  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  

 
}