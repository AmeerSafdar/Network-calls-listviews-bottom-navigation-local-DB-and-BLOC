
// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, void_checks, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task03/model/product_model.dart';

class FirebaseRepository{
  final _firestore=FirebaseFirestore.instance.collection('products');

  Future<void> create({required String name}) async{

    try {
      await _firestore.add({"name":name});
      
    } on FirebaseException catch(e){
      print("failed with error ${e.code}:  ${e.message}");
    }
     catch (e) {
      throw Exception(e.toString());
    }

  }

  Future<List<ProductModel>> getData() async{
    List<ProductModel> dataList=[];
    try {
      final products=await FirebaseFirestore.instance.collection('products').get();

      products.docs.forEach((element) {
        return dataList.add(ProductModel.fromJson(element.data()));
      });
      return dataList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}