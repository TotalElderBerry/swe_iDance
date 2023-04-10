
import 'package:get_storage/get_storage.dart';

class LocalStorageSource{
  static GetStorage storage = GetStorage();
  LocalStorageSource();

  static void writeToStorage(String key,dynamic data){
    storage.write(key,data);
  }

  static String readFromStorage(String key){
    return storage.read(key);
  }

}