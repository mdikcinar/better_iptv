import 'package:betteriptv/core/models/failure.dart';

class NetworkFailure extends Failure {
  const NetworkFailure({
    required this.statusCode,
    required this.errorBody,
  }) : super('Network failure: $statusCode, $errorBody');

  final int statusCode;
  final String errorBody;
}
