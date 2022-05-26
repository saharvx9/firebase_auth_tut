import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_auth_tut/data/model/gender.dart';
import 'package:firebase_auth_tut/widgets/progress_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {

  final _emailController = StreamController<EmailInputState>.broadcast();
  final _passwordController = StreamController<PasswordInputState>.broadcast();
  final _dateController = StreamController<DateInputState>.broadcast();
  final _genderController = StreamController<GenderState>.broadcast();
  final _compositeSubscription = CompositeSubscription();

  RegistrationCubit() : super(RegistrationInitial()) {

    Rx.combineLatest4(_emailController.stream, _passwordController.stream,
        _dateController.stream, _genderController.stream,
            (EmailInputState emailState,
            PasswordInputState passwordState,
            DateInputState dateState,
            GenderState genderState) => emailState.valid && passwordState.valid && dateState.valid && genderState.valid)
        .map((valid) => valid ? ButtonState.enable : ButtonState.disable)
        .listen((state) {
        emit(SubmitState(state: state));
    }).addTo(_compositeSubscription);
  }

  void validField({required RegistrationFieldType type, required dynamic input}) {
    switch (type) {
      case RegistrationFieldType.email:
        break;
      case RegistrationFieldType.password:
        break;
      case RegistrationFieldType.date:
        break;
      case RegistrationFieldType.gender:
        break;
    }
  }
}
