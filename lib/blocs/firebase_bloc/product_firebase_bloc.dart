// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task03/blocs/firebase_bloc/firebase_state.dart';
import 'package:task03/blocs/firebase_bloc/products_firebase_events.dart';
import 'package:task03/repositories/firebaseRepository.dart';

class ProductBloc extends Bloc<ProductsEvent,ProductStates>{
 final FirebaseRepository prod_repo; 

 ProductBloc({required this.prod_repo}) : super(const ProductStates()){
  on<Create>(add_data);

  on<GetData>(get_data);
 }

 FutureOr<void> add_data(event, emit) async {
  emit(
    state.copyWith(
    status: ProductStatus.productAdding
    )
    );
   try {
     await prod_repo.create(name: event.name);
    emit(state.copyWith(
    status: ProductStatus.success
    ));
   } catch (e) {
    emit(state.copyWith(
    status: ProductStatus.failure
    ));
   }
 }

 FutureOr<void> get_data(event, emit) async{
  emit(state.copyWith(
    status: ProductStatus.productAdding
    ));
   try {
     final data=await prod_repo.getData();
    emit(state.copyWith(
    status: ProductStatus.success,
    posts: data
    ));
   } catch (e) {
    emit(state.copyWith(
    status: ProductStatus.failure
    ));
   }
 }
}