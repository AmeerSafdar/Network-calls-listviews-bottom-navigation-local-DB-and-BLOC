// ignore_for_file: avoid_print

import 'package:hive/hive.dart';

class HiveRepositry{
  
addData(String data) async{
    try {
    final listBox=Hive.box('Box');
    await listBox.add(data);
    
    } catch (e) {
      print(e);
    }
}

getData(){
     
      final listBox=Hive.box('Box');
      final values = listBox.values;

    return values.toList();
}

}