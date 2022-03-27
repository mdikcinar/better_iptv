import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'models/storage_model.dart';
import 'storage_key_enums.dart';

class CustomStorageService extends GetxService {
  static GetStorage _storage = GetStorage();

  bool isExist(StorageKeys key) {
    return _storage.hasData(key.toString());
  }

  void remove(StorageKeys key) {
    _storage.remove(key.toString());
  }

  R? readModel<R, T>({required StorageKeys key, required T parseModel}) {
    final cacheData = _storage.read(key.toString());
    if (cacheData == null) return null;
    final json = jsonDecode(cacheData);
    var cacheObject = StorageModel.fromJson<R, T>(json, parseModel);
    return cacheObject.data;
  }

  Future<void> write(StorageKeys key, dynamic data) async {
    var registerModel = StorageModel(
      key: key.toString(),
      data: data,
    );
    final json = jsonEncode(registerModel);
    await _storage.write(key.toString(), json);
  }

  Future<void> cleanStorage() async {
    await _storage.erase();
  }
}
