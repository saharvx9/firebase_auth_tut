import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:firebase_auth_tut/data/model/gender.dart';
import 'package:firebase_auth_tut/data/model/user/user.dart';
import 'package:firebase_auth_tut/utils/ext/string_ext.dart';
import 'package:firebase_auth_tut/widgets/button/progress_button.dart';
import 'package:firebase_auth_tut/widgets/dialog/dialog_state.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rxdart/rxdart.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final _auth = fire.FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance.ref();
  final _firestore = FirebaseFirestore.instance;
  final _emailState = StreamController<EmailInputState>.broadcast();
  final _userNameState = StreamController<UserNameInputState>.broadcast();
  final _passwordState = BehaviorSubject<PasswordInputState>();
  final _confirmPasswordState = BehaviorSubject<ConfirmPasswordInputState>();
  final _dateState = StreamController<DateInputState>.broadcast();
  final _genderState = StreamController<GenderState>.broadcast();
  final _compositeSubscription = CompositeSubscription();
  Uint8List? _userProfileImage;
  User? _user;

  RegistrationCubit() : super(RegistrationInitial()) {
    // Combine all streams together for build user model
    // and determine if each field that required is valid
    // as result all of them button state will be emitted
    Rx.combineLatest6(
            _emailState.stream,
            _userNameState.stream,
            _passwordState,
            _confirmPasswordState,
            _dateState.stream,
            _genderState.stream, (EmailInputState emailState,
                UserNameInputState userNameState,
                PasswordInputState passwordState,
                ConfirmPasswordInputState confirmPasswordState,
                DateInputState dateState,
                GenderState genderState) {
      _user = User("", userNameState.input, emailState.input, dateState.input,
          genderState.input, null);

      return emailState.valid &&
          passwordState.valid &&
          confirmPasswordState.valid &&
          dateState.valid &&
          genderState.valid;
    })
        .map((valid) => valid ? ButtonState.enable : ButtonState.disable)
        .distinct()
        .listen((state) {
      emit(SubmitState(buttonState: state));
    }).addTo(_compositeSubscription);
  }

  void validField({required RegistrationFieldType type, required dynamic input}) {
    switch (type) {
      case RegistrationFieldType.email:
        final state = EmailInputState(input);
        _emailState.add(state);
        emit(state);
        break;
      case RegistrationFieldType.userName:
        final state = UserNameInputState(input);
        _userNameState.add(state);
        emit(state);
        break;
      case RegistrationFieldType.password:
        final state = PasswordInputState(input);
        _passwordState.add(state);
        emit(state);
        if (!state.valid || !_confirmPasswordState.hasValue) return;
        validField(type: RegistrationFieldType.confirmPassword, input: _confirmPasswordState.value.input);
        break;
      case RegistrationFieldType.confirmPassword:
        final state = ConfirmPasswordInputState(input, _passwordState.value.input);_confirmPasswordState.add(state);
        emit(state);
        break;
      case RegistrationFieldType.date:
        final state = DateInputState(input);
        _dateState.add(state);
        emit(state);
        break;
      case RegistrationFieldType.gender:
        final state = GenderState(input);
        _genderState.add(state);
        emit(state);
        break;
    }
  }

  void pickImage(Uint8List image){
    _userProfileImage = image;
    emit(ImageState(image));
  }

  void signIn() async {
    emit(SubmitState(buttonState: ButtonState.loading));
    try {
      final email = _user!.email!;
      final password = _passwordState.value.input!;
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final id = userCredential.user!.uid;
      if(_userProfileImage != null) _user?.imageUrl = await _uploadImage(_userProfileImage!,id);
      await _firestore.collection(dotenv.env["collection_users"]!).doc(id).set(_user!.toJson());
      final dialogState = WelcomeState(_user?.name, _user?.imageUrl);
      emit(DialogRegisterState(dialogState,id: id));
    } catch (e) {
      if(kDebugMode) print("register failed: $e");
      emit(DialogRegisterState(OOopsSomethingWentWrong()));
    } finally {
      emit(SubmitState(buttonState: ButtonState.enable));
    }
  }

  Future<String> _uploadImage(Uint8List bytes,String? id){
    return _storage.child("${dotenv.env["collection_users"]!}$id").putData(bytes)
    .then((task) => task.ref.getDownloadURL());
  }

  @override
  Future<void> close() {
    _compositeSubscription.clear();
    return super.close();
  }

  displayWelcomeUserDialog(User user) {
    emit(DialogRegisterState(WelcomeState(user.name, user.imageUrl),id: user.id));
  }
}
