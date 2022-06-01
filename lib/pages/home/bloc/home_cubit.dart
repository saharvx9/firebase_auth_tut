import 'package:cloud_firestore/cloud_firestore.dart' as fire;
import 'package:firebase_auth_tut/data/model/user/user.dart';
import 'package:firebase_auth_tut/widgets/app_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final _fireStore = fire.FirebaseFirestore.instance;
  HomeCubit() : super(LoadingState());

  start(String uid) async {
    print("bloc $hashCode");
    try{
      final user = await _fireStore
          .collection(dotenv.env["collection_users"]!)
          .doc(uid)
          .get()
          .then((value) => User.fromJsonId(uid, value.data() ?? {}));
      emit(UserState(user));
    }catch(e,s){
      if (kDebugMode) print("error: $e\nstacktrace: $s");
      emit(ErrorState(DialogState("Error","failed load user try to refresh",DialogType.error)));
    }
  }

  logOut(){

  }
}
