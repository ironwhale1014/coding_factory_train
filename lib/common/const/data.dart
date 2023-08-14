// 주색상
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:io';

const PRIMARY_COLOR = Color(0xFF22A45D);
// 글자 색상
const BODY_TEXT_COLOR = Color(0xFF868686);
// 텍스트필드 배경 색상
const INPUT_BG_COLOR = Color(0xFFFBFBFB);
// 텍스트필드 테두리 색상
const INPUT_BORDER_COLOR = Color(0xFFF3F2F2);

final logger = Logger();

const String adroidIp = "http://10.0.2.2:3000";
const String iOSIP = "http://127.0.0.1:3000";
String serverIp = Platform.isIOS ? iOSIP : adroidIp;


const String ACCESS_TOKEN ="accessToken";
const String REFRESH_TOKEN ="refreshToken";
