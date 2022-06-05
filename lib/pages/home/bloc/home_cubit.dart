import 'package:cloud_firestore/cloud_firestore.dart' as fire;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth_tut/data/model/user/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../widgets/dialog/dialog_state.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final _fireStore = fire.FirebaseFirestore.instance;
  HomeCubit() : super(LoadingState());

  start(String uid) async {
    try{
      final user = await _fireStore
          .collection(dotenv.env["collection_users"]!)
          .doc(uid)
          .get()
          .then((value) => User.fromJsonId(uid, value.data() ?? {}));
      emit(UserState(user));
    }catch(e,s){
      if (kDebugMode) print("error: $e\nstacktrace: $s");
      emit(ErrorState(FailedLoadUserState()));
    }
  }

  displayLogoutDialog(){
    emit(LogOutAwareDialog(BeforeLogOutState()));
  }

  logOut() async {
    try {
      print("start logOut");
      await auth.FirebaseAuth.instance.signOut();
      emit(LogOutState());
    } catch(e) {
      print("show error: $e");
      emit(ErrorState(OOopsSomethingWentWrong()));
    }
  }
}
