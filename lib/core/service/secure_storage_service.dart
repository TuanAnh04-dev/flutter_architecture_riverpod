import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:px1_mobile/auth/UserAuth.dart';

class SecureStorageService {
  static final SecureStorageService _instance =
      SecureStorageService._internal();

  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      // Sử dụng AES encryption),
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
      // Chỉ truy cập được sau khi unlock lần đầu
    ),
  );

  static const String _keyUserAuth = 'userAuth';
  static const String _keylastMail = 'lastMail';

  //======================== User Auth ===========================

  // Save
  Future<void> saveUserAuth(String userAuth) async {
    try {
      await _secureStorage.write(key: _keyUserAuth, value: userAuth);
    } catch (e) {
      throw Exception('Failed to save user auth: $e');
    }
  }

  // get
  Future<String?> getUserAuth() async {
    try {
      return await _secureStorage.read(key: _keyUserAuth);
    } catch (e) {
      throw Exception('Failed to get user auth: $e');
    }
  }

  //delete
  Future<void> deleteUserAuth() async {
    try {
      await _secureStorage.delete(key: _keyUserAuth);
    } catch (e) {
      throw Exception('Failed to delete user auth: $e');
    }
  }

  //======================== last mail ===========================

  // Save
  Future<void> saveLastMail(String lastMail) async {
    try {
      await _secureStorage.write(key: _keylastMail, value: lastMail);
    } catch (e) {
      throw Exception('Failed to save last mail: $e');
    }
  }

  // get
  Future<String?> getLastMail() async {
    try {
      return await _secureStorage.read(key: _keylastMail);
    } catch (e) {
      throw Exception('Failed to get last mail: $e');
    }
  }

  //delete
  Future<void> deleteLastMail() async {
    try {
      await _secureStorage.delete(key: _keylastMail);
    } catch (e) {
      throw Exception('Failed to delete last mail: $e');
    }
  }

  // ==================== CLEAR DATA ====================
  /// Xóa tất cả dữ liệu khi logout
  Future<void> clearAll() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      throw Exception('Không thể xóa dữ liệu: $e');
    }
  }

  /// Xóa chỉ user auth (giữ lại last email)
  Future<void> clearUserAuth() async {
    try {
      await _secureStorage.delete(key: _keyUserAuth);
    } catch (e) {
      throw Exception('Không thể xóa user auth: $e');
    }
  }
}
