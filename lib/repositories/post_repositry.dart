// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'package:dio/dio.dart';
import 'package:task03/helper/const/common_keys.dart';
import 'package:task03/model/post_model.dart';
import 'package:task03/repositories/api/api.dart';

class PostRepository {

  API api = API();

  Future<List<PostModel>> fetchPosts() async {
    try {
      Response response = await api.sendRequest.get(CommonKeys.PHOTOS_URL);
      List<dynamic> postMaps = response.data;
      return postMaps.map((postMap) => PostModel.fromJson(postMap)).toList();
    }
    catch(ex) {
      throw ex;
    }
  }

}