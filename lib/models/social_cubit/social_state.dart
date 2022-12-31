part of 'social_cubit.dart';

@immutable
abstract class SocialState {}

class SocialInitial extends SocialState {

}

class ProfileInfoInitialState extends SocialState {
  final UserModel? model;
  ProfileInfoInitialState(this.model);
}

class ProfileInfoLoadingState extends SocialState {}

class ProfileInfoSuccessState extends SocialState {
  UserModel? model;
  String? newProfileUrl;
  String? newCoverUrl;
  ProfileInfoSuccessState({this.model, this.newProfileUrl, this.newCoverUrl});
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