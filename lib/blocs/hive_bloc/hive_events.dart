
abstract class HiveEvent{}

class AddData extends HiveEvent{
  final String name;
  AddData(this.name);
}

class RetreiveData extends HiveEvent{
  RetreiveData();
}