import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth_tut/data/model/user/user.dart';
import 'package:firebase_auth_tut/utils/ext/string_ext.dart';
import 'package:firebase_auth_tut/widgets/dialog/dialog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rxdart/rxdart.dart';
import '../../../widgets/button/progress_button.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final _fireStore = firestore.FirebaseFirestore.instance;
  final _auth = auth.FirebaseAuth.instance;
  final _emailSubject = BehaviorSubject<EmailLoginInput>();
  final _passwordSubject = BehaviorSubject<PasswordLoginInput>();
  final _compositeSubscription = CompositeSubscription();

  LoginCubit() : super(LoginInitial()) {
    Rx.combineLatest2(_emailSubject, _passwordSubject,
            (EmailLoginInput a,
            PasswordLoginInput b) => a.valid && b.valid)
        .map((valid) => valid ? ButtonState.enable : ButtonState.disable)
        .distinct()
        .listen((state) => emit(SubmitState(buttonState: state)))
        .addTo(_compositeSubscription);
  }

  validField({required LoginFieldType type, required String? input}) {
    switch (type) {
      case LoginFieldType.email:
        final state = EmailLoginInput(input);
        _emailSubject.add(state);
        emit(state);
        break;
      case LoginFieldType.password:
        final state = PasswordLoginInput(input);
        _passwordSubject.add(state);
        emit(state);
        break;
    }
  }

  logIn() async {
    emit(SubmitState(buttonState: ButtonState.loading));
    try {
      final email = _emailSubject.value.input!;
      final password = _passwordSubject.value.input!;
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final uid = userCredential.user!.uid;
      final user =  await _fireStore
          .collection(dotenv.env["collection_users"]!)
          .doc(uid)
          .get()
          .then((value) => User.fromJsonId(uid, value.data() ?? {}));
      emit(DialogLoginState(WelcomeState(user.name,user.imageUrl),id: uid));
    }catch(e){
      emit(DialogLoginState(OOopsSomethingWentWrong()));
    }
    emit(SubmitState(buttonState: ButtonState.enable));
  }

  displayWelcomeUserDialog(User user) {
    emit(DialogLoginState(WelcomeState(user.name, user.imageUrl), id: user.id));
  }

  @override
  Future<void> close() async {
    await _compositeSubscription.clear();
    return super.close();
  }
}
