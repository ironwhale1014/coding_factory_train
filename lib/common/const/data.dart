import 'dart:io';
import 'package:logger/logger.dart';

const String ACCESS_TOKEN = "ACCESS_TOKEN";
const String REFRESH_TOKEN = "REFRESH_TOKEN";

const simulIp = "http://127.0.0.1:3000";
const emulIp  = "http://10.0.2.2:3000";

final ip = Platform.isIOS ? simulIp : emulIp;

final logger = Logger();
