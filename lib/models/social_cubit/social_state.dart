part of 'social_cubit.dart';

@immutable
abstract class SocialState {}

class SocialInitial extends SocialState {}

class ProfileInfoLoadingState extends SocialState {}

class ProfileInfoSuccessState extends SocialState {}

class ProfileInfoErrorState extends SocialState {
  final String error;
  ProfileInfoErrorState(this.error);
}
