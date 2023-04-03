import '../cache/cache.dart';
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

  @override
  void setBaseUrl() {
    // TODO: implement setBaseUrl
    Cache.setBaseUrl('http://manager.dev.zhanpeng.space');
  }

  @override
  void setEnv() {
    // TODO: implement setEnv
    Cache.setEnv('production');
  }
}
