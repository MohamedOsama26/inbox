part of 'social_cubit.dart';

@immutable
abstract class SocialState {}

class SocialInitial extends SocialState {}

//Profile Information
class ProfileInfoLoadingState extends SocialState {}

class ProfileInfoSuccessState extends SocialState {
  UserModel? model;
  String? newProfileUrl;
  String? newCoverUrl;
  List<PostModel>? posts;
  ProfileInfoSuccessState({this.model, this.newProfileUrl, this.newCoverUrl, this.posts});
}

class ProfileInfoErrorState extends SocialState {
  final String error;
  ProfileInfoErrorState(this.error);
}

class ProfileInfoReloadingState extends SocialState {}

class ImageErrorState extends SocialState {}

//New Post Information
class CreatePostSuccessState extends SocialState {}

class CreatePostLoadingState extends SocialState {}

class CreatePostErrorsState extends SocialState {}

class PostImageLoadingState extends SocialState {}

class PostImageSuccessState extends SocialState {}

class PostImageErrorState extends SocialState {}

//Get Post
class GetPostsLoadingState extends SocialState {}

class GetPostsSuccessState extends SocialState {}

class GetPostsErrorState extends SocialState {
  final String error;
  GetPostsErrorState(this.error);
}

class LikePostSuccessState extends SocialState {}

class LikePostErrorState extends SocialState {
  final String error;
  LikePostErrorState(this.error);
}