import 'package:betteriptv/core/models/data_result.dart';
import 'package:betteriptv/core/services/logger/logger.dart';
import 'package:betteriptv/di_manager.dart';
import 'package:betteriptv/features/data/exceptions/network_exception.dart';
import 'package:betteriptv/features/data/failures/failures.dart';
import 'package:talker/talker.dart';

class LoggerWithTalker implements Logger {
  LoggerWithTalker({Talker? talker}) : _talker = talker ?? getIt.get<Talker>();

  final Talker _talker;

  @override
  DataResult<S> handleException<S>(Object exception, StackTrace stackTrace) {
    _talker.handle(exception, stackTrace);
    switch (exception.runtimeType) {
      case NetworkException:
        final networkException = exception as NetworkException;
        return DataResult.failure(
          NetworkFailure(
            statusCode: networkException.statusCode,
            errorBody: networkException.errorBody,
          ),
        );
      default:
        return DataResult.failure(GenericFailure(exception.toString()));
    }
  }
}
