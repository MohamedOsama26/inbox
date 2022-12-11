part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String id;

  LoginSuccessState(this.id);
}

class LoginErrorState extends LoginState {
  String error;
  LoginErrorState(this.error);
}
