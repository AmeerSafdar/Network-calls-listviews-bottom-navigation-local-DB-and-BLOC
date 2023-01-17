// ignore_for_file: override_on_non_overriding_member

import 'package:task03/model/post_model.dart';
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

class DataAdding extends ProductState{
  @override
  List<Object> get props => [];
}

class DataAdded extends ProductState{
  @override
  List<Object> get props => [];
}

class DataError extends ProductState{
  final String error;
  DataError(this.error);
  @override
  List<Object> get props => [error];
}
class DataLoaded extends ProductState{
  List myData;
  DataLoaded(this.myData);
  @override
  List<Object> get props => [myData];
}


class PostLoadingState extends ProductState {}

class PostLoadedState extends ProductState {
  final List<PostModel> posts;
  PostLoadedState(this.posts);
}

class PostErrorState extends ProductState {
  final String error;
  PostErrorState(this.error);
}

class PostSearchedState extends ProductState {
  final List<PostModel> posts;
  PostSearchedState(this.posts);
}
class PostSearchingState extends ProductState {
}
class PostSearchingErrorState extends ProductState {
}