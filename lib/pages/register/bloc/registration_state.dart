
part of 'registration_cubit.dart';

enum RegistrationFieldType {
  email,
  userName,
  password,
  confirmPassword,
  date,
  gender
}

abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}
class InputValidationState<T> extends RegistrationState {
  final T? input;
  String? _error;
  String? get error => _error;
  bool get valid => _error == null;
  InputValidationState(this.input);
}

class EmailInputState extends InputValidationState<String> {
  EmailInputState(super.input){
    if(input.isNullOrEmpty) _error = "email cannot be empty";
    else if(!input.isValidEmail()) _error = "email pattern is invalid";
    else _error = null;
  }
}

class UserNameInputState extends InputValidationState<String> {
  UserNameInputState(super.input){
    if(input.isNullOrEmpty) _error = "user name cannot be empty";
    else _error = null;
  }
}

class PasswordInputState extends InputValidationState<String> {
  PasswordInputState(super.input){
    if(input.isNullOrEmpty) _error = "password cannot be empty";
    else if(input!.length < 6) _error = "password must be more than 6 chars";
    else _error = null;
  }
}

class ConfirmPasswordInputState extends InputValidationState<String> {
  final String? password;
  ConfirmPasswordInputState(super.input, this.password){
    if(input.isNullOrEmpty) _error = "password cannot be empty";
    else if(input!.length < 4) _error = "password must be more than 4 chars";
    else if(password != input) _error = "passwords are not matched";
    else _error = null;
  }
}

class DateInputState extends InputValidationState<DateTime> {
  DateInputState(super.input){
    if(input == null) _error = "Date cannot be empty";
    else _error = null;
  }
}

class GenderState extends InputValidationState<Gender>{
  GenderState(super.input){
    if(input == null) _error = "Gender cannot be empty";
    else _error = null;
  }
}

class ImageState extends RegistrationState {
  final Uint8List image;
  ImageState(this.image);
}

class SubmitState extends RegistrationState {
  final ButtonState buttonState;
  SubmitState({this.buttonState = ButtonState.disable});
}

class DialogRegisterState extends RegistrationState {
  final DialogState state;
  DialogRegisterState(this.state);
}
