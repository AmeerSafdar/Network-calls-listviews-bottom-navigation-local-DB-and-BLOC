import 'package:task03/model/post_model.dart';

enum PostStatus { initial, success, failure, searchError }

class PostStates {
  const PostStates({
    this.status = PostStatus.initial,
    this.posts = const <PostModel>[],
  });
  final PostStatus status;
  final List<PostModel> posts;

    PostStates copyWith({
    PostStatus? status,
    List<PostModel>? posts,
  }) {
    return PostStates(
      status: status ?? this.status,
      posts: posts ?? this.posts,
    );
  }
}