// ignore_for_file: non_constant_identifier_names, avoid_print, avoid_function_literals_in_foreach_calls, prefer_is_empty, import_of_legacy_library_into_null_safe

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task03/blocs/states.dart';
import 'package:task03/model/post_model.dart';
import 'package:task03/repositories/post_repositry.dart';

class PostCubit extends Cubit<ProductState> {
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
        emit( PostErrorState("Can't fetch posts, please check your internet connection! $ex") );
      
    }
  }

  void searchPost(String SearchText,List<PostModel> post) async{
    emit(PostSearchingState());
    
    List<PostModel> posts =post;
    List<PostModel> foundUser=[];

    posts.forEach((PostModel p)=> p.title!.toLowerCase().contains(SearchText.toLowerCase())? foundUser.add(p): print('not founded'));
    if (foundUser.length<0) {
      emit(PostSearchingState());
    } else {
      emit(PostSearchedState(foundUser));
    }
  }
}
