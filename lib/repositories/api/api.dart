// ignore_for_file: prefer_final_fields, unused_import

import 'package:dio/dio.dart';
import 'package:task03/helper/const/string_resource.dart';

class API{
  Dio _dio=Dio();

  API(){
  _dio.options.baseUrl=StringResources.API_URL;
  }

  Dio get sendRequest => _dio;

}