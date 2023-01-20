
enum HiveStatus { initial, success, failure,search,addingData }

class HiveStates {
  const HiveStates({
    this.status = HiveStatus.initial,
    this.posts = const [],
  });
  final HiveStatus status;
  final List posts;

    HiveStates copyWith({
    HiveStatus? status,
    List? posts,
  }) {
    return HiveStates(
      status: status ?? this.status,
      posts: posts ?? this.posts,
    );
  }
}