/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:logging/logging.dart';

import 'config_environment.dart';

class ConfigLog {
  ConfigLog() {
    Logger.root.level = ConfigEnvironment.isDevelop || ConfigEnvironment.isLocal
        ? Level.ALL
        : Level.INFO;
    Logger.root.onRecord.listen(onRecord);
  }

  void onRecord(LogRecord record) {
      print(
          '${_formatTime(record.time)}: ${record.level.name} [${record.loggerName}] ${record.message}');
  }

  String _formatTime(DateTime timestamp) {
    return timestamp.day.toString().padLeft(2, '0') +
        '/' +
        timestamp.month.toString().padLeft(2, '0') +
        '/' +
        timestamp.year.toString().replaceRange(0, 2, '') +
        " " +
        timestamp.hour.toString().padLeft(2, '0') +
        ":" +
        timestamp.minute.toString().padLeft(2, '0') +
        ":" +
        timestamp.second.toString().padLeft(2, '0') +
        "." +
        timestamp.millisecond.toString().padRight(3, '0');
  }
}
