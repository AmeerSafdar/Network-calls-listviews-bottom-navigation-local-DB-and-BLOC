import 'package:equatable/equatable.dart';

abstract class HiveEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class AddData extends HiveEvent{
  final String name;
  AddData(this.name);
}

class RetreiveData extends HiveEvent{
  RetreiveData();
}