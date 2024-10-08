import 'package:betteriptv/core/services/logger/logger.dart';
import 'package:betteriptv/di_manager.dart';

abstract class Repository {
  Repository({Logger? logger}) : logger = logger ?? getIt.get<Logger>();

  final Logger logger;
}
