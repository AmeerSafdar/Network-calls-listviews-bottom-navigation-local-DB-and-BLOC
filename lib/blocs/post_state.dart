import 'package:task03/model/post_model.dart';

abstract class PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<PostModel> posts;
  PostLoadedState(this.posts);
}

class PostErrorState extends PostState {
  final String error;
  PostErrorState(this.error);
}

class PostSearchedState extends PostState {
  final List<PostModel> posts;
  PostSearchedState(this.posts);
}
class PostSearchingState extends PostState {
}
class PostSearchingErrorState extends PostState {
}