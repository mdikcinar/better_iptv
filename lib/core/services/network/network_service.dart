import 'package:betteriptv/core/services/network/network_response.dart';

abstract class NetworkService {
  Future<NetworkResponse> get(String url);
}
