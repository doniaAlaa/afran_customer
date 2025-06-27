import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Private constructor
  SecureStorageService._internal();

  // Singleton instance
  static final SecureStorageService _instance = SecureStorageService._internal();

  // Factory constructor to return the same instance
  factory SecureStorageService() => _instance;

  // SecureStorage instance (you can customize options if needed)
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Public API methods
  Future<void> write(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }
}
