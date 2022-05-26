import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {

  final _auth = FirebaseAuth.instance;

  SplashCubit() : super(SplashState.idle);

  void start(){
    if(_auth.currentUser?.uid != null) emit(SplashState.loggedIn);
    else emit(SplashState.noUserExist);
  }
}
