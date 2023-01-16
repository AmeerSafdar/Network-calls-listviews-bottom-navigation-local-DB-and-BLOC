// ignore_for_file: override_on_non_overriding_member

abstract class HiveState {}

class InitialState extends HiveState{

}
class DataAdding extends HiveState{
  @override
  List<Object> get props => [];
}

class DataAdded extends HiveState{
  @override
  List<Object> get props => [];
}

class DataError extends HiveState{
  final String error;
  DataError(this.error);
  @override
  List<Object> get props => [error];
}
class DataLoaded extends HiveState{
  List myData;
  DataLoaded(this.myData);
  @override
  List<Object> get props => [myData];
}