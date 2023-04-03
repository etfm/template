/// @description:
/// @date: 2023/4/2 15:30
/// @version: 1.0
abstract class EnvBase {
  void init() {
    throw '必须实现此接口';
  }

  void setBaseUrl() {
    throw '必须实现此接口';
  }

  void setEnv() {
    throw '必须实现此接口';
  }
}
