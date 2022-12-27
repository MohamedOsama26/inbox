part of 'social_cubit.dart';

@immutable
abstract class SocialState {}

class SocialInitial extends SocialState {}

class ProfileInfoLoadingState extends SocialState {}

class ProfileInfoSuccessState extends SocialState {
  UserModel? model;
  ProfileInfoSuccessState(this.model);
}

class ProfileInfoErrorState extends SocialState {
  final String error;
  ProfileInfoErrorState(this.error);
}

class ProfileInfoReloadingState extends SocialState {}

class ProfileImageSuccessState extends SocialState {}

class ProfileImageErrorState extends SocialState {}

class CoverImageSuccessState extends SocialState {}

class CoverImageErrorState extends SocialState {}