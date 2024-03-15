library utils;

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xiaoerban_business/models/index.dart';
import 'package:xiaoerban_business/theme.dart';
import 'package:xiaoerban_business/widgets/index.dart';
import 'package:xiaoerban_business/theme.dart';

import 'package:xiaoerban_business/theme.dart';
import 'style/index.dart';

import 'package:flutter_picker/Picker.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flutter_picker/Picker.dart';

import 'extension/index.dart';
// import 'package:xiaoerban_business/theme.dart';
// import 'package:xiaoerban_business/widgets/index.dart';

// import 'package:flutter_woo_commerce_getx_learn/common/index.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';
// import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';

part 'screen.dart';
part 'tools.dart';
part 'console.dart';
part 'constants.dart';
part 'input_formatters.dart';
part 'access.dart';
part 'assets_picker.dart';
part 'picker.dart';
part 'bottom_sheet2.dart';
part 'pick.dart';
part 'file_picker.dart';
