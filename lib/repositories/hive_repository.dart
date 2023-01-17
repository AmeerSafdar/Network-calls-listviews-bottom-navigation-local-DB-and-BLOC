// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'package:hive/hive.dart';

class HiveRepositry{
  
addData(String data) async{
    try {
    final listBox=Hive.box('Box');
    await listBox.add(data);
    
    } catch (e) {
     throw e;
    }
}

getData(){
     
      final listBox=Hive.box('Box');
      final values = listBox.values;

    return values.toList();
}

}