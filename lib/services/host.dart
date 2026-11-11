import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

bool get onAndroid => !kIsWeb && Platform.isAndroid;

bool get onIOS => !kIsWeb && Platform.isIOS;

bool get onMobile => onAndroid || onIOS;
