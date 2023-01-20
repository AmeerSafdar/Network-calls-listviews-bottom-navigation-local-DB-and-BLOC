// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'package:hive/hive.dart';
import 'package:task03/helper/const/common_keys.dart';

class HiveRepositry{
  
addData(String data) async{
    try {
    final listBox=Hive.box(CommonKeys.BOX);
    await listBox.add(data);
    
    } catch (e) {
     throw e;
    }
}

getData(){
     
      final listBox=Hive.box(CommonKeys.BOX);
      final values = listBox.values;

    return values.toList();
}

}