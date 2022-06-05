part of 'login_cubit.dart';

enum LoginFieldType {
  email,password
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class InputValidationState extends LoginInitial {
  final String? input;
  String? _error;
  String? get error => _error;
  bool get valid => _error == null;
  InputValidationState(this.input);
}

class EmailLoginInput extends InputValidationState{
  EmailLoginInput(super.input){
    _error = input.isNullOrEmpty ? "Email cannot be empty" : null;
  }
}

class PasswordLoginInput extends InputValidationState{
  PasswordLoginInput(super.input){
    _error = input.isNullOrEmpty ? "Email cannot be empty" : null;
  }
}

class SubmitState extends LoginState {
  final ButtonState buttonState;
  SubmitState({this.buttonState = ButtonState.disable});
}


class DialogLoginState extends LoginState {
  final DialogState state;
  final String? id;
  DialogLoginState(this.state, {this.id});
}
