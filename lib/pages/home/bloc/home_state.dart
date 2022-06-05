part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoadingState extends HomeState {}

class UserState extends HomeState {
  final User user;
  UserState(this.user);
}

class ErrorState extends HomeState {
  final DialogState dialogState;
  ErrorState(this.dialogState);
}

class LogOutAwareDialog extends HomeState {
  final DialogState dialogState;
  LogOutAwareDialog(this.dialogState);
}

class LogOutState extends HomeState {}
