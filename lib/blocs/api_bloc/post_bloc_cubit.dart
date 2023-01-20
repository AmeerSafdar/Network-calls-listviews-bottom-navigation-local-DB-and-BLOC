// ignore_for_file: non_constant_identifier_names, avoid_print, avoid_function_literals_in_foreach_calls, prefer_is_empty, import_of_legacy_library_into_null_safe, unnecessary_string_interpolations, use_rethrow_when_possible

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task03/blocs/api_bloc/post_states.dart';
import 'package:task03/model/post_model.dart';
import 'package:task03/repositories/post_repositry.dart';

class PostCubit extends Cubit<PostStates> {
  PostCubit() : super(const PostStates() ) {
    fetchPosts();
  }

  PostRepository postRepository = PostRepository();
  List<PostModel>? posts;
  void fetchPosts() async {
    try {
      if (state.status == PostStatus.initial) {
        posts = await postRepository.fetchPosts();
      emit(
        state.copyWith(
        status: PostStatus.success,
        posts: posts
      ));
      } 
    }
     catch(ex) {
       emit(state.copyWith(status: PostStatus.failure));
      
    }
  }

  void searchPost(String SearchText) async{
    List<PostModel> foundUser=[];
    try{
    posts!.forEach((PostModel p)=> p.title!.toLowerCase().contains(SearchText.toLowerCase())? foundUser.add(p): emit(state.copyWith(status: PostStatus.searchError))
    );
    
    if (foundUser.length<=0) {
      emit(state.copyWith(status: PostStatus.searchError));
    } else {
      emit(
        state.copyWith(
        status: PostStatus.success,
        posts: foundUser
      ));
    }
  }
  catch(e){
    throw e;
  }
}}
