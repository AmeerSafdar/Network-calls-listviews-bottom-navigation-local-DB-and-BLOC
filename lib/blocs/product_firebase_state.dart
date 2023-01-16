// ignore_for_file: override_on_non_overriding_member

import 'package:task03/model/product_model.dart';

abstract class ProductState {}
class ProductAdding extends ProductState{
  @override
  List<Object> get props => [];
}

class ProductAdded extends ProductState{
  @override
  List<Object> get props => [];
}

class ProductError extends ProductState{
  final String error;
  ProductError(this.error);
  @override
  List<Object> get props => [error];
}

class InitialState extends ProductState{
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState{
  @override
  List<Object> get props => [];
}
class ProductLoaded extends ProductState{
  List<ProductModel> myData;
  ProductLoaded(this.myData);
  @override
  List<Object> get props => [myData];
}