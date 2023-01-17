part of 'posts_cubit.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

//Get Post
class GetPostsLoadingState extends PostsState {}

class GetPostsSuccessState extends PostsState {}

class GetPostsErrorState extends PostsState {
  final String error;
  GetPostsErrorState(this.error);
}