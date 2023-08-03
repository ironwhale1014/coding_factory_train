import 'package:coding_factory_train/common/const/data.dart';

class DataUtils {
  static String pathToURL(String value) {
    return '$ip$value';
  }
  
  static List<String> pathToULRs(List paths){
    return paths.map((e) => pathToURL(e)).toList();
  }
}
