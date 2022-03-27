import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeService extends GetxService {
  Future<String?> getPlaylist(String url) async {
    final response = await http.get(Uri.parse(url));
    return utf8.decode(response.bodyBytes);
  }
}
