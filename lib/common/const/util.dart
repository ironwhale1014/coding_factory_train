import 'package:coding_factory_train/common/const/data.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class DataUtil{
  static stringToUrl(String value){
    return "$serverUrl/$value";
  }
}
