import 'package:coding_factory_train/common/const/data.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class DataUtil {
  static String stringToUrl(String value) {
    return "$serverUrl/$value";
  }

  static List<String> listToUrl(List paths) {
    return paths.map((e) => stringToUrl(e)).toList();
  }
}
