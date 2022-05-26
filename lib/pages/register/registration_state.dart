part of 'registration_cubit.dart';

enum RegistrationFieldType {
  email,
  password,
  date,
  gender
}

abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}
class InputValidationState<T> extends RegistrationState {
  final T? input;
  var valid = false;
  String? error;
  InputValidationState(this.input);
}

class EmailInputState<String> extends InputValidationState {
  EmailInputState(super.input);
}

class PasswordInputState<String> extends InputValidationState {
  PasswordInputState(super.input);
}

class DateInputState<String> extends InputValidationState {
  DateInputState(super.input);
}

class GenderState<Gender> extends InputValidationState {
  GenderState(super.input);

}

class ImageState extends RegistrationState {
  final Uint8List image;
  ImageState(this.image);
}

class SubmitState extends RegistrationState {
  final ButtonState state;
  SubmitState({this.state = ButtonState.disable});
}

