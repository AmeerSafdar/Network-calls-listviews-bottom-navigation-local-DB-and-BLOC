
// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, void_checks, unnecessary_cast, use_rethrow_when_possible

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task03/helper/const/common_keys.dart';
import 'package:task03/model/product_model.dart';

class FirebaseRepository{
  final _firestore=FirebaseFirestore.instance.collection(CommonKeys.PRODUCTS);

  Future<void> create({required String name}) async{

    try {
      await _firestore.add({CommonKeys.NAME:name});
      
    } on FirebaseException catch(e){
     throw e;
    }
     catch (e) {
      throw Exception(e.toString());
    }

  }

  Future<List<ProductModel>> getData() async{
    List<ProductModel> dataList=[];
    try {
      final products=await FirebaseFirestore.instance.collection(CommonKeys.PRODUCTS).get();

      products.docs.forEach((element) {
        return dataList.add(ProductModel.fromJson(element.data()));
      });
      return dataList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}