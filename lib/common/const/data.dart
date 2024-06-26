import 'dart:io';

const String ACCESS_TOKEN ="ACCESS_TOKEN";
const String REFRESH_TOKEN ="REFRESH_TOKEN";

const String androidIp = "http://10.0.2.2:3000";
const String iOSIp = "http://127.0.0.1:3000";

final String serverUrl = Platform.isIOS ? iOSIp : androidIp;