import 'package:get_storage/get_storage.dart';

class LocalStorage{
  static bool checkFirstTime(){
    if(GetStorage().hasData('firstTime')){
      return false;
    }else{
      GetStorage().write('firstTime', 'firstTime');
      return true;
    }
  }
}