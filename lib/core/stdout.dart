import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';

void dPrint(String? statement, {int? wrapWidth}) =>
    debugPrint(statement, wrapWidth: wrapWidth);

void dlog(
  String message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  String name = '',
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) {
  if (kDebugMode) {
    log(
      message,
      time: time,
      sequenceNumber: sequenceNumber,
      level: level,
      name: name,
      zone: zone,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
