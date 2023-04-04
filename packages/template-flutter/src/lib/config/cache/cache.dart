import 'package:sp_util/sp_util.dart';

class LocalStorageKey {
  static const String keyToken = 'keyToken';
  static const String keyUser = 'keyUser';
  static const String keyEnv = 'keyEnv';
  static const String keyBaseUrl = 'keyBaseUrl';
}

class Cache {
  /// 获取token
  static String getToken() {
    return SpUtil.getString(LocalStorageKey.keyToken) ?? '';
  }

  /// 设置token
  static Future<bool>? setToken(String token) {
    return SpUtil.putString(LocalStorageKey.keyToken, token);
  }

  ///保存用户体
  static Future<bool>? setUser(Map<String, dynamic> arg) {
    return SpUtil.putObject(LocalStorageKey.keyUser, arg);
  }

  /// 获取用户体
  static Map getUser() {
    return SpUtil.getObject(LocalStorageKey.keyUser) ?? {};
  }

  static Future<bool>? setEnv(String env) {
    return SpUtil.putString(LocalStorageKey.keyEnv, env);
  }

  static String getEnv() {
    return SpUtil.getString(LocalStorageKey.keyEnv) ?? '';
  }

  static Future<bool>? setBaseUrl(String url) {
    return SpUtil.putString(LocalStorageKey.keyBaseUrl, url);
  }

  static String getBaseUrl() {
    return SpUtil.getString(LocalStorageKey.keyBaseUrl) ?? '';
  }
}
