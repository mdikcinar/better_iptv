import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OnBoardService extends GetxService {
  Future<String?> getPlaylist(String url) async {
    return await http.read(Uri.parse(url));
  }
}
