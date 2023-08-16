import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/provider/paginate_provider.dart';
import 'package:flutter/cupertino.dart';

class UrlUtils {
  static String stringToUrl(String url) {
    return "$serverIp/$url";
  }
}

class PaginationUtils {
  static void paginate({
    required ScrollController controller,
    required PaginationProvider provider,
  }) {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      provider.paginate(fetchMore: true);
    }
  }
}
