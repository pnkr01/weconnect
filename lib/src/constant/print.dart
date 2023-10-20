import 'package:flutter/foundation.dart';

void connectdebugPrint(dynamic message) {
  if (kDebugMode) {
    print(message.toString());
  }
}
