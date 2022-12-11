part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  String id;
  RegisterSuccessState(this.id);
}

class RegisterErrorState extends RegisterState {
  final String error;
  RegisterErrorState(this.error);
}
