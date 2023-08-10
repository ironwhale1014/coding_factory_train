import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/provider/pagination_provider.dart';
import 'package:flutter/cupertino.dart';
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

class PaginationUtils {
  static void paginate(
      {required ScrollController controller,
      required PaginationProvider provider}) {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      provider.paginate(fetchMore: true);
    }
  }
}
