// ignore_for_file: prefer_final_fields, unused_import

import 'package:dio/dio.dart';

class API{
  Dio _dio=Dio();

  API(){
  _dio.options.baseUrl='https://jsonplaceholder.typicode.com';
  // _dio.interceptors.add(PrettyDioLogger());
  }

  Dio get sendRequest => _dio;

}