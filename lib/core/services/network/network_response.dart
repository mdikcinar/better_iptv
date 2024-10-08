class NetworkResponse {
  const NetworkResponse({
    required this.statusCode,
    required this.body,
  });

  final int statusCode;
  final String body;

  bool get isSuccessful => statusCode >= 200 && statusCode < 300;
}
