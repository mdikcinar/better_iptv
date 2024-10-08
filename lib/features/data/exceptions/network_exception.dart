class NetworkException implements Exception {
  NetworkException({
    required this.statusCode,
    required this.errorBody,
  });

  final int statusCode;
  final String errorBody;
}
