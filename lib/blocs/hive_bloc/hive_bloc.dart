// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task03/blocs/hive_bloc/hive_events.dart';
import 'package:task03/blocs/hive_bloc/hive_states.dart';
import 'package:task03/repositories/hive_repository.dart';

class HiveBloc extends Bloc<HiveEvent,HiveStates>{
 HiveRepositry hiveRepositry;
 HiveBloc({required this.hiveRepositry}):super(const HiveStates()){
  on<AddData>(add_data);

  on<RetreiveData>(fetch_data);
  
}

FutureOr<void> fetch_data(event, emit) async{
  emit(
    state.copyWith(
    status: HiveStatus.initial
    )
    );
   try {
    final data=await hiveRepositry.getData();
    emit(
    state.copyWith(
    status: HiveStatus.success,
    posts: data
    ));
  } catch (e) {
   emit(
    state.copyWith(
    status: HiveStatus.failure,
    ));  }
}

FutureOr<void> add_data(event, emit) async{
  emit(
    state.copyWith(
    status: HiveStatus.addingData
    )
    );
 try {
   await hiveRepositry.addData(event.name);
   emit(
    state.copyWith(
    status: HiveStatus.success
    )
    );
 } catch (e) {
   throw e.toString();
 }
}
}