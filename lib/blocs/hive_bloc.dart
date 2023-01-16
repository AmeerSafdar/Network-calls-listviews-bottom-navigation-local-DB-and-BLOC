// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task03/blocs/hive_events.dart';
import 'package:task03/blocs/hive_states.dart';
import 'package:task03/repositories/hive_repository.dart';

class HiveBloc extends Bloc<HiveEvent,HiveState>{
 HiveRepositry hiveRepositry;
HiveBloc({required this.hiveRepositry}):super(InitialState()){
  on<AddData>((event, emit) async{
    
   emit(DataAdding());
   await Future.delayed(const Duration(seconds: 1));
   try {
     await hiveRepositry.addData(event.name);
     emit(DataAdded());
   } catch (e) {
     print(e.toString());
   }
  });


  on<RetreiveData>((event, emit) async{
    emit(DataAdding());
    await Future.delayed(const Duration(seconds: 1));
     try {
      final data=await hiveRepositry.getData();
      emit(DataLoaded(data));
    } catch (e) {
      emit(DataError(e.toString()));
    }
  });
}
}