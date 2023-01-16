// ignore_for_file: non_constant_identifier_names, avoid_print, avoid_function_literals_in_foreach_calls, prefer_is_empty, import_of_legacy_library_into_null_safe

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task03/blocs/post_state.dart';
import 'package:task03/model/post_model.dart';
import 'package:task03/repositories/post_repositry.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super( PostLoadingState() ) {
    fetchPosts();
  }

  PostRepository postRepository = PostRepository();

  void fetchPosts() async {
    try {
      List<PostModel> posts = await postRepository.fetchPosts();
      emit(PostLoadedState(posts));
    }
    on DioError catch(ex) {
        emit( PostErrorState("Can't fetch posts, please check your internet connection!") );
      
    }
  }

  void searchPost(String SearchText) async{
    emit(PostSearchingState());
    await Future.delayed(const Duration(seconds: 1));
    
    List<PostModel> posts = await postRepository.fetchPosts();
    List<PostModel> foundUser=[];
    await Future.delayed(const Duration(seconds: 1));

    posts.forEach((PostModel p)=> p.title!.toLowerCase().contains(SearchText.toLowerCase())? foundUser.add(p): print('not founded'));
 

    if (foundUser.length<0) {
      emit(PostSearchingState());
    } else {
      emit(PostSearchedState(foundUser));
    }
  }
}
