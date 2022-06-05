part of 'social_auth_cubit.dart';

enum SocialType {
  google(Icons.g_mobiledata_outlined,"Google"),
  facebook(Icons.facebook,"Facebook");

  final IconData icon;
  final String text;

  const SocialType(this.icon,this.text);
}

@immutable
abstract class SocialAuthState {}

abstract class ButtonAuthState extends SocialAuthState {
  final ButtonState state;
  ButtonAuthState(this.state);
}

class SocialAuthInitial extends SocialAuthState {}

class GoogleAuthState extends ButtonAuthState {
  GoogleAuthState(super.state);
}

class FacebookAuthState extends ButtonAuthState {
  FacebookAuthState(super.state);
}

class UserState extends SocialAuthState {
  final appUser.User user;
  UserState(this.user);
}

class ErrorSocialAuthState extends SocialAuthState{
  final dynamic error;
  final StackTrace? stackTrace;

  DialogState get dialogState => SocialErrorState(error);

  ErrorSocialAuthState({this.error, this.stackTrace});
}

