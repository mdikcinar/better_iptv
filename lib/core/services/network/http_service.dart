import 'package:betteriptv/core/services/network/network_response.dart';
import 'package:betteriptv/core/services/network/network_service.dart';
import 'package:http/http.dart' as http;

class HttpService implements NetworkService {
  @override
  Future<NetworkResponse> get(String url) async {
    final response = await http.get(Uri.parse(url));

    return NetworkResponse(
      statusCode: response.statusCode,
      body: response.body,
    );
  }
}
