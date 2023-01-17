// ignore_for_file: non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task03/blocs/states.dart';
import 'package:task03/blocs/firebase_bloc/products_firebase_events.dart';
import 'package:task03/repositories/firebaseRepository.dart';

class ProductBloc extends Bloc<ProductsEvent,ProductState>{
 final FirebaseRepository prod_repo; 

 ProductBloc({required this.prod_repo}) : super(InitialState()){
  on<Create>((event, emit) async {
    emit(ProductAdding());
    try {
      await prod_repo.create(name: event.name);
      emit(ProductAdded());
      
    } catch (e) {
      emit(ProductError(e.toString()));  
    }
  });

  on<GetData>((event, emit) async{
    emit(ProductLoading());
    try {
      final data=await prod_repo.getData();
      emit(ProductLoaded(data));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  });
 }
}