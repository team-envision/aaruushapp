import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
class Log {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 3,
      lineLength: 160,
      excludePaths: [''],
    ),
  );

  static void verbose(dynamic message,
      [dynamic error, StackTrace? stackTrace]) {
    _logger.t(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void info(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void warning(dynamic message,
      [dynamic error, StackTrace? stackTrace]) {
    _logger.w(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void highlight(dynamic message,
      [dynamic error, StackTrace? stackTrace]) {
    _logger.f(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void logPrettyJson(http.Response jsonString,String label) {
    try {
      final jsonObject = jsonDecode(jsonString.body);
      final prettyJson = const JsonEncoder.withIndent('  ').convert(jsonObject);
      Log.info(prettyJson,[label]);
    } catch (e,stackTrace) {
      Log.error("Error parsing JSON: $e",[e,stackTrace]);
    }
  }
}
