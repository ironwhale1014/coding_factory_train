import 'dart:convert';

import 'package:coding_factory_train/common/const/data.dart';

class DataUtils {
  static String pathToURL(String value) {
    return '$ip$value';
  }

  static List<String> pathToULRs(List paths) {
    return paths.map((e) => pathToURL(e)).toList();
  }

  static String encodeBase64(String plain) {
    Codec<String, String> codec = utf8.fuse(base64);

    String encoded = codec.encode(plain);

    return encoded;
  }
}
