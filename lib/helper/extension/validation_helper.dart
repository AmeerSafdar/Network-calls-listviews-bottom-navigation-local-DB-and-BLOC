
// ignore_for_file: unnecessary_this

extension Validate on String{

 
 bool isRequired(){
    return this.isNotEmpty ;
  }
   bool lengthRange(){
    return this.length>5 && this.length<12  ;
  }

}