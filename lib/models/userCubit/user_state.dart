part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState{}

class NewUser extends UserState{}

class OldUser extends UserState{}
