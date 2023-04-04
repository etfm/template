import 'package:template/config/cache/cache.dart';

import 'env.dart';

/// @description:
/// @date: 2023/4/2 14:23
/// @version: 1.0

final env = Env();

class Env implements EnvBase {
  @override
  Future<dynamic> init() async {
    setBaseUrl();
    setEnv();
  }

  /// 设置路径
  @override
  setBaseUrl() {
    Cache.setBaseUrl('http://manager.dev.zhanpeng.space');
  }

  /// 设置当前环境
  @override
  setEnv() {
    Cache.setEnv('development');
  }
}
