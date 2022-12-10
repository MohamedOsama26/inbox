part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterMoreInformationState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String error;
  RegisterErrorState(this.error);
}

class CreatingUserLoadingState extends RegisterState {}

class CreatingUserSuccessState extends RegisterState {}

class CreatingUserErrorState extends RegisterState {
  final String error;

  CreatingUserErrorState(this.error);
}


