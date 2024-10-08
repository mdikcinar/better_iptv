import 'package:betteriptv/core/services/storage/storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService implements StorageService {
  const SecureStorageService(
    this._flutterSecureStorage,
  );

  final FlutterSecureStorage _flutterSecureStorage;

  @override
  Future<String?> read({required String key}) {
    return _flutterSecureStorage.read(
      key: key,
    );
  }

  @override
  Future<void> write({required String key, required String value}) async {
    await _flutterSecureStorage.write(
      key: key,
      value: value,
    );
  }

  @override
  Future<void> clear() async {
    await _flutterSecureStorage.deleteAll();
  }

  @override
  Future<void> delete({required String key}) async {
    await _flutterSecureStorage.delete(key: key);
  }
}
