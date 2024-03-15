library services;

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:xiaoerban_business/models/index.dart';
import 'package:xiaoerban_business/store/index.dart';
import 'package:xiaoerban_business/utils/index.dart';
import 'package:xiaoerban_business/widgets/index.dart';

export 'package:dio/dio.dart';

part 'storage.dart';
part 'http.dart';
