import 'package:betteriptv/core/models/data_result.dart';

abstract class Logger {
  DataResult<S> handleException<S>(Object exception, StackTrace stackTrace);
}
