
abstract class ProductsEvent{
  @override
  List<Object> get props => [];
}

class Create extends ProductsEvent{
  final String name;
  Create(this.name);
}

class GetData extends ProductsEvent{
  GetData();
}