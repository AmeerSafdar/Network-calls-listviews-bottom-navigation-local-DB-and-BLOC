
abstract class ProductsEvent{}

class Create extends ProductsEvent{
  final String name;
  Create(this.name);
}

class GetData extends ProductsEvent{
  GetData();
}