import 'package:task03/model/product_model.dart';

enum ProductStatus { initial, success, failure, productAdding }

class ProductStates {
  const ProductStates({
    this.status = ProductStatus.initial,
    this.posts = const <ProductModel>[],
  });
  final ProductStatus status;
  final List<ProductModel> posts;

    ProductStates copyWith({
    ProductStatus? status,
    List<ProductModel>? posts,
  }) {
    return ProductStates(
      status: status ?? this.status,
      posts: posts ?? this.posts,
    );
  }
}